//
//  UIView+HYFrame.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIView+HYFrame.h"

@implementation UIView (HYFrame)

- (void)setHy_x:(CGFloat)hy_x
{
    CGRect frame = self.frame;
    frame.origin.x = hy_x;
    self.frame = frame;
}

- (CGFloat)hy_x
{
    return self.frame.origin.x;
}

- (void)setHy_y:(CGFloat)hy_y
{
    CGRect frame = self.frame;
    frame.origin.y = hy_y;
    self.frame = frame;
}

- (CGFloat)hy_y
{
    return self.frame.origin.y;
}

- (void)setHy_width:(CGFloat)hy_width
{
    CGRect frame = self.frame;
    frame.size.width = hy_width;
    self.frame = frame;
}

- (CGFloat)hy_width
{
    return self.frame.size.width;
}

- (void)setHy_height:(CGFloat)hy_height
{
    CGRect frame = self.frame;
    frame.size.height = hy_height;
    self.frame = frame;
}

- (CGFloat)hy_height
{
    return self.frame.size.height;
}

- (void)setHy_size:(CGSize)hy_size
{
    CGRect frame = self.frame;
    frame.size = hy_size;
    self.frame = frame;
}

- (CGSize)hy_size
{
    return self.frame.size;
}

- (void)setHy_origin:(CGPoint)hy_origin
{
    CGRect frame = self.frame;
    frame.origin = hy_origin;
    self.frame = frame;
}

- (CGPoint)hy_origin
{
    return self.frame.origin;
}

@end
