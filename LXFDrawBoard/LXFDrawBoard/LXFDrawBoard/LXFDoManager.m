//
//  LXFDoManager.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFDoManager.h"


static NSInteger imageIndex = -1; // 当前所选图标下标

@interface LXFDoManager()

/** 原始图片 */
@property(nonatomic, strong) UIImage *originImage;
/** 图片数组 */
@property(nonatomic, strong) NSMutableArray<UIImage *> *imageArr;
/** 是否撤销过 */
@property(nonatomic, assign) BOOL hasRevoked;

@end

@implementation LXFDoManager

- (instancetype)initWithOriginImage:(UIImage *)originImage {
    if (self = [super init]) {
        self.originImage = originImage;
    }
    return self;
}

- (BOOL)canRevoke {
    return imageIndex >= 0;
}

- (BOOL)canRedo {
    return imageIndex + 1 < self.imageArr.count;
}

// 添加图片
- (void)addImage:(UIImage *)image {
    if (self.hasRevoked) {  // 撤销后再画的图
        NSMutableArray *newArr = [NSMutableArray array];
        for (int i = 0; i<imageIndex + 1; i++) {
            [newArr addObject:self.imageArr[i]];
        }
        self.imageArr = newArr;
        self.hasRevoked = NO;
    }
    
    if (imageIndex == -1) { // 已经是撤销到没有图的时候，清空图片数组
        [self.imageArr removeAllObjects];
    }
    
    [self.imageArr addObject:image];
    imageIndex = self.imageArr.count - 1;
}

// 撤销
- (UIImage *)imageForRevoke {
    self.hasRevoked = YES;
    imageIndex -= 1;
    if (imageIndex >= 0) {
        return self.imageArr[imageIndex];
    } else {
        imageIndex = -1;
        return self.originImage;
    }
}
// 反撤销
- (UIImage *)imageForRedo {
    self.hasRevoked = NO;
    imageIndex += 1;
    //    NSLog(@"imageIndex -- redo : %ld", imageIndex);
    
    if (imageIndex <= self.imageArr.count - 1) {
        return self.imageArr[imageIndex];
    } else {
        imageIndex = self.imageArr.count - 1;
        return self.imageArr[imageIndex - 1];
    }
}


#pragma mark - lazy
- (NSMutableArray<UIImage *> *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSMutableArray<UIImage *> array];
    }
    return _imageArr;
}

@end
