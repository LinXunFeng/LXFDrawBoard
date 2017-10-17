//
//  LXFDrawBoard.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFDrawBoard.h"
#import "LXFDoManager.h"
#import "LXFBaseBrush.h"
#import "LXFPencilBrush.h"
#import "LXFTextBrush.h"
#import "LXFMosaicBrush.h"

typedef enum : NSUInteger {
    LXFDrawStatusStart,
    LXFDrawStatusDrawing,
    LXFDrawStatusEnd
} LXFDrawStatus;

@interface LXFDrawBoard()

/** 起始点 */
@property(nonatomic, assign) CGPoint startPoint;
/** 当前点 */
@property(nonatomic, assign) CGPoint currentPoint;
/** doManager */
@property(nonatomic, strong) LXFDoManager *doManager;
/** 当前用来绘画的图片 */
@property(nonatomic, strong) UIImage *curPaintImage;
/** 描述文本数据 */
@property(nonatomic, strong) NSMutableArray<UILabel *> *descLabelArr;
/** 当前选中的描述文本 */
@property(nonatomic, strong) UILabel *curDescLabel;
/** 是否可以绘图 */
@property(nonatomic, assign) BOOL drawable;

/** 绘图状态 */
@property(nonatomic, assign) LXFDrawStatus drawStatus;

/** 绘图专门之ImageView */
@property(nonatomic, strong) UIImageView *drawImageView;

@end

@implementation LXFDrawBoard

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initData];
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        [self initData];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        [self initData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.drawImageView.frame = self.bounds;
}

- (void)initData {
    self.drawable = NO;
    self.userInteractionEnabled = YES;
    self.drawStatus = LXFDrawStatusEnd;
    self.drawImageView = [[UIImageView alloc] initWithImage:self.image];
    self.drawImageView.contentMode = self.contentMode;
    [self addSubview:self.drawImageView];
    
    self.doManager = [[LXFDoManager alloc] initWithOriginImage:self.drawImageView.image];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.startPoint = [[touches anyObject] locationInView:self];
    self.drawStatus = LXFDrawStatusStart;
    
    self.brush.startPoint = self.startPoint;
    
    if (self.brush.class == LXFTextBrush.class) {   // 文本笔刷
        [self drawText];
    } else {
        if ([self haveDescLabelOnClickPoint]) { // 点到文本了，不可绘制
            self.drawable = NO;
        } else {    // 可以绘制了
            self.drawable = YES;
        }
    }
}

- (BOOL)haveDescLabelOnClickPoint {
    BOOL hasFoundLabel = NO;
    
    for (UILabel *label in self.descLabelArr) {
        if (CGRectContainsPoint(label.frame, self.brush.startPoint)) {  // 找着label
            self.curDescLabel = label;
            hasFoundLabel = YES;
        }
    }
    return hasFoundLabel;
}

- (void)drawText {
    
    BOOL hasFoundLabel = [self haveDescLabelOnClickPoint];
    
    // 没找着label
    if (!hasFoundLabel) {
        self.curDescLabel = nil;
    }
    
    if (self.curDescLabel == nil) { // 添加描述文本
        if (self.delegate && [self.delegate respondsToSelector:@selector(LXFDrawBoard:clickDescLabel:)]) {
            [self.delegate LXFDrawBoard:self clickDescLabel:nil];
        }
    }
}

- (void)alterDescLabel {
    NSString *desc = [self.delegate LXFDrawBoard:self textForDescLabel:self.curDescLabel];
    if (!desc.length) {
        if (self.curDescLabel) {
            [self.descLabelArr removeObject:self.curDescLabel];
            [self.curDescLabel removeFromSuperview];
        }
        return;
    }
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    if (!self.curDescLabel) {
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x, self.startPoint.y, screenWidth, screenHeight)];
        descLabel.textColor = [UIColor redColor];
        descLabel.numberOfLines = 0;
        descLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(descLabelTap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(descLabelPan:)];
        [descLabel addGestureRecognizer:tap];
        [descLabel addGestureRecognizer:pan];
        [self addSubview:descLabel];
        self.curDescLabel = descLabel;
        [self.descLabelArr addObject:descLabel];
    }
    self.curDescLabel.text = desc;
    CGSize size = [self.curDescLabel sizeThatFits:CGSizeMake(screenWidth * 0.5, MAXFLOAT)];
    CGRect curDescLabelFrame = self.curDescLabel.frame;
    self.curDescLabel.frame = CGRectMake(curDescLabelFrame.origin.x, curDescLabelFrame.origin.y, size.width, size.height);
}

- (void)descLabelTap:(UITapGestureRecognizer *)tap {
    if (self.delegate && [self.delegate respondsToSelector:@selector(LXFDrawBoard:clickDescLabel:)]) {
        [self.delegate LXFDrawBoard:self clickDescLabel:self.curDescLabel];
    }
}

- (void)descLabelPan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:self.curDescLabel];
    self.curDescLabel.center = CGPointMake(self.curDescLabel.center.x + point.x, self.curDescLabel.center.y + point.y);
    [pan setTranslation:CGPointZero inView:self.curDescLabel];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.drawable) {   // 描述文本，不可绘制
        return;
    }
    
    self.currentPoint = [[touches anyObject] locationInView:self];
    self.drawStatus = LXFDrawStatusDrawing;
    self.drawable = YES;
    
    self.brush.endPoint = self.currentPoint;
    
    // 开始绘图
    [self drawImage];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (!self.drawable) return;
    self.drawStatus = LXFDrawStatusEnd;
    // 主要用来保存图片
    [self drawImage];
    // 重置笔刷是否存在上个点
    self.brush.hasLastPoint = NO;
    self.drawable = NO;;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchesEndedWithLXFDrawBoard:)]) {
        [self.delegate touchesEndedWithLXFDrawBoard:self];
    }
    
    // 重置当前绘图图像，主要是修复马赛克的bug
    self.curPaintImage = [self snapsHotView:self];
    self.drawImageView.image = self.curPaintImage;
}

#pragma mark - 事件处理
#pragma mark 撤销
- (void)revoke {
    if (!self.canRevoke) return;
    
    self.drawImageView.image = [self.doManager imageForRevoke];
    self.curPaintImage = self.drawImageView.image;
}

#pragma mark 反撤销
- (void)redo {
    if (!self.canRedo) return;
    
    self.drawImageView.image = [self.doManager imageForRedo];
    self.curPaintImage = self.drawImageView.image;
}

- (UIImage *)curPaintImage {
    if (!_curPaintImage) {
        _curPaintImage = self.drawImageView.image;
    }
    return _curPaintImage;
}

#pragma mark 画图(核心操作)
- (void)drawImage {
    if (!self.brush) return;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.brush.isFill) {
        [[self colorOfPoint:self.currentPoint] setFill];
    } else {
        [[UIColor clearColor] setFill];
    }
    UIRectFill(self.bounds);
    CGContextSetLineWidth(ctx, self.style.lineWidth);
    [self.style.lineColor setStroke];
    
    // 将最后保存的绘图图片绘制到context
    [self.curPaintImage drawInRect:self.bounds];
    
    [self.brush drawInContext:ctx];
    CGContextStrokePath(ctx);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    self.drawImageView.image = image;
    if (self.brush.keepDrawing) {
        self.curPaintImage = image;
    }
    
    if (self.drawStatus == LXFDrawStatusEnd) {
        [self.doManager addImage:image];
        self.curPaintImage = image;
    }
    
    self.brush.lastPoint = self.brush.endPoint;
    self.brush.hasLastPoint = YES;
}

// 获取某点的颜色
- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}

#pragma mark - lazy
- (LXFDrawBoardStyle *)style {
    if (!_style) {
        _style = [LXFDrawBoardStyle new];
        _style.lineWidth = 2;
        _style.lineColor = [UIColor redColor];
    }
    return _style;
}

#pragma mark - getter
- (BOOL)canRevoke {
    return self.doManager.canRevoke;
}

- (BOOL)canRedo {
    return self.doManager.canRedo;
}

#pragma mark - lazy
- (NSMutableArray<UILabel *> *)descLabelArr {
    if (!_descLabelArr) {
        _descLabelArr = [NSMutableArray array];
    }
    return _descLabelArr;
}

#pragma mark - private method
- (UIImage *)snapsHotView:(UIView *)view
{
    // 影响质量
//    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES,[UIScreen mainScreen].scale);
//    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end



