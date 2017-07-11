//
//  LXFRectangleBrush.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFRectangleBrush.h"

@implementation LXFRectangleBrush

- (void)drawInContext:(CGContextRef)ctx {
    
    CGFloat x = self.startPoint.x < self.endPoint.x ? self.startPoint.x : self.endPoint.x;
    CGFloat y = self.startPoint.y < self.endPoint.y ? self.startPoint.y : self.endPoint.y;
    CGFloat width = fabs(self.startPoint.x - self.endPoint.x);
    CGFloat height = fabs(self.startPoint.y - self.endPoint.y);
    
    CGContextAddRect(ctx, CGRectMake(x, y, width, height));
}

- (BOOL)keepDrawing {
    return NO;
}

@end
