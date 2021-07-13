//
//  MBProgressHUD+HYAdd.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "MBProgressHUD+HYAdd.h"

@implementation MBProgressHUD (HYAdd)


/**
 *  显示信息
 *
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject].rootViewController.view;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 消失
    [hud hideAnimated:YES afterDelay:[self displayDurationForString:text]];
}


+ (void)showInfo:(NSString *)Info{
    [self showInfo:Info toView:nil];
}

+ (void)showInfo:(NSString *)Info completeBlock:(HYBlockWithArgument)complete{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.51 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(nil);
            }
        });
    });
    [self showInfo:Info toView:nil];
}

+ (void)showInfo:(NSString *)Info toView:(UIView *)view{
    [self show:Info icon:@"info.png" view:view];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param complete 回调
 */
+ (void)showSuccess:(NSString *)success completeBlock:(HYBlockWithArgument)complete{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.51 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(nil);
            }
        });
    });
    [self showSuccess:success toView:nil];
}

/**
 *  显示成功信息
 *
 *  @param success 信息内容
 *  @param view    显示信息的视图
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

/**
 *  显示错误信息
 *
 */
+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}
/**
 *  显示错误信息
 *
 */

+ (void)showError:(NSString *)error completeBlock:(HYBlockWithArgument)complete {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.51 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(nil);
            }
        });
    });
    [self showError:error toView:nil];
}

/**
 *  显示错误信息
 *
 *  @param error 错误信息内容
 *  @param view  需要显示信息的视图
 */
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

/**
 *  显示信息
 *
 *  @param message 信息内容
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject].rootViewController.view;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}


/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD{
    [self hideHUDForView:nil];
}

/**
 *  手动关闭MBProgressHUD
 *
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject].rootViewController.view;
    [self hideHUDForView:view animated:YES];
}


+ (NSTimeInterval)displayDurationForString:(NSString*)string {
    CGFloat minimum = MAX((CGFloat)string.length * 0.06 + 0.5, 3);
    return MIN(minimum, 4);
}

@end
