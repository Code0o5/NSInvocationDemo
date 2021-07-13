//
//  UIViewController+HYAlert.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "UIViewController+HYAlert.h"

@implementation UIViewController (HYAlert)

#pragma mark - 弹窗
/**
 提示弹窗
 @param title 标题
 @param message 提示内容
 @param btnTitles 按钮标题集合
 @param btnActionBlocks 按钮点击回调集合
 */
-(void)showAlertWithTitle:(NSString *_Nullable)title
                  message:(NSString *_Nullable)message
                btnTitles:(NSArray <NSString *>*_Nullable)btnTitles
          btnActionBlocks:(NSArray <void (^)(void)>*_Nullable)btnActionBlocks
{
    UIAlertController *alerC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i < btnTitles.count; i++) {
        NSString *btnT = btnTitles[i];
        void (^actionBlock)(void) = nil;
        // 按照顺序去除点击回调
        if (i < btnActionBlocks.count) {
            actionBlock = btnActionBlocks[i];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 点击回调
            if (actionBlock) {
                actionBlock();
            }
        }];
        [alerC addAction:action];
    }
    
    [self presentViewController:alerC animated:YES completion:nil];
}

// 显示提示框
- (void)showTipAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [self showAlertWithTitle:title message:message btnTitles:@[@"确定"] btnActionBlocks:@[^{}]];
}

// 显示提示框
- (void)showTipAlertWithMessage:(NSString *)message
{
    [self showTipAlertWithTitle:nil message:message];
}

/**
 选择actionSheet
 @param title 标题
 @param btnTitles 按钮标题集合
 @param btnActionBlocks 按钮点击回调集合
 @param showCancelBtn 是否显示取消按钮
 */
-(void)showActionSheetWithTitle:(NSString *_Nullable)title
                      btnTitles:(NSArray <NSString *>*_Nullable)btnTitles
                btnActionBlocks:(NSArray <void (^)(void)>*_Nullable)btnActionBlocks
                  showCancelBtn:(BOOL)showCancelBtn
{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < btnTitles.count; i++) {
        NSString *btnT = btnTitles[i];
        void (^actionBlock)(void) = nil;
        // 按照顺序去除点击回调
        if (i < btnActionBlocks.count) {
            actionBlock = btnActionBlocks[i];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnT style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 点击回调
            if (actionBlock) {
                actionBlock();
            }
        }];
        [actionSheet addAction:action];
    }
    
    if (showCancelBtn) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [actionSheet addAction:cancelAction];
    }
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

@end
