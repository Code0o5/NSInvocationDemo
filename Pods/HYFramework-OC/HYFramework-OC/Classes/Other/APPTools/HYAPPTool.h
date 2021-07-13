//
//  HYAppTool.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYAPPTool : NSObject

/**
 * 获取APP完整信息
 */
+ (NSDictionary *)appFullInfo;

// APP名称
+ (NSString *)appName;

// APP版本号
+ (CGFloat)appVersion;

// APP build version
+ (CGFloat)appBuildVersion;

// 打开url
+ (void)openUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
