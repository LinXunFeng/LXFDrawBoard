//
//  LXFArrowBrush.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFArrowBrush.h"

@implementation LXFArrowBrush

- (void)drawInContext:(CGContextRef)ctx {
    
    CGFloat length = 0;
    CGFloat angle = [self angleWithFirstPoint:self.startPoint andSecondPoint:self.endPoint];
    CGPoint pointMiddle = CGPointMake((self.startPoint.x+self.endPoint.x)/2, (self.startPoint.y+self.endPoint.y)/2);
    CGFloat offsetX = length*cos(angle);
    CGFloat offsetY = length*sin(angle);
    CGPoint pointMiddle1 = CGPointMake(pointMiddle.x-offsetX, pointMiddle.y-offsetY);
    CGPoint pointMiddle2 = CGPointMake(pointMiddle.x+offsetX, pointMiddle.y+offsetY);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:pointMiddle1];
    [path moveToPoint:pointMiddle2];
    [path addLineToPoint:self.endPoint];
    [path appendPath:[self createArrow]];
    
    CGContextAddPath(ctx, path.CGPath);
}

- (UIBezierPath *)createArrow {
    CGPoint controllPoint = CGPointZero;
    CGPoint pointUp = CGPointZero;
    CGPoint pointDown = CGPointZero;
    CGFloat distance = [self distanceBetweenStartPoint:self.startPoint endPoint:self.endPoint];
    CGFloat distanceX = 8.0 * (ABS(self.endPoint.x - self.startPoint.x) / distance);
    CGFloat distanceY = 8.0 * (ABS(self.endPoint.y - self.startPoint.y) / distance);
    CGFloat distX = 4.0 * (ABS(self.endPoint.y - self.startPoint.y) / distance);
    CGFloat distY = 4.0 * (ABS(self.endPoint.x - self.startPoint.x) / distance);
    
    if (self.endPoint.x >= self.startPoint.x) {
        if (self.endPoint.y >= self.startPoint.y)
        {
            controllPoint = CGPointMake(self.endPoint.x - distanceX, self.endPoint.y - distanceY);
            pointUp = CGPointMake(controllPoint.x + distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x - distX, controllPoint.y + distY);
        }
        else
        {
            controllPoint = CGPointMake(self.endPoint.x - distanceX, self.endPoint.y + distanceY);
            pointUp = CGPointMake(controllPoint.x - distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x + distX, controllPoint.y + distY);
        }
    } else {
        if (self.endPoint.y >= self.startPoint.y)
        {
            controllPoint = CGPointMake(self.endPoint.x + distanceX, self.endPoint.y - distanceY);
            pointUp = CGPointMake(controllPoint.x - distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x + distX, controllPoint.y + distY);
        }
        else
        {
            controllPoint = CGPointMake(self.endPoint.x + distanceX, self.endPoint.y + distanceY);
            pointUp = CGPointMake(controllPoint.x + distX, controllPoint.y - distY);
            pointDown = CGPointMake(controllPoint.x - distX, controllPoint.y + distY);
        }
    }
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    [arrowPath moveToPoint:self.endPoint];
    [arrowPath addLineToPoint:pointDown];
    [arrowPath addLineToPoint:pointUp];
    [arrowPath addLineToPoint:self.endPoint];
    return arrowPath;
}

- (BOOL)keepDrawing {
    return NO;
}

- (BOOL)isFill {
    return YES;
}

#pragma mark - 计算
- (CGFloat)distanceBetweenStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGFloat xDist = endPoint.x - startPoint.x;
    CGFloat yDist = endPoint.y - startPoint.y;
    return sqrt(pow(xDist, 2) + pow(yDist, 2));
}
- (CGFloat)angleWithFirstPoint:(CGPoint)firstPoint andSecondPoint:(CGPoint)secondPoint
{
    CGFloat dx = secondPoint.x - firstPoint.x;
    CGFloat dy = secondPoint.y - firstPoint.y;
    CGFloat angle = atan2f(dy, dx);
    return angle;
}

@end
