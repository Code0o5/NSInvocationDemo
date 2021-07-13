//
//  MyBaseTableViewCell.h
//  findme
//
//  Created by 臻尚 on 2021/3/1.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseTableViewCell : UITableViewCell

// 数据模型
@property (nonatomic, weak) HYBaseModel *model;

#pragma mark - textLabel
// 字体大小
@property (nonatomic, strong) UIFont *textFont;
// 字体颜色
@property (nonatomic, strong) UIColor *textColor;

#pragma mark - detailTextLabel
// 字体大小
@property (nonatomic, strong) UIFont *detailTextFont;
// 字体颜色
@property (nonatomic, strong) UIColor *detailTextColor;

@end

NS_ASSUME_NONNULL_END
