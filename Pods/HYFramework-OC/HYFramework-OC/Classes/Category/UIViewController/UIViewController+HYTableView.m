//
//  UIViewController+TableView.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/9.
//

#import "UIViewController+HYTableView.h"
#import <objc/runtime.h>
#import "HYFramework.h"

static char HYTableViewPropertyKey;
static char HYTextLabelContentPropertyKey;
static char HYDetailTextLabelContentPropertyKey;
static char HYCellStylePropertyKey;
static char HYCellAccessoryTypePropertyKey;

@implementation UIViewController (HYTableView)

#pragma mark - 设置子视图
// 设置tableView
- (void)setupTableView
{
    // 添加table
    [self.view addSubview:self.tableView];
    self.tableView.hyDelegate = self;
    // 默认tableview和self.view一样大小
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // 设置tableDatasource
    [self.tableView setupTableDataSource];
}

#pragma mark - HYTableDelegate
// 下拉刷新调用方法
- (void)hy_reloadData
{
    
}

// 上拉加载更多调用方法
- (void)hy_loadMoreData
{
    
}

// 设置tableDataSource信息
- (void)hy_setupTableDataSource
{
    WeakSelf
    // 高度
    self.tableView.rowHeight = 48;
    // cell
    self.tableView.hyDataSource.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableView * _Nonnull table, NSIndexPath * _Nonnull indexPath) {
        HYBaseTableViewCell *cell = [table dequeueReusableCellWithIdentifier:@"HYBaseTableViewCell"];
        
        UITableViewCellStyle cellStyle = UITableViewCellStyleDefault;
        if (Weakself.cellStyleBlock) {
            cellStyle = Weakself.cellStyleBlock(indexPath);
        }
        if (cell == nil) {
            cell = [[HYBaseTableViewCell alloc]initWithStyle:cellStyle reuseIdentifier:@"HYBaseTableViewCell"];
        }
        
        // cell内文本显示
        if (Weakself.textLabelContentBlock) {
            cell.textLabel.text = Weakself.textLabelContentBlock(indexPath);
        }
        
        if (Weakself.detailTextLabelContentBlock) {
            cell.detailTextLabel.text = Weakself.detailTextLabelContentBlock(indexPath);
        }
        
        // cell accessoryType
        if (Weakself.cellAccessoryTypeBlock) {
            cell.accessoryType = Weakself.cellAccessoryTypeBlock(indexPath);
        }
        
        return cell;
    };
}

#pragma mark - 关联属性
//getter
- (HYTableView *)tableView
{
    HYTableView *table = objc_getAssociatedObject(self, &HYTableViewPropertyKey);
    if (table == nil) {
        table = [HYTableView tableView];
        self.tableView = table;
    }
    return table;
}
- (void)setTableView:(HYTableView *)tableView
{
    objc_setAssociatedObject(self, &HYTableViewPropertyKey, tableView, OBJC_ASSOCIATION_RETAIN);
}


- (NSString * _Nonnull (^)(NSIndexPath * _Nonnull))textLabelContentBlock
{
    return objc_getAssociatedObject(self, &HYTextLabelContentPropertyKey);;
}
-(void)setTextLabelContentBlock:(NSString * _Nonnull (^)(NSIndexPath * _Nonnull))textLabelContentBlock
{
    objc_setAssociatedObject(self, &HYTextLabelContentPropertyKey, textLabelContentBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString * _Nonnull (^)(NSIndexPath * _Nonnull))detailTextLabelContentBlock
{
    return objc_getAssociatedObject(self, &HYDetailTextLabelContentPropertyKey);
}
- (void)setDetailTextLabelContentBlock:(NSString * _Nonnull (^)(NSIndexPath * _Nonnull))detailTextLabelContentBlock
{
    objc_setAssociatedObject(self, &HYDetailTextLabelContentPropertyKey, detailTextLabelContentBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UITableViewCellStyle (^)(NSIndexPath * _Nonnull))cellStyleBlock
{
    return objc_getAssociatedObject(self, &HYCellStylePropertyKey);
}
- (void)setCellStyleBlock:(UITableViewCellStyle (^)(NSIndexPath * _Nonnull))cellStyleBlock
{
    objc_setAssociatedObject(self, &HYCellStylePropertyKey, cellStyleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UITableViewCellAccessoryType (^)(NSIndexPath * _Nonnull))cellAccessoryTypeBlock
{
    return objc_getAssociatedObject(self, &HYCellAccessoryTypePropertyKey);
}
- (void)setCellAccessoryTypeBlock:(UITableViewCellAccessoryType (^)(NSIndexPath * _Nonnull))cellAccessoryTypeBlock
{
    objc_setAssociatedObject(self, &HYCellAccessoryTypePropertyKey, cellAccessoryTypeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



@end
