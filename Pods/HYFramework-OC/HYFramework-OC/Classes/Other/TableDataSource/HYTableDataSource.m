//
//  ZhenTableDataSource.m
//  findme
//
//  Created by 臻尚 on 2021/3/5.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYTableDataSource.h"

@interface HYTableDataSource ()<UITableViewDataSource,UITableViewDelegate>

// tableView
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation HYTableDataSource

#pragma mark - 工厂方法
// 获取对象
+ (instancetype)dataSourceWithTable:(UITableView *)tableView
{
    HYTableDataSource *dataSource = [[self alloc]init];
    dataSource.tableView = tableView;
    tableView.dataSource = dataSource;
    tableView.delegate = dataSource;
    return dataSource;
}

#pragma mark - 其他
// 设置数据列表
- (void)resetDataWithArray:(NSArray *)array
{
    [self.dataSourceArray removeAllObjects];
    [self addDataWithArray:array];
}

// 添加新数据
- (void)addDataWithArray:(NSArray *)array
{
    [self.dataSourceArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
// section数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.numberOfSections) {
        return self.numberOfSections();
    }else {
        return 1;
    }
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.numberOfRowsInSection) {
        return self.numberOfRowsInSection(section);
    }else {
        return self.dataSourceArray.count;
    }
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.heightForRowAtIndexPath) {
        return self.heightForRowAtIndexPath(indexPath);
    }else {
        return tableView.rowHeight;
    }
}

// 每一行cell定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellForRowAtIndexPath) {
        return self.cellForRowAtIndexPath(tableView, indexPath);
    }else {
        return [[UITableViewCell alloc]init];
    }
}

// sectionHeader title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.titleForHeaderInSection) {
        return self.titleForHeaderInSection(tableView, section);
    }
    
    return @"";
}

// sectionHeader view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.viewForHeaderInSection) {
        return self.viewForHeaderInSection(tableView,section);
    }else {
        return nil;
    }
}

//section header 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.heightForHeaderInSection) {
        return self.heightForHeaderInSection(tableView,section);
    }else {
        return 0;
    }
}

// section foot title
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.titleForFooterInSection) {
        return self.titleForFooterInSection(tableView, section);
    }
    
    return @"";
}

// section footer height
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.heightForFooterInSection) {
        return self.heightForFooterInSection(tableView,section);
    }else {
        return 0;
    }
}

// section footer view
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.viewForFooterInSection) {
        return self.viewForFooterInSection(tableView,section);
    }else {
        return nil;
    }
}

// 点击一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(tableView,indexPath);
    }
}

#pragma mark - 懒加载
// 数据集合
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

@end
