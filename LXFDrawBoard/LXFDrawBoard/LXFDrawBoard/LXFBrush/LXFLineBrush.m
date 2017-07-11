//
//  LXFLineBrush.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFLineBrush.h"

@implementation LXFLineBrush

- (void)drawInContext:(CGContextRef)ctx {
    CGContextMoveToPoint(ctx, self.startPoint.x, self.startPoint.y);
    CGContextAddLineToPoint(ctx, self.endPoint.x, self.endPoint.y);
}

- (BOOL)keepDrawing {
    return NO;
}

@end
