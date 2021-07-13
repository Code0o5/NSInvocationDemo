//
//  UINavigationController+HYAdd.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYNavigation)

// 是否隐藏导航栏
@property (nonatomic, assign) BOOL navBarHidden;

// 返回按钮
@property (nonatomic, strong) UIBarButtonItem *backButtonItem;

// 返回按钮图片
@property (nonatomic, strong) UIImageView *backImgV;


// push
- (void)pushWithCotroller:(UIViewController *_Nullable)ctr animated:(BOOL)animated;

// push
- (void)pushWithCotroller:(UIViewController *_Nullable)ctr;

@end

NS_ASSUME_NONNULL_END
