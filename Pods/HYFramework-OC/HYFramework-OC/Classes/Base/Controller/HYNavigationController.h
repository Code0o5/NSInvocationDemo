//
//  HYNavigationController.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HYNavBarStyle) {
    HYNavBarStyleLight, // 浅色样式
    HYNavBarStyleBlue,  // 蓝色背景样式
    HYNavBarStyleDark,  // 深色样式
};

@interface HYNavigationController : UINavigationController

// 是否隐藏导航栏下自带的线条,默认YES
@property (nonatomic, assign) BOOL hiddenNavBottomLine;

#pragma mark - 导航栏样式
// 导航栏样式
@property (nonatomic, assign) HYNavBarStyle navBarGlobalStyle;

// 全局导航栏背景色
@property (nonatomic, strong) UIColor *navBarGlobalBgColor;

// 全局导航栏标题文字大小
@property (nonatomic, strong) UIFont *navBarGlobalTitleFont;

// 全局导航栏标题文字颜色
@property (nonatomic, strong) UIColor *navBarGlobalTitleColor;

// 返回按钮图标
@property (nonatomic, strong) UIImage *navBarGlobalBackImage;

@end

NS_ASSUME_NONNULL_END
