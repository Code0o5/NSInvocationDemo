//
//  ZhenIndicatorNormalView.m
//  findme
//
//  Created by 臻尚 on 2021/3/11.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYIndicatorSimpleView.h"
#import "HYFramework.h"

@implementation HYIndicatorSimpleView

- (void)setupFlagView
{
    // 游标
    UIView *flagView = UIView.new;
    flagView.backgroundColor = HYColorBlue;
    flagView.layer.cornerRadius = 2;
    flagView.layer.masksToBounds = YES;
    [self addSubview:flagView];
    self.flagView = flagView;
    [flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(4);
        make.left.equalTo(self).mas_offset(20);
    }];
    
    // 更新游标位置
    [self updateFlagViewPosition:NO];
}

// 更新游标的位置
- (void)updateFlagViewPosition:(BOOL)animate
{
    [self getFlagLeftMargin];

    [self layoutIfNeeded];
//    self.flagLeftMargin = self.flagLeftMargin - ([self btnWidthWithIndex:0] * 0.5) - self.flagView.hy_width * 0.5;
    
    // 调用父类方法更新flag
    [super updateFlagViewPosition:animate];
}

// 设置游标背景色
- (void)setFlagBgColor:(UIColor *)flagBgColor
{
    _flagBgColor = flagBgColor;
    
    self.flagView.backgroundColor = flagBgColor;
}

@end
