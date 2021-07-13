//
//  UIColor+HYAdd.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HYAdd)

/**
 * 16进制字符串颜色转换成RGB
 * @param hexStr 16进制字符串类型颜色
 * @return 转换后RGB颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)hexStr;

@end

NS_ASSUME_NONNULL_END
