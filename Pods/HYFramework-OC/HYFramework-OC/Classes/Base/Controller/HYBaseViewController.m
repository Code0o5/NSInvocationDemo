//
//  HYBaseViewController.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "HYBaseViewController.h"
#import "HYFramework.h"

@interface HYBaseViewController ()

#pragma mark - 导航栏相关
// viewWillAppear记录导航栏状态 viewWillDisappear恢复，防止影响其他控制器显示
@property (nonatomic, assign) BOOL navOriginHiddenState;

@end

@implementation HYBaseViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 子视图设置
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 记录导航栏的显示状态
    self.navOriginHiddenState = self.navigationController.navigationBarHidden;
    
    // 去掉导航栏下面自带的线条
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复导航栏进入该页面时的显示状态
    self.navigationController.navigationBarHidden = self.navOriginHiddenState;
}

#pragma mark - 设置子视图
// 子视图设置
- (void)setupSubviews
{
    // 默认背景浅灰色
    self.view.backgroundColor = HYColorBgLight1;
    

    // 设置返回按钮
//    self.navigationItem.backBarButtonItem = self.backButtonItem;
//    self.navigationItem.backBarButtonItem = self.backButtonItem;
//    if (self.navigationController) {
//        if (self.navigationController.viewControllers.count > 1) {
//            [self.navigationItem setLeftBarButtonItem:self.backButtonItem];
//        }
//    }
    
    // 导航栏状态设置
    self.navigationController.navigationBarHidden = self.navBarHidden;
}

#pragma mark - 事件
// 返回
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter


#pragma mark - 其他
/**
 如果是表单类型控制器，提交前需校验所有内容是否都填写完成
 * 哪一项内容没有填写,返回提示用户填写该项信息的文本,否则返回 nil
 */
- (NSString *)checkBeforeCommit
{
    return nil;
}

#pragma mark - 懒加载
// 获取导航控制器
- (HYNavigationController *)navController
{
    return self.navigationController;
}


@end
