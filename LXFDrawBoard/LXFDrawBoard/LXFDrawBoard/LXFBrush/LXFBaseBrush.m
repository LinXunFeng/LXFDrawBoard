//
//  LXFBaseBrush.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFBaseBrush.h"

@implementation LXFBaseBrush

// 子类重写以下两个方法
- (void)drawInContext:(CGContextRef)ctx {
}
- (BOOL)keepDrawing {
    return NO;
}

@end
