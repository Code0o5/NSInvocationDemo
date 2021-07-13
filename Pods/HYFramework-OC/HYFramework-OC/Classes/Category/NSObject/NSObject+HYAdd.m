//
//  NSObject+HYAdd.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "NSObject+HYAdd.h"

@implementation NSObject (HYAdd)

/**
 对象判空
 @return 是否为空
 */
- (BOOL)isNULL
{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if ([self isEqual:[NSNull class]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([self isKindOfClass:[NSNumber class]]) {
        if ([(NSNumber *)self isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([self isKindOfClass:[NSArray class]]) {
        if ([self isEqual:@[]]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        if ([self isEqual:@{}]) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

// 对象转字符串
- (NSString *)toString
{
    return [NSString stringWithFormat:@"%@",self];
}

@end
