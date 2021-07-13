//
//  HYUserSingleton.h
//  AFNetworking
//
//  Created by 臻尚 on 2021/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYUserSingleton : NSObject

// 账号
@property (nonatomic, copy, nullable) NSString *account;

// 用户名
@property (nonatomic, copy, nullable) NSString *userName;

// token
@property (nonatomic, copy, nullable) NSString *token;

// 是否已经认证
@property (nonatomic, assign) int ifApprove;

// 是否登录
@property (nonatomic, assign) BOOL isLogin;

#pragma mark - 单利
+ (instancetype)share;

#pragma mark - 其他
// 保存用户信息到磁盘
- (void)saveUserInfoOnDisk;

// 从磁盘读取用户信息
- (void)readUserInfoFromDisk;

// 清空用户信息（退出登录时使用）
- (void)clearAllUserInfo;

@end

NS_ASSUME_NONNULL_END
