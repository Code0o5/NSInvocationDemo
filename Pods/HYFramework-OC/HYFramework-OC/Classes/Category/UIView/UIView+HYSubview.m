//
//  UIView+HYSubview.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "UIView+HYSubview.h"

@implementation UIView (HYSubview)

// 移除所有子视图
- (void)clearSubviews
{
   for (UIView *v in self.subviews) {
       [v removeFromSuperview];
    }
}

// 移除指定类子视图
- (void)removeSubviewsWithClass:(Class)class
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:class]) {
            [v removeFromSuperview];
        }
    }
}


// 移除指定tag的子视图
- (void)removeSubviewsWithTag:(NSInteger)tag
{
    for (UIView *v in self.subviews) {
        if (v.tag == tag) {
            [v removeFromSuperview];
        }
    }
}

// 获取所有的子视图
- (NSArray *)allSubviews
{
    return self.subviews;
}

// 获取指定类的所有子视图
- (NSArray *)subviewsWithClass:(Class)class
{
    NSMutableArray *arrM = [NSMutableArray array];
    for (UIView *subV in self.subviews) {
        if ([subV isKindOfClass:class]) {
            [arrM addObject:subV];
        }
    }
    
    return [arrM copy];
}

@end
