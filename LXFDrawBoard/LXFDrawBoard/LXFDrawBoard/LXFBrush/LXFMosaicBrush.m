//
//  LXFMosaicBrush.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/11.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFMosaicBrush.h"

@implementation LXFMosaicBrush

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat mosaicWH = 10;
    CGFloat pointX, pointY;
    if (fabs(self.endPoint.x - self.startPoint.x) > mosaicWH) {
        pointX = self.endPoint.x;
    } else {
        pointX = self.startPoint.x;
    }
    if (fabs(self.endPoint.y - self.startPoint.y) > mosaicWH) {
        pointY = self.endPoint.y;
    } else {
        pointY = self.startPoint.y;
    }
    CGContextFillRect(ctx, CGRectMake(pointX, pointY, mosaicWH, mosaicWH));
}

- (BOOL)keepDrawing {
    return YES;
}

- (BOOL)isFill {
    return YES;
}


@end
