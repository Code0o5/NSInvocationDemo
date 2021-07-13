//
//  UIViewController+HYScrollView.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYScrollView)

#pragma mark - 属性
// 滚动视图
@property (nonatomic, strong) UIScrollView *scrollV;

// scrollView内部背景视图，控制scrollView的contentSize
// 注:scrollContentView的高度没有添加约束，需要在内部添加子视图的时候设置约束把scrollContentView撑起来
@property (nonatomic, strong) UIView *scrollContentView;

#pragma mark - 方法
// 添加scrollView
- (void)setupScrollView;

@end

NS_ASSUME_NONNULL_END
