//
//  HYJsonTool.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/25.
//

#import "HYJsonTool.h"

@implementation HYJsonTool

/**
 * json对象转换成字符串
 * @param obj 标准json对象
 * @return 转换结果,如果转换失败返回nil
 */
+ (NSString *)jsonStringWithJsonObj:(id)obj
{
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        // 是标准的json对象
        NSString *json = @"";
        NSError *error = nil;
        NSData *ret = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        if (error != nil || ret == nil) {
            NSLog(@"转换json失败:%@",error);
        }else {
            json = [[NSString alloc] initWithData:ret encoding:NSUTF8StringEncoding];
        }
        return json;
    }else {
        // 不是标准的json对象
        NSLog(@"转换json失败,不是标准的json对象:%@",obj);
        return nil;
    }
}


/**
 * json字符串转换成json对象
 * @param jsonStr json字符串
 * @return 转换后的json对象
 */
+ (id)jsonObjWithJsonString:(NSString *)jsonStr
{
    id ret = nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    if (jsonData != nil){
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&err];
    }else {
        // 转换失败
        NSLog(@"json字符串转换成json对象失败:%@",err);
    }
    return ret;
}

@end
