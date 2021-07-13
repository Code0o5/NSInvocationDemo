//
//  HYUserDefaultTool.m
//  AFNetworking
//
//  Created by 臻尚 on 2021/5/24.
//

#import "HYUserDefaultsTool.h"
#import "HYFramework.h"

@implementation HYUserDefaultsTool

/**
 * 保存对象到磁盘
 * @param key key值
 * @param value value值
 */
+ (void)saveObjWithKey:(NSString *)key value:(id)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (HYObjectEmpty(value)) {
        [userDefaults setObject:nil forKey:key];
    }else {
        [userDefaults setObject:value forKey:key];
    }
    [userDefaults synchronize];
}

/**
 * 读取磁盘上对象
 * @param key key值
 * @return 读取到的值
 */
+ (id)readObjWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}


/**
 * 保存布尔值到磁盘
 * @param key key值
 * @param value value值
 */
+ (void)saveBoolWithKey:(NSString *)key value:(BOOL)value
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
    [userDefaults synchronize];
}

/**
 * 读取磁盘上布尔值
 * @param key key值
 * @return 读取到的值
 */
+ (BOOL)readBoolWithKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults boolForKey:key];
}


@end
