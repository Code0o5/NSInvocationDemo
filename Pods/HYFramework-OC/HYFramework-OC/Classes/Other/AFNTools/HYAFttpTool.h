//
//  HYAFttpTool.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HYConstMacro.h"

NS_ASSUME_NONNULL_BEGIN

// 返回数据接收类型
typedef NS_ENUM(NSInteger, ReturnDataType) {
    ReturnDataType_DEFAULT,         //默认
    ReturnDataType_TEXT_HTML,       // text/html
    ReturnDataType_XML,             // xml
    ReturnDataType_HTML             // html
};

// 请求类型
typedef NS_ENUM(NSInteger, RequestType) {
    RequestType_POST,       // post
    RequestType_GET         // get
};

@interface HYAFHttpClient : AFHTTPSessionManager

// 单利
+ (instancetype)sharedClient;

@end

@interface HYAFttpTool : NSObject

/**
 AFN 请求
 
 @param requestType 请求类型
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param success 请求成功返回值（type）
 @param failure 请求失败值 (NSError)
 */
+ (void)requestWithType:(RequestType)requestType
            networkPath:(NSString *)path
                 params:(NSDictionary *)params
                headers:(NSDictionary<NSString *,NSString *> *)headers
                success:(HYHttpSuccessBlock)success
                failure:(HYHttpFailureBlock)failure
               dataType:(ReturnDataType )type
                showHUD:(BOOL)isShow;

/**
 AFN post请求
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param headers 请求头 NSDictionary
 @param success 请求成功返回值（type）
 @param failure 请求失败值 (NSError)
 */
+ (void)POSTWithPath:(NSString *)path
              params:(NSDictionary *)params
             headers:(NSDictionary<NSString *,NSString *> *)headers
             success:(HYHttpSuccessBlock)success
             failure:(HYHttpFailureBlock)failure
            dataType:(ReturnDataType )type
             showHUD:(BOOL)isShow;

/**
 AFN get请求
 
 @param path URL地址
 @param params 请求参数 (NSDictionary)
 @param headers 请求头 (NSDictionary)
 @param success 请求成功返回值（type）
 @param failure 请求失败值 (NSError)
 */
+ (void)GETWithPath:(NSString *)path
             params:(NSDictionary *)params
            headers:(NSDictionary<NSString *,NSString *> *)headers
            success:(HYHttpSuccessBlock)success
            failure:(HYHttpFailureBlock)failure
           dataType:(ReturnDataType)type
            showHUD:(BOOL)isShow;
/**
 AFN 请求 -- GCD队列请求

 @param type 请求类型-- POST GET
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)runDispatchTestWithType:(RequestType)type
                          Paths:(NSArray *)urls
                           paras:(NSArray *)paras
                         success:(HYHttpSuccessBlock)success
                         failure:(HYHttpFaultBlock)failure;

/**
 图片上传 -- GCD队列请求
 
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)upLoadWithPaths:(NSArray *)urls
                  paras:(NSArray *)paras
                success:(HYHttpSuccessBlock)success
                failure:(HYHttpFaultBlock)failure;
/**
 图片上传
 
 @param image 图片
 @param imageName 图片名称
 @param url 请求地址
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
                url:(NSString *)url
           progress:(HYHttpProgressBlock)progress
            success:(HYHttpSuccessBlock)success
            failure:(HYHttpFaultBlock)failure;

/**
 图片、视频上传 -- GCD队列请求
 
 @param urls URL地址-- 数组
 @param paras 请求参数 --数组
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)upLoadMoviePhotoWithPaths:(NSArray *)urls
                            paras:(NSArray *)paras
                          success:(HYHttpSuccessBlock)success
                          failure:(HYHttpFaultBlock)failure;
/**
 视频上传
 
 @param videoPath 视频地址
 @param videoName 视频名称
 @param url 请求地址
 @param success 请求成功返回值
 @param failure 请求失败值
 */
+ (void)uploadMovieWithParam:(NSString *)videoPath
                     movieName:(NSString *)videoName
                           url:(NSString *)url
                       success:(HYHttpSuccessBlock)success
                       failure:(HYHttpFaultBlock)failure;

/**
 上传图片
 */
+ (void)uploadWithParameters:(id)parameters UrlString:(NSString *)urlString header:(NSDictionary *)header upImg:(NSData *)upImg imgNamge:(NSString *)imgName successBlock:(HYHttpSuccessBlock)successBlock failureBlock:(HYHttpFaultBlock)failure;

/**
 上传视频等文件
 */
+ (void)uploadFileWithParameters:(id)parameters
                   UrlString:(NSString *)urlString
                      header:(NSDictionary *)header
                      upData:(NSData *)upData
                            name:(NSString *)name
                        fileName:(NSString *)fileN
                    fileType:(NSString *)fileType
                successBlock:(HYHttpSuccessBlock)successBlock
                failureBlock:(HYHttpFaultBlock)failure;


#pragma mark - 下载
/**
 * 下载文件
 * @param urlStr 文件地址
 * @param savePath 保存路径
 * @param downProgress 下载进度回调
 * @param complete 下载完成回调
 */
+ (void)downloadFile:(NSString *)urlStr
            savePath:(NSString *)savePath
        downProgress:(void (^)(NSString *))downProgress
            complete:(void (^)(BOOL))complete;


/**
 取消网络请求
 */
+ (void)cancelAllRequest;

/**
 网络状态

 @param state 状态
 */
+ (void)NetworkMonitoringStatus:(HYTheNetworkStatusBlock)state;

@end

NS_ASSUME_NONNULL_END
