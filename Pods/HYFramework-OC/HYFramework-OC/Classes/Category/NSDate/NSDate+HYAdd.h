//
//  NSDate+HYAdd.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FormateType) {
    FormateTypeYMDHMS,  // 格式yyyy-MM-dd HH:mm:ss
    FormateTypeYMDHM,   // 格式yyyy-MM-dd HH:mm
    FormateTypeYMD,     // 格式yyyy-MM-dd
    FormateTypeYM,      // 格式yyyy-MM
};

@interface NSDate (HYAdd)

#pragma mark - 日期/字符串转换
/**
 * 日期转日期字符串
 * @param formateType 转换格式
 */
- (NSString *)dateToString:(FormateType)formateType;

/**
 * 日期字符串转日期
 * @param formateType 转换格式
 * @param dateString 字符串日期
 */
+ (NSDate *)dateStringToDate:(FormateType)formateType dateString:(NSString *)dateString;

/**
 * 转换日期字符串到指定格式
 * @param dateStr 日期字符串
 * @param oldFormateType 老的日期格式
 * @param newFormateType 新的日期格式
 */
+ (NSString *)dateStrFromStr:(NSString *)dateStr oldFormateType:(FormateType)oldFormateType newFormateType:(FormateType)newFormateType;

// 时间戳转换成日期
+ (NSString *)dateStringTranslate:(NSString *)str;

// 后台返回的日期格式:Date(1535950164387),转换成日期
+ (NSString *)stringToDate:(NSString *)dateFormate str:(NSString *)str;

#pragma mark - 日期比较
/**
 * 判断日期是否在两个日期之间
 * @param beginDate 起始日期
 * @param endDate 终止日期
 */
- (BOOL)dateBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;

/**
 * 判断日期大小
 * @param date 比较的日期
 */
- (BOOL)dateIsLatterWithDate:(NSDate *)date;

/**
 * 判断日期是否相等
 * @param date 比较的日期
 */
- (BOOL)dateEqualToDate:(NSDate *)date;

#pragma mark - 其他
//获取当前时间戳
+ (NSString *)currentTimestamp;

/**
 * 日期拆分，获取日期元素(年、月、日、时、分、秒)
 * @param dateString 日期字符串
 * @param formateType 日期格式类型
 */
+ (NSArray *)dateSplitWithDateString:(NSString *)dateString formate:(FormateType)formateType;

@end

NS_ASSUME_NONNULL_END
