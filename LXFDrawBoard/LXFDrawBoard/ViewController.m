//
//  ViewController.m
//  LXFDrawBoard
//
//  Created by LXF on 2017/7/6.
//  Copyright © 2017年 LXF. All rights reserved.
//

#import "ViewController.h"
#import "LXFDrawBoard.h"
#import "LXFRectangleBrush.h"
#import "LXFLineBrush.h"
#import "LXFArrowBrush.h"
#import "LXFTextBrush.h"
#import "LXFMosaicBrush.h"
#import "LXFEraserBrush.h"

@interface ViewController () <LXFDrawBoardDelegate>

/** board */
@property (weak, nonatomic) IBOutlet LXFDrawBoard *board;
/** 描述 */
@property(nonatomic, copy) NSString *desc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.board.brush = [LXFRectangleBrush new];
//    self.board.brush = [LXFLineBrush new];
//    self.board.brush = [LXFArrowBrush new];
//    self.board.brush = [LXFTextBrush new];
    
    self.board.delegate = self;
}

- (IBAction)revoke {
    [self.board revoke];
}
- (IBAction)redo {
    [self.board redo];
}

- (IBAction)pencilBrush {
    self.board.brush = [LXFPencilBrush new];
    self.board.style.lineWidth = 2;
}
- (IBAction)arrowBrush {
    self.board.brush = [LXFArrowBrush new];
    self.board.style.lineWidth = 2;
}
- (IBAction)lineBrush {
    self.board.brush = [LXFLineBrush new];
    self.board.style.lineWidth = 2;
}
- (IBAction)textBrush {
    self.board.brush = [LXFTextBrush new];
    self.board.style.lineWidth = 2;
}
- (IBAction)rectangleBrush {
    self.board.brush = [LXFRectangleBrush new];
    self.board.style.lineWidth = 2;
}
- (IBAction)mosaicBrush {
    self.board.brush = [LXFMosaicBrush new];
    self.board.style.lineWidth = 2;
}
- (IBAction)eraserBrush {
    self.board.brush = [LXFEraserBrush new];
    // 调整笔刷大小
    self.board.style.lineWidth = 10;
}

#pragma mark - LXFDrawBoardDelegate
- (NSString *)LXFDrawBoard:(LXFDrawBoard *)drawBoard textForDescLabel:(UILabel *)descLabel {
    
//    return [NSString stringWithFormat:@"我的随机数：%d", arc4random_uniform(256)];
    return self.desc;
}

- (void)LXFDrawBoard:(LXFDrawBoard *)drawBoard clickDescLabel:(UILabel *)descLabel {
    descLabel ? self.desc = descLabel.text: nil;
    [self alterDrawBoardDescLabel];
}

- (void)alterDrawBoardDescLabel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加描述" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.desc = alertController.textFields.firstObject.text;
        [self.board alterDescLabel];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        textField.text = self.desc;
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


@end
