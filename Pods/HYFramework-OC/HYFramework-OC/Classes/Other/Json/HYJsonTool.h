//
//  HYJsonTool.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYJsonTool : NSObject

/**
 * json对象转换成字符串
 * @param obj 标准json对象
 * @return 转换结果,如果转换失败返回nil
 */
+ (NSString *)jsonStringWithJsonObj:(id)obj;

/**
 * json字符串转换成json对象
 * @param jsonStr json字符串
 * @return 转换后的json对象
 */
+ (id)jsonObjWithJsonString:(NSString *)jsonStr;

@end

NS_ASSUME_NONNULL_END
