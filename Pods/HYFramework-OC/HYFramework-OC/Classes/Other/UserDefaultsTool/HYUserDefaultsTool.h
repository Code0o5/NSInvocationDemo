//
//  HYUserDefaultTool.h
//  AFNetworking
//
//  Created by 臻尚 on 2021/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUserDefaultsTool : NSObject

/**
 * 保存对象到磁盘
 * @param key key值
 * @param value value值
 */
+ (void)saveObjWithKey:(NSString *)key value:(id)value;

/**
 * 读取磁盘上对象
 * @param key key值
 * @return 读取到的值
 */
+ (id)readObjWithKey:(NSString *)key;

/**
 * 保存布尔值到磁盘
 * @param key key值
 * @param value value值
 */
+ (void)saveBoolWithKey:(NSString *)key value:(BOOL)value;

/**
 * 读取磁盘上布尔值
 * @param key key值
 * @return 读取到的值
 */
+ (BOOL)readBoolWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
