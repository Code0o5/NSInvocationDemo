//
//  UIScrollView+HYRefresh.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (HYRefresh)

// 添加头部刷新
- (void)addHeaderRefreshBlock:(void (^)(void))block;

// 添加上拉加载更多
- (void)addFootRefreshBlock:(void (^)(void))block;

// 开始下拉刷新
- (void)startRefresh;

// 停止刷新(包括头部和尾部)
- (void)stopRefresh;

@end

NS_ASSUME_NONNULL_END
