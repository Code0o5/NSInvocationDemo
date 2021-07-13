//
//  UIViewController+TableView.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/9.
//

#import <UIKit/UIKit.h>
#import "HYTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYTableView)<HYTableDelegate>

// table
@property (nonatomic, strong) HYTableView *tableView;

#pragma mark - 如果使用默认的cell，cell内容设置
// textlabel
@property (nonatomic, copy) NSString *(^textLabelContentBlock)(NSIndexPath *indexPath);
// detailTextLabel
@property (nonatomic, copy) NSString *(^detailTextLabelContentBlock)(NSIndexPath *indexPath);
// cell style
@property (nonatomic, copy) UITableViewCellStyle (^cellStyleBlock)(NSIndexPath *indexPath);
// cell accessType
@property (nonatomic, copy) UITableViewCellAccessoryType (^cellAccessoryTypeBlock)(NSIndexPath *indexPath);

#pragma mark - 设置子视图
// 设置tableView
- (void)setupTableView;

#pragma mark - HYTableRefreshDataDelegate
// 下拉刷新调用方法
- (void)hy_reloadData;

// 上拉加载更多调用方法
- (void)hy_loadMoreData;

// 设置tableDataSource信息
- (void)hy_setupTableDataSource;

@end

NS_ASSUME_NONNULL_END
