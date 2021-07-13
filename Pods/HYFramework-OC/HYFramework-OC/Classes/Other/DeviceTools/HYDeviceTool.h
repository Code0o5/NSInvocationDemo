//
//  HYDeviceTool.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYDeviceTool : NSObject

// 手机别名： 用户定义的名称
+ (NSString *)deviceName;

// 系统名
+ (NSString *)deviceSystemName;

// 手机系统版本
+ (CGFloat)deviceSystemVersion;

//手机型号
+ (NSString *)deviceModel;

//地方型号（国际化区域名称）
+ (NSString *)deviceLocalizedModel;

// 打电话
+ (void)callUpPhone:(NSString *)number;

@end

NS_ASSUME_NONNULL_END
