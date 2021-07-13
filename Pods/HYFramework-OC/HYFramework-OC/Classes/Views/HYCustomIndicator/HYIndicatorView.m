//
//  ZhenIndicatorView.m
//  findme
//
//  Created by 臻尚 on 2021/3/9.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYIndicatorView.h"
#import <Masonry/Masonry.h>
#import "HYFramework.h"

@interface HYIndicatorView ()

// contentView
@property (nonatomic, weak) UIView *contenView;

// 按钮标题列表
@property (nonatomic, copy) NSArray *titlesArray;

// 按钮图标列表
@property (nonatomic, copy) NSArray *iconsArray;

// 当前选中的按钮
@property (nonatomic, weak) UIButton *currentSelectedBtn;

// 当前选中的按钮索引(默认选中第一个)
@property (nonatomic, assign) NSInteger currentSelectIndex;

@end

@implementation HYIndicatorView

#pragma mark - 初始化
- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.titlesArray = titles;
        
        // 设置默认常量值
        [self setupDefaltConst];
        
        // 设置子视图
        [self setupViews];
    }
    return self;
}

#pragma mark - 设置子views
// 设置子视图
- (void)setupViews
{
    // 添加约束
    self.backgroundColor = [UIColor clearColor];
    
    // 设置contentView
    UIView *contenView = UIView.new;
    contenView.backgroundColor = [UIColor clearColor];
    [self addSubview:contenView];
    self.contenView = contenView;
    [contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    
    // 添加按钮
    [self setupBtns];
    
    // 设置游标
    [self setupFlagView];
}

// 设置按钮
- (void)setupBtns
{
    UIButton *lastBtn = nil;
    for (int i = 0; i < self.titlesArray.count; i++) {
        // 计算按钮文本宽度
        NSString *t = self.titlesArray[i];
        CGFloat textW = [t widthWithFont:self.btnFont] + 5;
        
        // 创建按钮
        UIButton *btn = UIButton.new;
        btn.tag = 1000 + i;
        [btn setTitle:t forState:UIControlStateNormal];
        [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = self.btnFont;
        
        // 按钮添加约束
        [self.contenView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contenView);
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).mas_equalTo(self.btnMargin);
            }else {
                make.left.equalTo(self.contenView);
            }
//            make.width.mas_equalTo(btnW);
            if (i == self.titlesArray.count - 1) {
                // 最后一个按钮
                make.right.equalTo(self.contenView);
            }
        }];
        
        // 默认选中第一个
        if (i == 0) {
            btn.selected = YES;
            self.currentSelectedBtn = btn;
        }
        
        lastBtn = btn;
    }
}

// 设置游标
- (void)setupFlagView
{
    
}


// 重新设置按钮
- (void)resetBtns:(NSArray *)titles
{
    self.currentSelectIndex = 0;
    
    self.titlesArray = titles;
    
    // 移除旧的按钮
    [self.contenView removeSubviewsWithClass:[UIButton class]];
    
    // 重新添加按钮
    [self setupBtns];
    
    // 更新游标位置
    [self updateFlagViewPosition:NO];
}

#pragma mark - 其他
// 设置默认常量值
- (void)setupDefaltConst
{
    // 当前选中的按钮索引(默认选中第一个)
    self.currentSelectIndex = 0;
    // 相邻两个按钮间隔(默认20)
    self.btnMargin = 20;
    // 按钮字体(默认 [UIFont systemFontOfSize:14])
    self.btnFont = [UIFont systemFontOfSize:14];
    
    // 按钮文本颜色
    // 默认 [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0]
    self.titleNormalColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
    
    // 按钮选中文本颜色
    // 默认 [UIColor colorWithRed:84/255.f green:107/255.f blue:251/255.f alpha:1.0]
    self.titleSelectColor = [UIColor colorWithRed:84/255.f green:107/255.f blue:251/255.f alpha:1.0];
}

// 更新按钮宽度
- (void)updateBtnsWidthBlock:(void(^)(int index,CGFloat btnLeft, CGFloat btnW, NSString *iconN))btnBlock
{
    
}

// 更新按钮icon
- (void)updateBtnIcon:(NSString *)iconName btn:(UIButton *)btn
{
    if (iconName.length > 0) {
        [btn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
//        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.btnIconTitleMargin);
    }
}

/**
 更新游标的位置
 @param animate 是否动画
 */
- (void)updateFlagViewPosition:(BOOL)animate
{
    if (animate) {
        // 动画改变游标位置
        [UIView animateWithDuration:0.2 animations:^{
            [self.flagView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(self.flagLeftMargin);
            }];
            // masory动画这一行必须加
            [self layoutIfNeeded];
        } completion:nil];
    }else {
        [self.flagView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.flagLeftMargin);
        }];
    }
}

// 计算左边约束间距
- (CGFloat)getFlagLeftMargin
{
//    CGFloat leftConstrain = self.leftMargin;
//    for (int i = 0; i < self.currentSelectIndex + 1; i++) {
//        CGFloat w = 0;
//        if (i < self.btnWidthsArray.count) {
//            w = [self.btnWidthsArray[i] floatValue];
//
//            if (i != self.currentSelectIndex) {
//                w += self.btnMargin;
//            }
//        }
//        leftConstrain += w;
//    }
//
//    self.flagLeftMargin = leftConstrain;
//    return self.flagLeftMargin;
    
    return 0;
}

// 获取指定btn的宽度
- (CGFloat)btnWidthWithIndex:(int)index
{
    CGFloat btnW = 0;
//    if (index < self.btnWidthsArray.count) {
//        btnW = [self.btnWidthsArray[index] floatValue];
//    }
    return btnW;
}

/**
 重置指定btn宽度
 @param width 按钮宽度
 @param btn 指定按钮，如果传nil,将自动根据index获取指定btn
 @param index 按钮索引
 */
- (void)resetBtnWidth:(CGFloat)width btn:(UIButton *)btn index:(int)index
{
//    if (btn == nil) {
//        if (index < self.btnWidthsArray.count) {
//            btn = self.btnWidthsArray[index];
//        }
//    }
//
//    if (btn) {
//        // 计算btn左边距离屏幕宽度
//        CGFloat leftConstrain = 0;
//        for (int i = 0; i < index; i++) {
//            leftConstrain += ([self.btnWidthsArray[i] floatValue] + self.btnMargin);
//        }
//
//        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(width);
//            make.left.mas_equalTo(leftConstrain);
//        }];
//
//        if (index < self.btnWidthsArray.count) {
//            // 更新btn宽度集合
//            NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.btnWidthsArray];
//            [arrM replaceObjectAtIndex:index withObject:@(width)];
//            self.btnWidthsArray = [arrM copy];
//        }
//    }
//
//    // 更新游标位置
//    [self updateFlagViewPosition:NO];
}

/**
 重置所有按钮的宽度
 @param width 宽度
 */
- (void)resetAllBtnsWidth:(CGFloat)width
{
    NSArray *btns = [self.contenView subviewsWithClass:[UIButton class]];
    for (int i = 0; i < btns.count; i++) {
        UIButton *btn = btns[i];
        [self resetBtnWidth:width btn:btn index:i];
    }
}

#pragma mark - 点击事件
// 点击按钮
- (void)btnClick:(UIButton *)btn
{
    // 设置选中状态
    self.currentSelectedBtn.selected = NO;
    self.currentSelectedBtn = btn;
    btn.selected = YES;
    
    // 选中索引
    NSInteger index = btn.tag - 1000;
    self.currentSelectIndex = index;
    
    // 更新游标的位置
    [self updateFlagViewPosition:YES];
    
    // 回调
    if (self.valueChangeBlock) {
        self.valueChangeBlock(index);
    }
}

#pragma mark - setter
// 默认文本颜色
- (void)setTitleNormalColor:(UIColor *)titleNormalColor
{
    _titleNormalColor = titleNormalColor;
    
    // 设置默认值的时候不执行下面代码
    if (self.contenView == nil) return;
    
    NSArray *btns = [self.contenView subviewsWithClass:[UIButton class]];
    for (UIButton *btn in btns) {
        [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }
}

// 选中文本颜色
- (void)setTitleSelectColor:(UIColor *)titleSelectColor
{
    _titleSelectColor = titleSelectColor;
    
    // 设置默认值的时候不执行下面代码
    if (self.contenView == nil) return;
    
    NSArray *btns = [self.contenView subviewsWithClass:[UIButton class]];
    for (UIButton *btn in btns) {
        [btn setTitleColor:titleSelectColor forState:UIControlStateSelected];
    }
}

// 按钮字体(默认 [UIFont systemFontOfSize:14])
- (void)setBtnFont:(UIFont *)btnFont
{
    _btnFont = btnFont;
    
    // 设置默认值的时候不执行下面代码
    if (self.contenView == nil) return;
    
    NSArray *btns = [self.contenView subviewsWithClass:[UIButton class]];
    
    // 更新按钮宽度相关的
    [self updateBtnsWidthBlock:^(int index, CGFloat btnLeft, CGFloat btnW, NSString *iconN) {
        UIButton *btn = btns[index];
        btn.titleLabel.font = btnFont;
        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(btnLeft);
            make.width.mas_equalTo(btnW);
        }];
    }];
    
    // 更新游标位置
    [self updateFlagViewPosition:NO];
}

// 设置按钮间隔
- (void)setBtnMargin:(CGFloat)btnMargin
{
    _btnMargin = btnMargin;
    
    // 设置默认值的时候不执行下面代码
    if (self.contenView == nil) return;
    
    if (self.contenView) {
        [self resetBtns:self.titlesArray];
    }
    
    // 更新游标位置
    [self updateFlagViewPosition:NO];
}

// 按钮icon和文本间隔(默认20)
//- (void)setBtnIconTitleMargin:(CGFloat)btnIconTitleMargin
//{
//    _btnIconTitleMargin = btnIconTitleMargin;
//
//    // 设置默认值的时候不执行下面代码
//    if (self.contenView == nil) return;
//
//    WeakSelf
//    NSArray *btns = [self.contenView subviewsWithClass:[UIButton class]];
//    [self updateBtnsWidthBlock:^(int index, CGFloat btnLeft, CGFloat btnW, NSString *iconN) {
//        UIButton *btn = btns[index];
//
//        // 更新按钮icon
//        [Weakself updateBtnIcon:iconN btn:btn];
//
//        [btn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(btnLeft);
//            make.width.mas_equalTo(btnW);
//        }];
//    }];
//}

// 整个indicator距离左右屏幕宽度
//- (void)setLeftMargin:(CGFloat)leftMargin
//{
//    _leftMargin = leftMargin;
//    
//    // 设置默认值的时候不执行下面代码
//    if (self.contenView == nil) return;
//    
//    // 更新游标位置
//    [self updateFlagViewPosition:NO];
//    
//    [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).mas_offset(leftMargin);
//    }];
//}
//- (void)setRightMargin:(CGFloat)rightMargin
//{
//    _rightMargin = rightMargin;
//    
//    // 设置默认值的时候不执行下面代码
//    if (self.contenView == nil) return;
//    
//    [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).mas_offset(-rightMargin);
//    }];
//}
//
//// 整个indicator高度(默认50)
//-(void)setIndicatorHeight:(CGFloat)indicatorHeight
//{
//    _indicatorHeight = indicatorHeight;
//    
//    // 设置默认值的时候不执行下面代码
//    if (self.contenView == nil) return;
//    
//    // contentView高度
//    [self.contenView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(indicatorHeight);
//    }];
//    // 设置self高度
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(indicatorHeight);
//    }];
//}

@end
