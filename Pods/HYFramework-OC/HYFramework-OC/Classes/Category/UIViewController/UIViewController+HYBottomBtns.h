//
//  UIViewController+HYBottomBtn.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

/**
 * 控制器底部按钮,适用于表单页面,底部提交、修改信息等按钮
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYBottomBtns)

// 底部按钮背景视图
@property (nonatomic, strong) UIView *fview;
// 底部按钮点击回调
@property (nonatomic, strong) NSArray *bottomBtnActions;

/**
 * 添加底部按钮
 * @param buttonTitles  按钮标题集合
 * @param btnBgColors   按钮背景色集合
 * @param btnTColors    按钮文字颜色集合
 * @param actions       点击事件回调集合,如果什么也不操作为"^{}"
 */
- (void)addBottomButtons:(NSArray<NSString *> *_Nullable)buttonTitles
             btnBgColors:(NSArray<UIColor *> *_Nullable)btnBgColors
              btnTColors:(NSArray<UIColor *> *_Nullable)btnTColors
                 actions:(NSArray *_Nullable)actions;

/**
 * 执行底部指定按钮事件
 * @param btn 按钮
 */
- (void)bottomBtnAction:(UIButton *)btn;

/**
 * 修改指定底部按钮标题
 * @param title 标题
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnTitle:(NSString *_Nullable)title btnIndex:(NSInteger)btnIndex;

/**
 * 修改指定底部按钮标题颜色
 * @param titleColor 标题颜色
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnTitleColor:(UIColor *_Nullable)titleColor btnIndex:(NSInteger)btnIndex;

/**
 * 修改底部按钮背景颜色
 * @param bgColor 背景色
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnBgColor:(UIColor *_Nullable)bgColor btnIndex:(NSInteger)btnIndex;

/**
 * 修改底部按钮图标
 * @param iconName 图标名
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnIcon:(NSString *_Nullable)iconName btnIndex:(NSInteger)btnIndex;

/**
 * 获取底部指定索引的按钮
 * @param btnIndex 按钮索引
 * @return 指定按钮
 */
- (UIButton *_Nullable)bottomBtnWithIndex:(NSInteger)btnIndex;

/**
 * 设置底部按钮是否可以点击
 * @param enable 是否可以点击
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnEnable:(BOOL)enable btnIndex:(NSInteger)btnIndex;


@end

NS_ASSUME_NONNULL_END
