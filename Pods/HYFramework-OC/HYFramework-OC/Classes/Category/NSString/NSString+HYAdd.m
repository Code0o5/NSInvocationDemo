//
//  NSString+HYAdd.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "NSString+HYAdd.h"

@implementation NSString (HYAdd)


/**
 * 去掉字符串首尾的空格
 */
- (NSString *)stringByTrim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

/**
 * 字符串判空
 * @return 结果
 */
- (BOOL)isEmpty
{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if ([@([self length]) isEqual:@(0)]) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([self isEqualToString:@"null"]) {
        return YES;
    }
    if ([self isEqualToString:@"null"]) {
        return YES;
    }
    
    return NO;
}

@end
