//
//  UINavigationController+HYAdd.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/13.
//

#import "UIViewController+HYNavigation.h"
#import <objc/runtime.h>
#import "HYConstMacro.h"
#import "Masonry.h"

static char HYNavBarHiddenKey;
static char HYBackItemKey;
static char HYBackImageKey;


@implementation UIViewController (HYNavigation)


// push
- (void)pushWithCotroller:(UIViewController *)ctr animated:(BOOL)animated
{
    ctr.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ctr animated:animated];
}

// push
- (void)pushWithCotroller:(UIViewController *)ctr
{
    [self pushWithCotroller:ctr animated:YES];
}

#pragma mark - 关联属性
- (UIImageView *)backImgV
{
    UIImageView *backImgv = objc_getAssociatedObject(self, &HYBackImageKey);
    if (backImgv == nil) {
        backImgv = [[UIImageView alloc]initWithImage:HYImageNamed(@"back")];
        backImgv.frame = CGRectMake(0, 0, 20, 20);
        self.backImgV = backImgv;
    }
    return backImgv;
}
- (void)setBackImgV:(UIImageView *)backImgV
{
    objc_setAssociatedObject(self, &HYBackImageKey, backImgV, OBJC_ASSOCIATION_RETAIN);
}

- (UIBarButtonItem *)backButtonItem
{
    UIBarButtonItem *backItem = objc_getAssociatedObject(self, &HYBackItemKey);
    if (backItem == nil) {
        backItem = [[UIBarButtonItem alloc]initWithCustomView:self.backImgV];
        self.backButtonItem = backItem;
    }
    return backItem;
}
- (void)setBackButtonItem:(UIBarButtonItem *)backButtonItem
{
    objc_setAssociatedObject(self, &HYBackItemKey, backButtonItem, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)navBarHidden
{
    NSNumber *num = objc_getAssociatedObject(self, &HYNavBarHiddenKey);
    return [num boolValue];
}
- (void)setNavBarHidden:(BOOL)navBarHidden
{
    self.navigationController.navigationBarHidden = navBarHidden;
    
    objc_setAssociatedObject(self, &HYNavBarHiddenKey, [NSNumber numberWithBool:navBarHidden], OBJC_ASSOCIATION_RETAIN);
}

@end
