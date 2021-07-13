//
//  ZhenIndicatorImgView.m
//  findme
//
//  Created by 臻尚 on 2021/3/11.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYIndicatorImgView.h"
#import <Masonry/Masonry.h>

@interface HYIndicatorImgView ()

@end

@implementation HYIndicatorImgView

// 设置浮标
- (void)setupFlagView
{
    [super setupFlagView];
    
    // 游标 标识当前选中哪一个
    UIImageView *flagImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:self.flageImageName]];
    flagImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:flagImgView];
    self.flagView = flagImgView;
    [self.flagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.flagSize);
        make.top.mas_equalTo(self.flagTopConstrain);
    }];
    
    // 更新浮标的位置
    [self updateFlagViewPosition:YES];
}

#pragma mark - 其他
// 设置默认常量值
- (void)setupDefaltConst
{
    [super setupDefaltConst];
    
    // 游标图片名(默认 icon_oral_primary)
    self.flageImageName = @"icon_oral_primary";
    // 游标宽高(默认 10)
    self.flagSize = 10;
    // 游标top约束间距(默认 15)
    self.flagTopConstrain = 15;
    
    // 游标距离屏幕左边的距离(默认在第一个按钮附近)
//    self.flagLeftMargin = [self getFlagLeftMargin];
}

// 更新游标的位置
- (void)updateFlagViewPosition:(BOOL)animate
{
    [self getFlagLeftMargin];
//    self.flagLeftMargin -= self.flagSize;
    
    // 调用父类方法更新flag
    [super updateFlagViewPosition:animate];
}

#pragma mark - setter
// 游标图片名(默认 icon_oral_primary)
- (void)setFlageImageName:(NSString *)flageImageName
{
    _flageImageName = flageImageName;
    
    [(UIImageView *)self.flagView setImage:[UIImage imageNamed:flageImageName]];
}

// 游标宽高(默认 10)
- (void)setFlagSize:(CGFloat)flagSize
{
    _flagSize = flagSize;
    
    [self.flagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(flagSize);
    }];
}

// 游标top约束间距(默认 15)
- (void)setFlagTopConstrain:(CGFloat)flagTopConstrain
{
    _flagTopConstrain = flagTopConstrain;
    
    [self.flagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(flagTopConstrain);
    }];
}

@end
