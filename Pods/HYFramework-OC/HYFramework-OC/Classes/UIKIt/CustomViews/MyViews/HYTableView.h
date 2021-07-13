//
//  HYTableView.h
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/5/31.
//

#import <UIKit/UIKit.h>
#import "HYTableDataSource.h"

NS_ASSUME_NONNULL_BEGIN

// 刷新数据代理
@protocol HYTableDelegate <NSObject>

// 下拉刷新调用方法
- (void)hy_reloadData;

// 上拉加载更多调用方法
- (void)hy_loadMoreData;

// 设置tableDataSource信息
- (void)hy_setupTableDataSource;

@end

@interface HYTableView : UITableView

// dataSource对象
@property (nonatomic, strong, readonly) HYTableDataSource *hyDataSource;

// 页码
@property(nonatomic, assign) NSInteger pageIndex;

// 是否是加载更多
@property(nonatomic, assign, readonly) BOOL isLoadMore;

// 是否显示默认的头部
@property(nonatomic, assign) BOOL showDefaultSectionHeader;

// 代理, 用于设置下拉刷新和上拉加载更多调用方法，以及设置tableDatasource
@property (nonatomic, weak) id <HYTableDelegate>hyDelegate;

#pragma mark - section header属性
// 字体大小
@property (nonatomic, strong) UIFont *sectionHeaderFont;

// 字体颜色
@property (nonatomic, strong) UIColor *sectionHeaderTextColor;

// 背景颜色
@property (nonatomic, strong) UIColor *sectionHeaderBgColor;

// 左边距离屏幕距离
@property (nonatomic, assign) CGFloat sectionHeaderLeftMargin;

// 右边距离屏幕距离
@property (nonatomic, assign) CGFloat sectionHeaderRightMargin;


#pragma mark - 工厂方法，获取对象
/**
 * 获取指定类型的HYTableView对象
 * @param style 类型
 * UITableViewStylePlain  table滚动，sectionHeader固定到屏幕顶部
 * UITableViewStyleGrouped table滚动，sectionHeader不固定到屏幕顶部
 */
+ (HYTableView *)tableViewWithStyle:(UITableViewStyle)style;

// 获取HYTableView对象，plain类型
+ (HYTableView *)tableView;

#pragma mark - 注册cell
// 注册 Nib cell(这里复用标识固定和cell类名一致)
- (void)registNibCell:(NSString *)className;

// 注册纯代码cell(这里复用标识固定和cell类名一致)
- (void)registCell:(NSString *)className;


#pragma mark - 设置tableView Datasource
// 设置tableDataSource信息
- (void)setupTableDataSource;

#pragma mark - 其他
// 设置tableView高度自适应
- (void)setupRowHeightAutomatic;

#pragma mark - 下拉刷新/上拉加载更多
// 添加头部下拉刷新
- (void)addHeaderRefresh;

// 添加尾部上拉加载更多
- (void)addFootRefresh;

// 头部开始刷新
- (void)startHeaderRefresh;

// 停止刷新(包括头部和尾部)
- (void)stopAllRefresh;

@end

NS_ASSUME_NONNULL_END
