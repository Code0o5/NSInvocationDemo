//
//  NSObject+HYAdd.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HYAdd)

/**
 对象判空
 @return 是否为空
 */
- (BOOL)isNULL;

// 对象转字符串
- (NSString *)toString;

@end

NS_ASSUME_NONNULL_END
