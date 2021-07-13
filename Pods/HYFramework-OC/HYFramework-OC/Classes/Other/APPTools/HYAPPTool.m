//
//  HYAppTool.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "HYAPPTool.h"

@implementation HYAPPTool

/**
 * 获取APP完整信息
 */
+ (NSDictionary *)appFullInfo
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}

// APP名称
+ (NSString *)appName
{
    NSDictionary *infoDictionary = [self appFullInfo];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}

// APP版本号
+ (CGFloat)appVersion
{
    NSDictionary *infoDictionary = [self appFullInfo];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [appVersion floatValue];
}

// APP build version
+ (CGFloat)appBuildVersion
{
    NSDictionary *infoDictionary = [self appFullInfo];
    NSString *appBuildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    return [appBuildVersion floatValue];
}

// 打开url
+ (void)openUrl:(NSURL *)url
{
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }else {
        NSLog(@"无法打开的url:%@",url);
    }
}

@end
