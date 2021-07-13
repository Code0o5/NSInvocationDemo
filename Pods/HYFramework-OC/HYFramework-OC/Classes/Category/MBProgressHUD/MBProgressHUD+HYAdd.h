//
//  MBProgressHUD+HYAdd.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "HYConstMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (HYAdd)

+ (void)showInfo:(NSString *)Info;
+ (void)showInfo:(NSString *)Info completeBlock:(HYBlockWithArgument)complete;
+ (void)showInfo:(NSString *)Info toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success completeBlock:(HYBlockWithArgument)complete;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;


+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error completeBlock:(HYBlockWithArgument)complete;
+ (void)showError:(NSString *)error toView:(UIView *)view;


+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
