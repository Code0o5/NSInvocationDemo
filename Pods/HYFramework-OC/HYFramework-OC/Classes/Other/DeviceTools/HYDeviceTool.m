//
//  HYDeviceTool.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "HYDeviceTool.h"
#import "HYAPPTool.h"

@implementation HYDeviceTool


//手机序列号
+ (NSString *)deviceUniqueId
{
//    NSString *identifierNumber = [[UIDevice currentDevice] u];
//    return identifierNumber;
    return @"";
}

// 手机别名： 用户定义的名称
+ (NSString *)deviceName
{
    NSString *userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}

// 系统名
+ (NSString *)deviceSystemName
{
    //设备名称
    NSString *deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}

// 手机系统版本
+ (CGFloat)deviceSystemVersion
{
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    return [phoneVersion floatValue];
}

//手机型号
+ (NSString *)deviceModel
{
    NSString *phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
}

//地方型号（国际化区域名称）
+ (NSString *)deviceLocalizedModel
{
    NSString *localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}

// 打电话
+ (void)callUpPhone:(NSString *)number
{
    NSString *phone = [NSString stringWithFormat:@"Tel:%@",number];
    [HYAPPTool openUrl:[NSURL URLWithString:phone]];
}

@end
