//
//  UIViewController+HYBottomBtn.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIViewController+HYBottomBtns.h"
#import <objc/runtime.h>
#import "HYConstMacro.h"
#import "UIView+HYFrame.h"

static char fviewConst;
static char bottomBtnActionsConst;

@implementation UIViewController (HYBottomBtns)

#pragma mark - 底部按钮自定义
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
                 actions:(NSArray *_Nullable)actions
{
    if (buttonTitles.count == 0) return;
    
    self.bottomBtnActions = actions;
    [self.view addSubview:self.fview];
    
    NSInteger btnCount = buttonTitles.count;
    CGFloat bothMargin = 15.0;
    CGFloat centerMargin = 10.0;
    CGFloat btnY = 10;
    CGFloat btnW = (HYSCREEN_Width - bothMargin * 2.0 - centerMargin * (btnCount - 1))/btnCount;
    CGFloat btnH = 40.0;
    for (int i = 0; i < buttonTitles.count; i++) {
        NSString *btnTitle = buttonTitles[i];
        CGFloat btnX = bothMargin + (centerMargin + btnW) * i;
        UIButton *bottomBtn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        bottomBtn.tag = 2000 + i;
        bottomBtn.titleLabel.font = HYFontSystem(15);
        [bottomBtn setTitle:btnTitle forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomBtn setBackgroundColor:(btnBgColors.count > i ? btnBgColors[i] : nil)];
        [bottomBtn setTitleColor:(btnTColors.count > i ? btnTColors[i] : nil) forState:UIControlStateNormal];
        bottomBtn.layer.cornerRadius = 8;
        bottomBtn.layer.masksToBounds = YES;
        [self.fview addSubview:bottomBtn];
    }
}

/**
 * 执行底部指定按钮事件
 * @param btn 按钮
 */
- (void)bottomBtnAction:(UIButton *)btn
{
    NSInteger index = btn.tag - 2000;
    if (self.bottomBtnActions.count > index) {
        void (^block)(void) = self.bottomBtnActions[index];
        if (block) {
            block();
        }
    }
}


/**
 * 修改指定底部按钮标题
 * @param title 标题
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnTitle:(NSString *_Nullable)title btnIndex:(NSInteger)btnIndex
{
    UIView *subV = [self.fview viewWithTag:2000 + btnIndex];
    if (subV && [subV isKindOfClass:[UIButton class]]) {
        [(UIButton *)subV setTitle:title forState:UIControlStateNormal];
    }
}

/**
 * 修改指定底部按钮标题颜色
 * @param titleColor 标题颜色
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnTitleColor:(UIColor *_Nullable)titleColor btnIndex:(NSInteger)btnIndex
{
    UIView *subV = [self.fview viewWithTag:2000 + btnIndex];
    if (subV && [subV isKindOfClass:[UIButton class]]) {
        [(UIButton *)subV setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

/**
 * 修改底部按钮背景颜色
 * @param bgColor 背景色
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnBgColor:(UIColor *_Nullable)bgColor btnIndex:(NSInteger)btnIndex
{
    UIView *subV = [self.fview viewWithTag:2000 + btnIndex];
    if (subV && [subV isKindOfClass:[UIButton class]]) {
        subV.backgroundColor = bgColor;
    }
}

/**
 * 修改底部按钮图标
 * @param iconName 图标名
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnIcon:(NSString *_Nullable)iconName btnIndex:(NSInteger)btnIndex
{
    UIView *subV = [self.fview viewWithTag:2000 + btnIndex];
    if (subV && [subV isKindOfClass:[UIButton class]]) {
        [(UIButton *)subV setImage:HYImageNamed(iconName) forState:UIControlStateNormal];
        [(UIButton *)subV setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    }
}

/**
 * 获取底部指定索引的按钮
 * @param btnIndex 按钮索引
 * @return 指定按钮
 */
- (UIButton *_Nullable)bottomBtnWithIndex:(NSInteger)btnIndex
{
    UIView *subV = [self.fview viewWithTag:2000 + btnIndex];
    return (UIButton *)subV;
}

/**
 * 设置底部按钮是否可以点击
 * @param enable 是否可以点击
 * @param btnIndex 按钮索引
 */
- (void)setBottomBtnEnable:(BOOL)enable btnIndex:(NSInteger)btnIndex
{
    UIView *subV = [self.fview viewWithTag:2000 + btnIndex];
    if (subV && [subV isKindOfClass:[UIButton class]]) {
        [(UIButton *)subV setUserInteractionEnabled:enable];
    }
}

#pragma mark - 关联属性
//getter
- (UIView *)fview
{
    UIView *fv = objc_getAssociatedObject(self, &fviewConst);
    if (fv == nil) {
        fv = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.hy_height - HYSCREEN_Bottom_Safe_Height - 60, HYSCREEN_Width, 60 + HYSCREEN_Bottom_Safe_Height)];
        fv.backgroundColor = [UIColor whiteColor];
        self.fview = fv;
    }
    return fv;
}
- (void)setFview:(UIView *)fview
{
    objc_setAssociatedObject(self, &fviewConst, fview, OBJC_ASSOCIATION_RETAIN);
}


//getter
- (NSArray *)bottomBtnActions
{
    return objc_getAssociatedObject(self, &bottomBtnActionsConst);
}
- (void)setBottomBtnActions:(NSArray *)bottomBtnActions
{
    objc_setAssociatedObject(self, &bottomBtnActionsConst, bottomBtnActions, OBJC_ASSOCIATION_COPY);
}

@end
