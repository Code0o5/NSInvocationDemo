//
//  UIScrollView+HYRefresh.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIScrollView+HYRefresh.h"
#import "MJRefresh.h"

@implementation UIScrollView (HYRefresh)

// 添加头部刷新
- (void)addHeaderRefreshBlock:(void (^)(void))block
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
}

// 添加上拉加载更多
- (void)addFootRefreshBlock:(void (^)(void))block
{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    footer.automaticallyChangeAlpha = YES;
    self.mj_footer = footer;
}

// 开始下拉刷新
- (void)startRefresh
{
    if (self.mj_header) {
        [self.mj_header beginRefreshing];
    }
}

// 停止刷新(包括头部和尾部)
- (void)stopRefresh
{
    if (self.mj_header) {
        [self.mj_header endRefreshing];
    }
    
    if (self.mj_footer) {
        [self.mj_footer endRefreshing];
    }
}

@end
