//
//  HYBaseViewController.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>
#import "HYNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseViewController : UIViewController

#pragma mark - 导航控制器
// 是否隐藏导航栏
@property (nonatomic, weak) HYNavigationController *navController;


#pragma mark - 导航栏相关
// 是否隐藏导航栏
@property (nonatomic, assign) BOOL navBarHidden;

#pragma mark - 设置子视图
// 子视图设置
- (void)setupSubviews;

#pragma mark - 其他

/**
 如果是表单类型控制器，提交前需校验所有内容是否都填写完成
 * 哪一项内容没有填写,返回提示用户填写该项信息的文本,否则返回 nil
 */
- (NSString *)checkBeforeCommit;

@end

NS_ASSUME_NONNULL_END
