//
//  UIView+HYAdd.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/14.
//

#import "UIView+HYAdd.h"
#import <objc/runtime.h>

static char HYExtraStringKey;
static char HYExtraNumberKey;
static char HYViewControllerKey;
static char HYExtraObjectKey;

@implementation UIView (HYAdd)

#pragma mark - 关联属性
- (NSString *)extraString
{
    return objc_getAssociatedObject(self, &HYExtraStringKey);
}
- (void)setExtraString:(NSString *)extraString
{
    objc_setAssociatedObject(self, &HYExtraStringKey, extraString, OBJC_ASSOCIATION_COPY);
}

- (NSNumber *)extraNumber
{
    return objc_getAssociatedObject(self, &HYExtraNumberKey);
}
- (void)setExtraNumber:(NSNumber *)extraNumber
{
    objc_setAssociatedObject(self, &HYExtraNumberKey, extraNumber, OBJC_ASSOCIATION_RETAIN);
}

- (id)extraObject
{
    return objc_getAssociatedObject(self, &HYExtraObjectKey);
}
- (void)setExtraObject:(id)extraObject
{
    objc_setAssociatedObject(self, &HYExtraObjectKey, extraObject, OBJC_ASSOCIATION_RETAIN);
}

- (UIViewController *)viewController
{
    UIViewController *ctr = objc_getAssociatedObject(self, &HYViewControllerKey);
    if (ctr == nil) {
        //获取当前view的superView对应的控制器
        UIResponder *next = [self nextResponder];
        do {
            if ([next isKindOfClass:[UIViewController class]]) {
                ctr = (UIViewController *)next;
                break;
            }
            next = [next nextResponder];
        } while (next != nil);
        self.viewController = ctr;
    }
    
    return ctr;
}
- (void)setViewController:(UIViewController *)viewController
{
    objc_setAssociatedObject(self, &HYViewControllerKey, viewController, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - 添加方法
// 添加子视图
- (void)setupSubViews{}

/**
 * 设置view圆角
 *  @param cornerRadius radius
 *  @param roundingCorners 圆角方向,可以设置多个,用|分割
 */
- (CAShapeLayer *)cornerWithRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners
{
    //当前view上添加的约束立即生效，不加这一行可能会因为约束没生效，导致self.bounds为全0，设置圆角没有效果
    [self.superview layoutIfNeeded];
    CAShapeLayer *layer = CAShapeLayer.layer;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    layer.path = path.CGPath;
    layer.frame = self.bounds;
    self.layer.mask = layer;
    layer.masksToBounds = NO;
    return layer;
}

@end
