//
//  UIViewController+HYNetwork.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "HYImageVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ _Nullable HYRequestCompleteBlock)(id result, void (^ _Nullable success)(id _Nullable result), void (^ _Nullable faile)(void));

@interface UIViewController (HYNetwork)

/**
 网络请求完成回调
 */
@property (nonatomic, copy) HYRequestCompleteBlock requestCompleteBlock;

// header
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *httpHeader;

// baseUrl
@property (nonatomic, copy) NSString *baseUrl;

#pragma mark - POST请求
/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
             showHud:(BOOL)showHud;

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success;

/**
 * post请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
             showHud:(BOOL)showHud;

/**
 * 用队列组发送多个POST请求(同一个接口调用多次)
 * @param path 地址
 * @param paramList 参数列表
 * @param peerSuccess 每一个文件上传完成回调
 * @param complete 所有图片/文件上传完成回调
 */
- (void)postMultiTaskWithPath:(NSString *)path
                   paramList:(NSArray <NSDictionary *>*)paramList
                 peerSuccess:(void (^)(id peerResult))peerSuccess
                     complete:(void (^)(void))complete;

#pragma mark - GET请求
/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)getWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
            showHud:(BOOL)showHud;

/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)getWithPath:(NSString *_Nullable)path
             params:(NSDictionary *_Nullable)params
            success:(void (^_Nullable)(id _Nullable result))success;

/**
 * get请求
 * @param path      请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)getWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
            showHud:(BOOL)showHud;

/**
 * 用队列组发送多个GET请求(同一个接口调用多次)
 * @param path 地址
 * @param paramList 参数列表
 * @param peerSuccess 每一个文件上传完成回调
 * @param complete 所有图片/文件上传完成回调
 */
- (void)getMultiTaskWithPath:(NSString *)path
                   paramList:(NSArray <NSDictionary *>*)paramList
                 peerSuccess:(void (^)(id peerResult))peerSuccess
                    complete:(void (^)(void))complete;

#pragma mark - 上传文件/图片
/**
 * 上传图片
 * @param path 地址
 * @param imageData 图片二进制
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadImageWithPath:(NSString *)path
                 imageData:(NSData *_Nullable)imageData
            success:(void (^_Nullable)(NSString * _Nullable imgUrl))success
              faile:(void (^_Nullable)(void))faile
            showHud:(BOOL)showHud;


/**
 * 上传文件
 * @param path 地址
 * @param params 参数
 * @param fileFieldName 文件字段名
 * @param fileModel 文件模型，包含要上传的文件信息
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadFileWithPath:(NSString *)path
                    params:(NSDictionary *)params
             fileFieldName:(NSString *)fileFieldName
                 fileModel:(HYFileModel *)fileModel
                   success:(void (^_Nullable)(NSString * _Nullable returnUrl))success
                     faile:(void (^_Nullable)(void))faile
                   showHud:(BOOL)showHud;

/**
 * 上传文件
 * @param path 地址
 * @param params 参数
 * @param fileModel 文件模型，包含要上传的文件信息
 * @param success 上传成功回调
 * @param faile 上传失败回调
 * @param showHud 是否显示蒙板
 */
- (void)uploadFileWithPath:(NSString *)path
                   params:(NSDictionary *)params
                   fileModel:(HYFileModel *)fileModel
                     success:(void (^_Nullable)(NSString * _Nullable returnUrl))success
                       faile:(void (^_Nullable)(void))faile
                     showHud:(BOOL)showHud;

/**
 * 上传文件,部分参数用了默认值,方便直接调用
 * @param path 地址
 * @param params 参数
 * @param fileModel 文件模型，包含要上传的文件信息
 * @param success 上传成功回调
 */
- (void)uploadFileWithPath:(NSString *)path params:(NSDictionary *)params fileModel:(HYFileModel *)fileModel success:(void (^)(NSString * _Nullable returnUrl))success;

/**
 * 用队列组异步上传多张图片或多个文件
 * @param path 地址
 * @param fileFieldName 后台规定的文件字段名
 * @param params 参数
 * @param filesArray 要上传的文件模型数组
 * @param peerSuccess 每一个文件上传完成回调
 * @param complete 所有图片/文件上传完成回调
 * @param hiddenHudWhenComplete 所有文件上传完成是否隐藏蒙版
 */
- (void)uploadMultiFileWithPath:(NSString *)path
                  fileFieldName:(NSString *)fileFieldName
                         params:(NSDictionary *)params
                     filesArray:(NSArray <HYFileModel *>*)filesArray
                    peerSuccess:(void (^)(HYFileModel *fileM,NSString * _Nullable filePath))peerSuccess
                       complete:(void (^)(BOOL hasFile))complete
          hiddenHudWhenComplete:(BOOL)hiddenHudWhenComplete;


#pragma mark - 下载文件
/**
 * 下载文件
 * @param path  文件地址(支持半路径和全路径)
 * @param saveDirPath 文件保存的文件夹路径
 * @param fileN 指定文件名,如果不指定,默认截取文件下载地址最后的文件名
 * @param comple 下载完成回调
 */
- (void)downloadFileWithPath:(NSString *)path
                 saveDirPath:(NSString *)saveDirPath
                    fileName:(NSString *)fileN
                    complete:(void (^)(BOOL success, NSString *fileP))comple;

/**
 * 下载文件到cache目录
 * @param path 文件地址(支持半路径和全路径)
 * @param saveDirName 文件保存的文件夹名称
 * @param fileN 指定文件名,如果不指定,默认截取文件下载地址最后的文件名
 * @param comple 下载完成回调
 */
- (void)downloadFileToCacheDir:(NSString *)path
                   saveDirName:(NSString *)saveDirName
                      fileName:(NSString *)fileN
                      complete:(void (^)(BOOL success, NSString *fileP))comple;


#pragma mark - 其他
/**
 * json转model
 * @param response 网络请求结果
 * @param modelClass model类
 */
- (id)jsonToModel:(id)response modelClass:(Class)modelClass;

/**
 * 从网络请求结果解析数据
 * @param result 网络请求结果
 * @return 数组或字典
 */
- (id)requestResultHandle:(id)result;

#pragma mark - hud
// 开始loading
- (void)showHud;

// 停止loading
- (void)hideHud;

@end

NS_ASSUME_NONNULL_END
