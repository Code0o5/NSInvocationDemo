//
//  UIView+HYAdd.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HYAdd)

// 额外字符串类型的数据
@property (nonatomic, copy) NSString *extraString;

// 额外NSNumber类型的数据
@property (nonatomic, strong) NSNumber *extraNumber;

// 额外对象数据
@property (nonatomic, strong) id extraObject;

// view所在的控制器
@property (nonatomic, strong) UIViewController *viewController;


#pragma mark - 添加方法
// 添加子视图
- (void)setupSubViews;

/**
 * 设置view圆角
 *  @param cornerRadius radius
 *  @param roundingCorners 圆角方向,可以设置多个,用|分割
 */
- (CAShapeLayer *)cornerWithRadius:(CGFloat)cornerRadius roundingCorners:(UIRectCorner)roundingCorners;

@end

NS_ASSUME_NONNULL_END
