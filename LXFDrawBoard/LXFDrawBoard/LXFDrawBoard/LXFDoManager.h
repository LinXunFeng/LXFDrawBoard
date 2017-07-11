//
//  LXFDoManager.h
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import <UIKit/UIKit.h>

@interface LXFDoManager : NSObject

/** 是否可以撤销 */
@property(nonatomic, assign) BOOL canRevoke;
/** 是否可以反撤销 */
@property(nonatomic, assign) BOOL canRedo;

- (instancetype)initWithOriginImage:(UIImage *)originImage;

// 添加图片
- (void)addImage:(UIImage *)image;
// 撤销
- (UIImage *)imageForRevoke;
// 反撤销
- (UIImage *)imageForRedo;

@end
