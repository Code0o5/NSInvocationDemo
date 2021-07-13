//
//  NSString+HYAdd.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HYAdd)

/**
 * 去掉字符串首尾的空格
 */
- (NSString *)stringByTrim;

/**
 * 字符串判空
 * @return 结果
 */
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
