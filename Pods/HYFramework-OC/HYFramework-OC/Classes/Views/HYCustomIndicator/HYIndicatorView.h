//
//  ZhenIndicatorView.h
//  findme
//
//  Created by 臻尚 on 2021/3/9.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYIndicatorView : UIScrollView

// 相邻两个按钮间隔(默认20)
@property (nonatomic, assign) CGFloat btnMargin;

// 按钮字体(默认 [UIFont systemFontOfSize:14])
@property (nonatomic, strong) UIFont *btnFont;

// 按钮文本颜色
// 默认 [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0]
@property (nonatomic, strong) UIColor *titleNormalColor;
// 按钮选中文本颜色
// 默认 [UIColor colorWithRed:84/255.f green:107/255.f blue:251/255.f alpha:1.0]
@property (nonatomic, strong) UIColor *titleSelectColor;

// 切换按钮回调
@property (nonatomic, copy) void (^valueChangeBlock)(NSInteger index);

// 当前选中的按钮索引(默认0)
@property (nonatomic, assign, readonly) NSInteger currentSelectIndex;

// 游标 标识当前选中哪一个
@property (nonatomic, weak) UIView *flagView;

#pragma mark - 初始化
- (instancetype)initWithSuperView:(UIView *)superView
                     topConstrain:(CGFloat)topConstrain
                           titles:(NSArray *)titles
                            icons:(NSArray *_Nullable)icons;

#pragma mark - 设置子views
// 设置子视图
- (void)setupViews;

// 重新设置按钮
- (void)resetBtns:(NSArray *)titles;

// 设置游标
- (void)setupFlagView;

#pragma mark - 其他
// 设置默认常量值
- (void)setupDefaltConst;

/**
 更新游标的位置
 @param animate 是否动画
 */
- (void)updateFlagViewPosition:(BOOL)animate;

// 计算左边约束间距
- (CGFloat)getFlagLeftMargin;

// 获取指定btn的宽度
- (CGFloat)btnWidthWithIndex:(int)index;

/**
 重置指定btn宽度
 @param width 按钮宽度
 @param btn 指定按钮，如果传nil,将自动根据index获取指定btn
 @param index 按钮索引
 */
- (void)resetBtnWidth:(CGFloat)width btn:(UIButton *)btn index:(int)index;

/**
 重置所有按钮的宽度
 @param width 宽度
 */
- (void)resetAllBtnsWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
