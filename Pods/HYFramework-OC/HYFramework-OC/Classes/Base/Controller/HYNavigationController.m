//
//  HYNavigationController.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/1.
//

#import "HYNavigationController.h"
#import "HYFramework.h"

@interface HYNavigationController ()

// 返回按钮
@property (nonatomic, strong) UIBarButtonItem *backItem;

@end

@implementation HYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置默认属性值
    [self setupDefaultPropertys];
}

/**
 * 防止导航控制器里面子控制器该方法被覆盖，导致单独设置某一个控制器的状态栏样式没有效果
 * 要指定单个控制器内状态栏样式需要在plist中设置 View controller-based status bar appearance 为YES
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

// 重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 返回按钮
        viewController.navigationItem.leftBarButtonItem = self.backItem;
    }else {
        viewController.navigationItem.leftBarButtonItem = nil;
    }
     self.interactivePopGestureRecognizer.enabled = YES;
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 事件
// 返回
- (void)backAction
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - 其他
// 设置默认属性值
- (void)setupDefaultPropertys
{
    // 默认导航栏样式
    self.navBarGlobalStyle = HYNavBarStyleBlue;
}

// 获取图片
- (UIImage *)podsImageWithName:(NSString *)imageName
{
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/HYFramework-OC.bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    return [UIImage imageNamed:imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
}


#pragma mark - setter
// 是否隐藏导航栏下自带的线条,默认YES
- (void)setHiddenNavBottomLine:(BOOL)hiddenNavBottomLine
{
    _hiddenNavBottomLine = hiddenNavBottomLine;
    if (hiddenNavBottomLine) {
        if([HYDeviceTool deviceSystemVersion] >= 11.0){
            [self.navigationBar setShadowImage:[UIImage new]];
        }else{
            NSArray *list = self.navigationBar.subviews;
            for (id obj in list) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    UIImageView *imageView2=(UIImageView *)obj2;
                    if (imageView2.frame.size.height < 1.0) {
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

// 设置导航栏样式
- (void)setNavBarGlobalStyle:(HYNavBarStyle)navBarGlobalStyle
{
    _navBarGlobalStyle = navBarGlobalStyle;
    
    switch (navBarGlobalStyle) {
        case HYNavBarStyleLight:
            // 浅色
            // 全局导航栏背景色
            self.navBarGlobalBgColor = HYColorBgLight2;
            // 标题颜色和大小
            self.navBarGlobalTitleFont = HYFontBold(18);
            self.navBarGlobalTitleColor = HYColorTextNormal;
            // 返回按钮图片
            self.navBarGlobalBackImage = [self podsImageWithName:@"返回"];
            break;
        case HYNavBarStyleBlue:
            // 蓝色背景
            // 全局导航栏背景色
            self.navBarGlobalBgColor = HYColorTheme3;
            // 标题颜色和大小
            self.navBarGlobalTitleFont = HYFontBold(18);
            self.navBarGlobalTitleColor = HYColorWhite;
            // 返回按钮图片
            self.navBarGlobalBackImage = [self podsImageWithName:@"返回1"];
            
            break;
        case HYNavBarStyleDark:
            // 深色
            
            break;
        default:
            break;
    }
}

// 全局导航栏背景色
- (void)setNavBarGlobalBgColor:(UIColor *)navBarGlobalBgColor
{
    _navBarGlobalBgColor = navBarGlobalBgColor;
    
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:navBarGlobalBgColor size:CGSizeMake(1.0, 1.0)] forBarMetrics:UIBarMetricsDefault];
}

// 全局导航栏标题文字大小
- (void)setNavBarGlobalTitleFont:(UIFont *)navBarGlobalTitleFont
{
    _navBarGlobalTitleFont = navBarGlobalTitleFont;
    
    if (navBarGlobalTitleFont == nil) return;
    
    if (self.navBarGlobalTitleColor) {
        self.navigationBar.titleTextAttributes = @{
            NSForegroundColorAttributeName:self.navBarGlobalTitleColor,
            NSFontAttributeName:navBarGlobalTitleFont
        };
    }else {
        self.navigationBar.titleTextAttributes = @{
            NSFontAttributeName:navBarGlobalTitleFont
        };
    }
}

// 全局导航栏标题文字颜色
- (void)setNavBarGlobalTitleColor:(UIColor *)navBarGlobalTitleColor
{
    _navBarGlobalTitleColor = navBarGlobalTitleColor;
    
    if (navBarGlobalTitleColor == nil) return;
    
    if (self.navBarGlobalTitleFont) {
        self.navigationBar.titleTextAttributes = @{
            NSForegroundColorAttributeName:navBarGlobalTitleColor,
            NSFontAttributeName:self.navBarGlobalTitleFont
        };
    }else {
        self.navigationBar.titleTextAttributes = @{
            NSForegroundColorAttributeName:navBarGlobalTitleColor
        };
    }
}

// 返回按钮图标
- (void)setNavBarGlobalBackImage:(UIImage *)navBarGlobalBackImage
{
    _navBarGlobalBackImage = navBarGlobalBackImage;
    
    self.backItem.image = [navBarGlobalBackImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

// 返回按钮
- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
    return _backItem;
}

@end
