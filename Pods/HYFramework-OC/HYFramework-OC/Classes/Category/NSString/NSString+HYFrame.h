//
//  NSString+HYFrame.h
//  GJKJAPP
//
//  Created by 臻尚 on 2021/3/22.
//  Copyright © 2021 谭耀焯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HYFrame)

/**
 * 计算文本宽度
 * @param font 文本控件的字体
 * @return 文本宽度
 */
- (float)widthWithFont:(UIFont *)font;

/**
 * 计算文本高度
 * @param font 文本控件的字体
 * @param width 限制最大的宽度
 */
- (float)heightWithFont:(UIFont *)font withinWidth:(float)width;

@end

NS_ASSUME_NONNULL_END
