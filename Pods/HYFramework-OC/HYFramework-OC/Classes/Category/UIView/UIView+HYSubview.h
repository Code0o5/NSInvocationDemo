//
//  UIView+HYSubview.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HYSubview)

// 移除所有子视图
- (void)clearSubviews;

// 移除指定类子视图
- (void)removeSubviewsWithClass:(Class)class;

// 移除指定tag的子视图
- (void)removeSubviewsWithTag:(NSInteger)tag;

// 获取所有的子视图
- (NSArray *)allSubviews;

// 获取指定类的所有子视图
- (NSArray *)subviewsWithClass:(Class)class;

@end

NS_ASSUME_NONNULL_END
