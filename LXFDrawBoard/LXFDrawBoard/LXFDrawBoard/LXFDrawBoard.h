//
//  LXFDrawBoard.h
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//
//  GitHub: https://github.com/LinXunFeng
//  简书: http://www.jianshu.com/users/31e85e7a22a2

#import <UIKit/UIKit.h>
#import "LXFPencilBrush.h"
#import "LXFRectangleBrush.h"
#import "LXFLineBrush.h"
#import "LXFArrowBrush.h"
#import "LXFTextBrush.h"
#import "LXFDrawBoardStyle.h"

@class LXFBaseBrush;
@class LXFDrawBoard;

@protocol LXFDrawBoardDelegate <NSObject>

- (NSString *)LXFDrawBoard:(LXFDrawBoard *)drawBoard textForDescLabel:(UILabel *)descLabel;
- (void)LXFDrawBoard:(LXFDrawBoard *)drawBoard clickDescLabel:(UILabel *)descLabel;

@optional
- (void)touchesEndedWithLXFDrawBoard:(LXFDrawBoard *)drawBoard;

@end

@interface LXFDrawBoard : UIImageView

/** 代理 */
@property(nonatomic, weak) id<LXFDrawBoardDelegate> delegate;

/** 是否可以撤销 */
@property(nonatomic, assign) BOOL canRevoke;
/** 是否可以反撤销 */
@property(nonatomic, assign) BOOL canRedo;
/** 笔刷 */
@property(nonatomic, strong) LXFBaseBrush *brush;
/** 样式 */
@property(nonatomic, strong) LXFDrawBoardStyle *style;

- (void)revoke;
- (void)redo;

/** 触发更新描述文本 */
- (void)alterDescLabel;

@end
