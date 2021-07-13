//
//  NSDate+HYAdd.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/26.
//

#import "NSDate+HYAdd.h"

@implementation NSDate (HYAdd)

#pragma mark - 日期/字符串转换
/**
 * 日期转日期字符串
 * @param formateType 转换格式
 */
- (NSString *)dateToString:(FormateType)formateType
{
    NSDateFormatter *f = [NSDate dateFormateWithType:formateType];
    NSString *date = [f stringFromDate:self];
    return date;
}

/**
 * 日期字符串转日期
 * @param formateType 转换格式
 * @param dateString 字符串日期
 */
+ (NSDate *)dateStringToDate:(FormateType)formateType dateString:(NSString *)dateString
{
    NSDateFormatter *f = [self dateFormateWithType:formateType];
    NSDate *date = [f dateFromString:dateString];
    return date;
}

/**
 * 转换日期字符串到指定格式
 * @param dateStr 日期字符串
 * @param oldFormateType 老的日期格式
 * @param newFormateType 新的日期格式
 */
+ (NSString *)dateStrFromStr:(NSString *)dateStr oldFormateType:(FormateType)oldFormateType newFormateType:(FormateType)newFormateType
{
    NSDateFormatter *f = [self dateFormateWithType:oldFormateType];
    NSDate *d = [f dateFromString:dateStr];
    if (d == nil) {
        return dateStr;
    }
    f.dateFormat = [self formateWithType:newFormateType];
    return [f stringFromDate:d];
}

// 时间戳转换成日期
+ (NSString *)dateStringTranslate:(NSString *)str
{
    return [self stringToDate:@"yyyy-MM-dd" str:str];
}

// 后台返回的日期格式:Date(1535950164387),转换成日期
+ (NSString *)stringToDate:(NSString *)dateFormate str:(NSString *)str
{
    if (str.length == 0) {
        return @"";
    }
    
    if (str.length < 19) {
        return str;
    }
    
    NSRange range;
    range.location = 6;
    range.length = 13;
    NSString *strin = [str substringWithRange:range];

    double_t doub = [strin doubleValue]/1000.0;// 把字符串转换成 double型
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:doub];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateFormate];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

#pragma mark - 日期比较
/**
 * 判断日期是否在两个日期之间
 * @param beginDate 起始日期
 * @param endDate 终止日期
 */
- (BOOL)dateBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if (![self dateIsLatterWithDate:beginDate])
        return NO;
    if ([self dateIsLatterWithDate:endDate])
        return NO;
    return YES;
}

/**
 * 判断日期大小
 * @param date 比较的日期
 */
- (BOOL)dateIsLatterWithDate:(NSDate *)date
{
    if ([self compare:date] == NSOrderedAscending){
        return NO;
    }else {
        return YES;
    }
}

/**
 * 判断日期是否相等
 * @param date 比较的日期
 */
- (BOOL)dateEqualToDate:(NSDate *)date
{
    if ([self compare:date] == NSOrderedSame){
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 其他
//获取当前时间戳
+ (NSString *)currentTimestamp
{
    //获取当前时间0秒后的时间
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval time=[date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

/**
 * 日期拆分，获取日期元素(年、月、日、时、分、秒)
 * @param dateString 日期字符串
 * @param formateType 日期格式类型
 */
+ (NSArray *)dateSplitWithDateString:(NSString *)dateString formate:(FormateType)formateType
{
    NSDateFormatter *f = [self dateFormateWithType:formateType];
    NSDate *d = [f dateFromString:dateString];
    
    // 日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:d];
    
    NSString *yearStr = [NSString stringWithFormat:@"%ld",(long)dateComponent.year];
    NSString *monthStr = [NSString stringWithFormat:@"%02ld",(long)dateComponent.month];
    NSString *dayStr = [NSString stringWithFormat:@"%02ld",(long)dateComponent.day];
    NSString *hourStr = [NSString stringWithFormat:@"%02ld",(long)dateComponent.hour];
    NSString *minuteStr = [NSString stringWithFormat:@"%02ld",(long)dateComponent.minute];
    NSString *secondStr = [NSString stringWithFormat:@"%02ld",(long)dateComponent.second];
    return @[yearStr,monthStr,dayStr,hourStr,minuteStr,secondStr];
}


#pragma mark - 公用
/**
 * 根据formateType返回对应的formate
 * @param formateType 格式类型
 */
+ (NSString *)formateWithType:(FormateType)formateType
{
    NSString *formateStr = @"yyyy-MM-dd HH:mm:ss";
    switch (formateType) {
        case FormateTypeYMDHMS:
            formateStr = @"yyyy-MM-dd HH:mm:ss";
            break;
        case FormateTypeYMDHM:
            formateStr = @"yyyy-MM-dd HH:mm";
            break;
        case FormateTypeYMD:
            formateStr = @"yyyy-MM-dd";
            break;
        case FormateTypeYM:
            formateStr = @"yyyy-MM";
            break;
        default:
            break;
    }
    return formateStr;
}

/**
 * 根据格式类型获取 NSDateFormatter 对象
 * @param formateType 格式类型
 */
+ (NSDateFormatter *)dateFormateWithType:(FormateType)formateType
{
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    f.dateFormat = [self formateWithType:formateType];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [f setTimeZone:timeZone];
    return f;
}

@end
