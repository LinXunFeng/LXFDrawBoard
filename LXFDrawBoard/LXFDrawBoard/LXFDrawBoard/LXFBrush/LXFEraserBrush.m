//
//  LXFEraserBrush.m
//  LXFDrawBoard
//
//  Created by 林洵锋 on 2017/9/25.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import "LXFEraserBrush.h"
#import <objc/runtime.h>

@implementation LXFEraserBrush

- (void)drawInContext:(CGContextRef)ctx {
    
    CGContextSetBlendMode(ctx, kCGBlendModeClear);
    [super drawInContext:ctx];
}


@end
