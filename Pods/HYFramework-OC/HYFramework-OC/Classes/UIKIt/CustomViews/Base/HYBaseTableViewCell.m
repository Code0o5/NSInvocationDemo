//
//  MyBaseTableViewCell.m
//  findme
//
//  Created by 臻尚 on 2021/3/1.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYBaseTableViewCell.h"
#import "HYFramework.h"

@implementation HYBaseTableViewCell

// 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置子视图
        [self setupSubViews];
    }
    return self;
}

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubViews
{
    [super setupSubViews];
    
    // 默认cell选中没有背景色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 设置默认的样式
    [self setupDefaultViews];
}

// 设置默认的样式
- (void)setupDefaultViews
{
    // textLabel && detailTextLabel
    self.textLabel.font = HYFontSystem(15);
    self.detailTextLabel.font = HYFontSystem(14);
    self.textLabel.textColor = HYColorTextNormal;
    self.detailTextLabel.textColor = HYColorBgLight3;
}

#pragma mark - setter
// 绑定数据
- (void)setModel:(HYBaseModel *)model
{
    _model = model;
    
}

// 字体大小
- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    self.textLabel.font = textFont;
}

// 字体颜色
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

// 字体大小
- (void)setDetailTextFont:(UIFont *)detailTextFont
{
    _detailTextFont = detailTextFont;
    self.detailTextLabel.font = detailTextFont;
}

// 字体颜色
- (void)setDetailTextColor:(UIColor *)detailTextColor
{
    _detailTextColor = detailTextColor;
    self.detailTextLabel.textColor = _detailTextColor;
}

@end
