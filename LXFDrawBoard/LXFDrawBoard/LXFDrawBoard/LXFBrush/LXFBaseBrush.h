//
//  LXFBaseBrush.h
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import <UIKit/UIKit.h>

@interface LXFBaseBrush : NSObject

/** startPoint */
@property(nonatomic, assign) CGPoint startPoint;
/** endPoint */
@property(nonatomic, assign) CGPoint endPoint;
/** lastPoint */
@property(nonatomic, assign) CGPoint lastPoint;
/** 是否有lastPoint */
@property(nonatomic, assign) BOOL hasLastPoint;
/** lineWidth */
@property(nonatomic, assign) CGFloat lineWidth;
/** 是否使用填充 */
@property(nonatomic, assign) BOOL isFill;

/** 是否连续绘制 */
@property(nonatomic, assign) BOOL keepDrawing;

// 笔刷专用绘图上下文
- (void)drawInContext:(CGContextRef)ctx;

@end
