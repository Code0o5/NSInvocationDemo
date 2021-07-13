//
//  UIViewController+HYAlert.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYAlert)

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
          btnActionBlocks:(NSArray <void (^)(void)>*_Nullable)btnActionBlocks;

// 显示提示框
- (void)showTipAlertWithTitle:(NSString *)title message:(NSString *)message;

// 显示提示框
- (void)showTipAlertWithMessage:(NSString *)message;

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
                  showCancelBtn:(BOOL)showCancelBtn;

@end

NS_ASSUME_NONNULL_END
