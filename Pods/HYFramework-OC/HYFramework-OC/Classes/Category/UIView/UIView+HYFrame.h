//
//  UIView+HYFrame.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HYFrame)

@property (assign, nonatomic) CGFloat hy_x;
@property (assign, nonatomic) CGFloat hy_y;
@property (assign, nonatomic) CGFloat hy_width;
@property (assign, nonatomic) CGFloat hy_height;
@property (assign, nonatomic) CGSize hy_size;
@property (assign, nonatomic) CGPoint hy_origin;

@end

NS_ASSUME_NONNULL_END
