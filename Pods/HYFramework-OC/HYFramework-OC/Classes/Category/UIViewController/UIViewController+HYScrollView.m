//
//  UIViewController+HYScrollView.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/13.
//

#import "UIViewController+HYScrollView.h"
#import <objc/runtime.h>
#import "Masonry.h"


static char HYScrollViewKey;
static char HYScrollContentViewKey;

@implementation UIViewController (HYScrollView)

#pragma mark - 添加scroll
// 添加scrollView
- (void)setupScrollView
{
    [self.view addSubview:self.scrollV];
    [self.scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [self.scrollV addSubview:self.scrollContentView];
    [self.scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollV);
        make.width.mas_equalTo(self.scrollV);
    }];
}

#pragma mark - 关联属性
- (UIScrollView *)scrollV
{
    UIScrollView *scrollV = objc_getAssociatedObject(self, &HYScrollViewKey);
    if (scrollV == nil) {
        scrollV = [[UIScrollView alloc]init];
        self.scrollV = scrollV;
    }
    return scrollV;
}
- (void)setScrollV:(UIScrollView *)scrollV
{
    objc_setAssociatedObject(self, &HYScrollViewKey, scrollV, OBJC_ASSOCIATION_RETAIN);
}


- (UIView *)scrollContentView
{
    UIView *scrollContentV = objc_getAssociatedObject(self, &HYScrollContentViewKey);
    if (scrollContentV == nil) {
        scrollContentV = [[UIView alloc]init];
        self.scrollContentView = scrollContentV;
    }
    return scrollContentV;
}
- (void)setScrollContentView:(UIView *)scrollContentView
{
    objc_setAssociatedObject(self, &HYScrollContentViewKey, scrollContentView, OBJC_ASSOCIATION_RETAIN);
}

@end
