//
//  UIViewController+HYNetwork.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIViewController+HYNetwork.h"
#import <objc/runtime.h>
#import "HYConstMacro.h"
#import "HYAFttpTool.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+HYAdd.h"
#import "NSString+HYAdd.h"
#import "JRToast.h"
#import "YYModel.h"

static char HYRequestCompleteBlockKey;
static char HYhttpHeaderKey;
static char HYBaseUrlKey;

@implementation UIViewController (HYNetwork)

#pragma mark - 关联属性
//getter
- (HYRequestCompleteBlock)requestCompleteBlock
{
    return objc_getAssociatedObject(self, &HYRequestCompleteBlockKey);
}
- (void)setRequestCompleteBlock:(HYRequestCompleteBlock)requestCompleteBlock
{
    objc_setAssociatedObject(self, &HYRequestCompleteBlockKey, requestCompleteBlock, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary<NSString *,NSString *> *)httpHeader
{
    return objc_getAssociatedObject(self, &HYhttpHeaderKey);
}
- (void)setHttpHeader:(NSDictionary<NSString *,NSString *> *)httpHeader
{
    objc_setAssociatedObject(self, &HYhttpHeaderKey, httpHeader, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)baseUrl
{
    return objc_getAssociatedObject(self, &HYBaseUrlKey);
}
- (void)setBaseUrl:(NSString *)baseUrl
{
    objc_setAssociatedObject(self, &HYBaseUrlKey, baseUrl, OBJC_ASSOCIATION_COPY);
}

#pragma mark - POST请求
/**
 * post请求
 * @param path       请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
             showHud:(BOOL)showHud
{
    if (showHud) {
        [self showHud];
    }
    
    // url拼接
    if (![path hasPrefix:@"http"] && self.baseUrl.length > 0) {
        path = [NSString stringWithFormat:@"%@/%@",self.baseUrl,path];
    }
    
    WeakSelf
//    NSString *url = HYAPI_FULL_URL(path);
    NSLog(@"POST请求url:%@",path);
    NSLog(@"POST请求参数:%@",params);
    [HYAFttpTool POSTWithPath:path params:params headers:(self.httpHeader ? self.httpHeader : nil) success:^(id responseObject) {
        NSLog(@"POST请求成功,结果:%@",responseObject);
        
        // 隐藏蒙板
        if (showHud) {
            [Weakself hideHud];
        }
        
        // 结果处理
        [Weakself requestResultHandle:responseObject success:success faile:faile];
    } failure:^(NSError *error) {
        NSLog(@"POST请求失败,错误:%@",error);
        
        // 隐藏蒙板
        if (showHud) {
            [Weakself hideHud];
        }
        
        // 请求失败
        if (faile) {
            faile();
        }
    } dataType:ReturnDataType_DEFAULT showHUD:NO];
}

/**
 * post请求
 * @param path       请求路径
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
{
    [self postWithPath:path params:params success:success faile:nil showHud:YES];
}

/**
 * post请求
 * @param path       请求路径
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)postWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
             showHud:(BOOL)showHud
{
    [self postWithPath:path params:params success:success faile:nil showHud:showHud];
}

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
                    complete:(void (^)(void))complete
{
    // 队列组异步上传文件
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);

    WeakSelf
    [self showHud];
    for (NSDictionary *params in paramList) {
        dispatch_group_enter(group);
    
        dispatch_group_async(group, queue, ^{
            // 执行异步POST请求
            [Weakself postWithPath:path params:params success:^(id  _Nullable result) {
                if (peerSuccess) {
                    peerSuccess(result);
                }
                dispatch_group_leave(group);
            } faile:^{
                dispatch_group_leave(group);
            } showHud:NO];
        });
    }
    
    // 所有任务完成
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        // 隐藏模板
        [self hideHud];
        
        // 所有任务完成
        if (complete) {
            complete();
        }
    });
}

#pragma mark - GET请求
/**
 * get请求
 * @param path       请求路径（传除了BaseUrl的后半部分）
 * @param params    请求参数
 * @param success   请求成功回调
 * @param faile     请求失败回调
 * @param showHud   是否显示蒙板
 */
- (void)getWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^ _Nullable)(id _Nullable result))success
               faile:(void (^ _Nullable)(void))faile
             showHud:(BOOL)showHud
{
    if (showHud) {
        [self showHud];
    }

    // url拼接
    if (![path hasPrefix:@"http"] && self.baseUrl.length > 0) {
        path = [NSString stringWithFormat:@"%@/%@",self.baseUrl,path];
    }
    
    WeakSelf
    NSLog(@"GET请求url:%@",path);
    NSLog(@"GET请求参数:%@",params);
    [HYAFttpTool GETWithPath:path params:params headers:(self.httpHeader ? self.httpHeader : nil) success:^(id responseObject) {
        NSLog(@"GET请求成功,结果:%@",responseObject);
        
        // 隐藏蒙板
        if (showHud) {
            [Weakself hideHud];
        }
        
        // 结果处理
        [Weakself requestResultHandle:responseObject success:success faile:faile];
    } failure:^(NSError *error) {
        NSLog(@"GET请求失败,错误:%@",error);
        
        // 隐藏蒙板
        if (showHud) {
            [Weakself hideHud];
        }
        
        // 请求失败
        if (faile) {
            faile();
        }
    } dataType:ReturnDataType_DEFAULT showHUD:NO];
}

/**
 * get请求
 * @param path      请求路径
 * @param params    请求参数
 * @param success   请求成功回调
 */
- (void)getWithPath:(NSString *_Nullable)path
             params:(NSDictionary *_Nullable)params
            success:(void (^_Nullable)(id _Nullable result))success
{
    [self getWithPath:path params:params success:success faile:nil showHud:YES];
}

/**
 * get请求
 * @param path       请求路径
 * @param params    请求参数
 * @param success   请求成功回调
 * @param showHud   是否显示蒙板
 */
- (void)getWithPath:(NSString *_Nullable)path
              params:(NSDictionary *_Nullable)params
             success:(void (^_Nullable)(id _Nullable result))success
             showHud:(BOOL)showHud
{
    [self getWithPath:path params:params success:success faile:nil showHud:showHud];
}

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
                    complete:(void (^)(void))complete
{
    // 队列组异步上传文件
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);

    WeakSelf
    [self showHud];
    for (NSDictionary *params in paramList) {
        dispatch_group_enter(group);
    
        dispatch_group_async(group, queue, ^{
            // 执行异步GET请求
            [Weakself getWithPath:path params:params success:^(id  _Nullable result) {
                if (peerSuccess) {
                    peerSuccess(result);
                }
                dispatch_group_leave(group);
            } faile:^{
                dispatch_group_leave(group);
            } showHud:NO];
        });
    }
    
    // 所有任务完成
    dispatch_group_notify(group,dispatch_get_main_queue(), ^{
        // 隐藏模板
        [self hideHud];
        
        // 所有任务完成
        if (complete) {
            complete();
        }
    });
}


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
            showHud:(BOOL)showHud
{
    if (showHud) {
        [self showHud];
    }
    
    // url拼接
    if (![path hasPrefix:@"http"] && self.baseUrl.length > 0) {
        path = [NSString stringWithFormat:@"%@/%@",self.baseUrl,path];
    }

    // 获取当前时间戳作为图片名
    [HYAFttpTool uploadWithParameters:@{} UrlString:path header:@{} upImg:imageData imgNamge:@"img" successBlock:^(id responseObject) {
        // 隐藏蒙板
        if (showHud) {
            [self hideHud];
        }

        NSDictionary *dict = (NSDictionary *)responseObject;
        if([dict[@"code"] intValue] == 200){
            // 成功
            NSString *url = dict[@"data"];
            if (HYStringEmpty(url)) {
                if (faile) {
                    faile();
                }
            }else {
                if (success) {
                    success(url);
                }
            }
        }else {
            if (faile) {
                faile();
            }
        }
    } failureBlock:^(id error) {
        // 隐藏蒙板
        if (showHud) {
            [self hideHud];
        }

        if (faile) {
            faile();
        }
    }];
}

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
                   showHud:(BOOL)showHud
{
    if (showHud) {
        [self showHud];
    }
    
    // url拼接
    if (![path hasPrefix:@"http"] && self.baseUrl.length > 0) {
        path = [NSString stringWithFormat:@"%@/%@",self.baseUrl,path];
    }
    
    WeakSelf
    
    [HYAFttpTool uploadFileWithParameters:params UrlString:path header:(self.httpHeader ? self.httpHeader : @{}) upData:fileModel.data name:fileFieldName fileName:fileModel.fileName fileType:fileModel.fileType successBlock:^(id responseObject) {
        // 隐藏蒙板
        if (showHud) {
            [Weakself hideHud];
        }
        
        NSDictionary *dict = (NSDictionary *)responseObject;
        NSString *msg = @"上传失败";
        if ([dict.allKeys containsObject:@"msg"]) {
            msg = dict[@"msg"];
        }
        if([dict[@"code"] intValue] == 200){
            NSString *url = dict[@"data"];
            if (HYStringEmpty(url)) {
                // 提示信息
                HYShowToast(msg);
                if (faile) {
                    faile();
                }
            }else {
                if (success) {
                    success(url);
                }
            }
        }else {
            // 提示信息
            HYShowToast(msg);
            if (faile) {
                faile();
            }
        }
    } failureBlock:^(id error) {
        // 隐藏蒙板
        if (showHud) {
            [Weakself hideHud];
        }
        
        // 提示信息
        HYShowToast(@"上传失败,请稍后重试");
        
        if (faile) {
            faile();
        }
    }];
}

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
                   showHud:(BOOL)showHud
{
    [self uploadFileWithPath:path params:params fileFieldName:@"file" fileModel:fileModel success:success faile:faile showHud:showHud];
}

/**
 * 上传文件,部分参数用了默认值,方便直接调用
 * @param path 地址
 * @param params 参数
 * @param fileModel 文件模型，包含要上传的文件信息
 * @param success 上传成功回调
 */
- (void)uploadFileWithPath:(NSString *)path
                    params:(NSDictionary *)params
                 fileModel:(HYFileModel *)fileModel
                   success:(void (^)(NSString * _Nullable returnUrl))success
{
    [self uploadFileWithPath:path params:params fileModel:fileModel success:success faile:nil showHud:YES];
}

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
          hiddenHudWhenComplete:(BOOL)hiddenHudWhenComplete
{
    if (filesArray.count > 0) {
        // 队列组异步上传文件
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);

        WeakSelf
        [self showHud];
        for (HYFileModel *fileModel in filesArray) {
            // 如果文件二进制数据为空 忽略上传
            if (fileModel.data.length == 0) {
                if (peerSuccess) {
                    peerSuccess(fileModel,nil);
                }
                continue;
            }
            
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                // 执行异步上传任务
                [Weakself uploadFileWithPath:path params:params fileFieldName:fileFieldName fileModel:fileModel success:^(NSString * _Nullable returnUrl) {
                    fileModel.remotePath = returnUrl;
                    if (peerSuccess) {
                        peerSuccess(fileModel,returnUrl);
                    }
                    dispatch_group_leave(group);
                } faile:^{
                    dispatch_group_leave(group);
                } showHud:NO];
            });
        }
        
        // 所有图片上传完成
        dispatch_group_notify(group,dispatch_get_main_queue(), ^{
            if (complete) {
                complete(YES);
            }
            if (hiddenHudWhenComplete) {
                [self hideHud];
            }
        });
    }else {
        // 没有附件
        if (complete) {
            complete(NO);
        }
    }
}

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
                    complete:(void (^)(BOOL success, NSString *fileP))comple
{
    // 显示加载蒙板
    [self showHud];
    
    // url拼接
    if (![path hasPrefix:@"http"] && self.baseUrl.length > 0) {
        path = [NSString stringWithFormat:@"%@/%@",self.baseUrl,path];
    }
    
    // 创建文件夹
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 创建目录
    [fileManager createDirectoryAtPath:saveDirPath withIntermediateDirectories:YES attributes:nil error:nil];
   
    // 下载文件
    NSString *fileName = fileN;
    if (HYStringEmpty(fileN)) {
        // 不指定文件名,截取文件地址附带的文件名
        fileName = [path lastPathComponent];
    }
    
    // 文件保存路径
    NSString *fileFullPath = [saveDirPath stringByAppendingPathComponent:fileName];
    // 如果文件存在 直接返回文件地址
    if ([fileManager fileExistsAtPath:fileFullPath]) {
        // 加载蒙板消失
        [self hideHud];
        
        if (comple) {
            comple(YES,fileFullPath);
        }
    }else {
        // 下载文件
        HYShowToast(@"开始下载文件");
        
        [HYAFttpTool downloadFile:path savePath:fileFullPath downProgress:^(NSString *pro) {
        } complete:^(BOOL suc) {
            // 加载蒙板消失
            [self hideHud];
            
            if (comple) {
                comple(suc,fileFullPath);
            }
        }];
    }
}

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
                      complete:(void (^)(BOOL success, NSString *fileP))comple
{
    if (HYStringEmpty(path)) {
        HYShowToast(@"文件地址为空，无法下载");
        return;
    }
    
    // 获取cache文件夹路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    NSString *dirPath = [cachePath stringByAppendingPathComponent:saveDirName];
    
    // 下载
    [self downloadFileWithPath:path saveDirPath:dirPath fileName:fileN complete:comple];
}


#pragma mark - 其他
/**
 * json转model
 * @param response 网络请求结果数据(数组或字典)
 * @param modelClass model类
 */
- (id)jsonToModel:(id)response modelClass:(Class)modelClass
{
    id obj = nil;
    if (HYObjIsKindOfClass(response, NSDictionary)) {
        obj = [modelClass yy_modelWithDictionary:response];
    }else if (HYObjIsKindOfClass(response, NSArray)){
        // 数组转换
        obj = [NSArray yy_modelArrayWithClass:modelClass json:response];
    }else {
        NSLog(@"不支持转换的json格式:%@",response);
    }
    
    return obj;
}

/**
 * 从网络请求结果解析数据
 * @param result 网络请求结果
 * @return 数组或字典
 */
- (id)requestResultHandle:(id)result
{
    id obj = nil;
    if (result && HYObjIsKindOfClass(result, NSDictionary)) {
        NSDictionary *dict = (NSDictionary *)result;
        if ([dict.allKeys containsObject:@"AppendData"]) {
            id data = dict[@"AppendData"];
            return data;
        }
    }
    return obj;
}


#pragma mark - 网络请求结果处理
// 请求结果处理
- (void)requestResultHandle:(id)responseObject success:(void (^ _Nullable)(id _Nullable result))success faile:(void (^ _Nullable)(void))faile
{
    NSDictionary *res = (NSDictionary *)responseObject;
    
    if (self.requestCompleteBlock) {
        self.requestCompleteBlock(res,success,faile);
    }
}

#pragma mark - hud
// 开始loading
- (void)showHud
{
    WAITING
}

// 停止loading
- (void)hideHud
{
    DISMISS
}


@end
