//
//  HYAFttpTool.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "HYAFttpTool.h"
#import "HYConstMacro.h"
#import "HYAPIConfig.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+HYAdd.h"
#import "NSObject+HYAdd.h"
#import "HYVideoTool.h"
#import "NSString+HYAdd.h"

@implementation HYAFHttpClient

// 单例
+ (instancetype)sharedClient
{
    static HYAFHttpClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HYAFHttpClient alloc] initWithBaseURL:[NSURL URLWithString:HYAPI_BASE_URL]];
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects: @"text/plain",@"application/json", @"text/html", @"text/json", @"text/javascript", nil];
//        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}

@end

@implementation HYAFttpTool

#pragma mark - AFN网络请求
+ (void)requestWithType:(RequestType)requestType
            networkPath:(NSString *)path
                 params:(NSDictionary *)params
                headers:(NSDictionary<NSString *,NSString *> *)headers
                success:(HYHttpSuccessBlock)success
                failure:(HYHttpFailureBlock)failure
               dataType:(ReturnDataType)type showHUD:(BOOL)isShow{
    if (requestType == RequestType_GET) {
        [self GETWithPath:path params:params headers:headers success:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        } dataType:type showHUD:isShow];
    }
    if (requestType == RequestType_POST) {
        [self POSTWithPath:path params:params headers:headers success:^(id responseObject) {
            success(responseObject);
        } failure:^(NSError *error) {
            failure(error);
        } dataType:type showHUD:isShow];
    }
}

#pragma mark POST请求
+ (void)POSTWithPath:(NSString *)path
              params:(NSDictionary *)params
             headers:(NSDictionary<NSString *,NSString *> *)headers
             success:(HYHttpSuccessBlock)success
             failure:(HYHttpFailureBlock)failure
            dataType:(ReturnDataType )type
             showHUD:(BOOL)isShow{
    HYAFHttpClient * manager = [HYAFHttpClient sharedClient];
    manager.requestSerializer.timeoutInterval = 30;
    if (type == ReturnDataType_XML || type == ReturnDataType_HTML) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    if (type == ReturnDataType_TEXT_HTML) {
        NSSet *set = [NSSet setWithObject:@"text/html"];
        [manager.responseSerializer setAcceptableContentTypes:set];
    }
    if (isShow) {
        WAITING
    }
    
    // 设置header
    for (NSString *key in headers) {
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    
    
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DISMISS
        if (success == nil) return;
        switch (type) {
            case ReturnDataType_XML:
            {
                NSString * result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (success && result) {
                    success(result);
                }
            }
                break;
            case ReturnDataType_HTML:
            {
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
                if (response.statusCode == 200){
                    if (success ) {
                        success(responseObject);
                    }

                }else{
                    [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
                }
            }
                break;
            default:
            {
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
                if (response.statusCode == 200){
                    NSDictionary * dataDic = (NSDictionary *)responseObject;
                    if (dataDic && success) {
                        success(dataDic);
                    }
                }else{
                    [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
                }
            }
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DISMISS
        if (![[self returnErrorWithError:error].localizedDescription isNULL]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure && error) {
            failure([self returnErrorWithError:error]);
        }
    }];
}
#pragma mark GET请求
+ (void)GETWithPath:(NSString *)path
             params:(NSDictionary *)params
            headers:(NSDictionary<NSString *,NSString *> *)headers
            success:(HYHttpSuccessBlock)success
            failure:(HYHttpFailureBlock)failure
           dataType:(ReturnDataType)type
            showHUD:(BOOL)isShow{
    HYAFHttpClient *manager = [HYAFHttpClient sharedClient];
    manager.requestSerializer.timeoutInterval = 30;
    if (type == ReturnDataType_XML || type == ReturnDataType_HTML) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    if (type == ReturnDataType_TEXT_HTML) {
        NSSet *set = [NSSet setWithObject:@"text/html"];
        [manager.responseSerializer setAcceptableContentTypes:set];
    }
    if (isShow) {
        WAITING
    }
    
    // 设置header
    for (NSString *key in headers) {
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DISMISS
        if (success == nil) return;
        switch (type) {
            case ReturnDataType_XML:
            {
                NSString * result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                if (success && result) {
                    success(result);
                }
            }
                break;
            case ReturnDataType_HTML:
            {
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
                if (response.statusCode == 200){
                    if (success ) {
                        success(responseObject);
                    }

                }else{
                    [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
                }
            }
                break;
            default:
            {
                NSHTTPURLResponse * response = (NSHTTPURLResponse *)task.response;
                if (response.statusCode == 200){
                    NSDictionary * dataDic = (NSDictionary *)responseObject;
                    if (dataDic && success) {
                        success(dataDic);
                    }

                }else{
                    [MBProgressHUD showError:[NSString stringWithFormat:@"%ld",(long)response.statusCode]];
                }
            }
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DISMISS
        if (![[self returnErrorWithError:error].localizedDescription isNULL]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];
}


#pragma mark -
#pragma mark - 取消网络请求
+ (void)cancelAllRequest {
    [[HYAFHttpClient sharedClient].operationQueue cancelAllOperations];
}

#pragma mark -
#pragma mark -- GCD队列请求
/*! 生成请求POST */
+ (NSURLSessionTask *)postTaskWithUrl:(NSString *)url  parameters:(NSDictionary *)parameters completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {
    NSError* error = NULL;
    NSMutableURLRequest * request  = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:parameters error:&error];
    HYAFHttpClient * manager = [[HYAFHttpClient alloc] init];
    NSSet *set = [NSSet setWithObject:@"text/json"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    NSURLSessionTask * postTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completionBlock];
    return postTask;
}
/*! 生成请求GET */
+ (NSURLSessionTask *)getTaskWithUrl:(NSString *)url completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock {
    NSError* error = NULL;
    NSMutableURLRequest * request  = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:nil error:&error];
    HYAFHttpClient * manager = [[HYAFHttpClient alloc] init];
    NSSet *set = [NSSet setWithObject:@"text/json"];
    [manager.responseSerializer setAcceptableContentTypes:set];
    NSURLSessionTask * getTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completionBlock];
    return getTask;
}

+ (void)runDispatchTestWithType:(RequestType)type
                          Paths:(NSArray *)urls
                          paras:(NSArray *)paras
                        success:(HYHttpSuccessBlock)success
                        failure:(HYHttpFaultBlock)failure{
    // 准备保存结果的数组
    NSMutableArray * result = [NSMutableArray array];
    NSMutableArray * errors = [NSMutableArray array];
    for (int i = 0; i < urls.count; i++) {
        [result addObject:[NSNull null]];
        [errors addObject:[NSNull null]];
    }
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < urls.count; i++) {
        dispatch_group_enter(group);
        NSDictionary * para = paras[i];
        if (type == RequestType_POST) {
            NSURLSessionTask * task = [self postTaskWithUrl:urls[i] parameters:para completion:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    @synchronized (errors) {
                        errors[i] = [self returnErrorWithError:error];
                    }
                    dispatch_group_leave(group);
                } else {
                    @synchronized (result) {
                        result[i] = responseObject;
                    }
                    dispatch_group_leave(group);
                }
            }];
            [task resume];
        }
        if (type == RequestType_GET) {
            NSURLSessionTask * task = [self getTaskWithUrl:urls[i] completion:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    @synchronized (errors) {
                        errors[i] = error;
                    }
                    dispatch_group_leave(group);
                } else {
                    @synchronized (result) {
                        result[i] = responseObject;
                    }
                    dispatch_group_leave(group);
                }
            }];
            [task resume];
        }
        
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (failure && errors) {
            failure(errors);
        }
        if (success && result) {
            success(result);
        }

    });
}



#pragma mark ---
#pragma mark --- 图片/视频
+ (void)upLoadWithPaths:(NSArray *)urls
                  paras:(NSArray *)paras
                success:(HYHttpSuccessBlock)success
                failure:(HYHttpFaultBlock)failure{
    // 准备保存结果的数组
    NSMutableArray * result = [NSMutableArray array];
    NSMutableArray * errors = [NSMutableArray array];
    for (int i = 0; i < urls.count; i++) {
        [result addObject:[NSNull null]];
        [errors addObject:[NSNull null]];
    }
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < urls.count; i++) {
        dispatch_group_enter(group);
        UIImage * image = paras[i];
        [self uploadImage:image imageName:[NSString stringWithFormat:@"%@",@(i)] url:urls[i] progress:nil success:^(id responseObject) {
            @synchronized (result) {
                result[i] = responseObject;
            }
            dispatch_group_leave(group);
        } failure:^(id error) {
            @synchronized (errors) {
                errors[i] = error;
            }
            dispatch_group_leave(group);
        }];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (failure && errors) {
            failure(errors);
        }
        if (success && result) {
            success(result);
        }

    });
}
                  
+ (void)uploadImage:(UIImage *)image
          imageName:(NSString *)imageName
                url:(NSString *)url
           progress:(HYHttpProgressBlock)progress
            success:(HYHttpSuccessBlock)success
            failure:(HYHttpFaultBlock)failure{
    NSMutableDictionary *parmeter = [NSMutableDictionary dictionary];
    [parmeter setValue:@"1" forKey:imageName];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 15.0f;
    [manager.requestSerializer setValue:@"application/json;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", nil];
    [manager POST:url parameters:parmeter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = nil;
        if(!UIImagePNGRepresentation(image)) {
            data =UIImageJPEGRepresentation(image,1);
        }else{
            data =UIImagePNGRepresentation(image);
        }
        unsigned long length = [data length]/1000;
        if (length >2048) {
            data =UIImageJPEGRepresentation(image,2048/length);
        }
        if(!UIImagePNGRepresentation(image)) {
            [formData appendPartWithFileData:data name:@"img" fileName:[NSString stringWithFormat:@"%@iosimage.jpeg",imageName] mimeType:@"image/jpeg"];
        }else{
            [formData appendPartWithFileData:data name:@"img" fileName:[NSString stringWithFormat:@"%@iosimage.png",imageName] mimeType:@"image/png"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
  //          NSString * infoStr = [NSString stringWithFormat:@"正在提交...%.1f%%",(uploadProgress.completedUnitCount*1.0/uploadProgress.totalUnitCount)*100];
  //          [MBProgressHUD showMessage:infoStr];
        });
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DISMISS
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DISMISS
        if (![[self returnErrorWithError:error].localizedDescription isNULL]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];
}
                  
+ (void)upLoadMoviePhotoWithPaths:(NSArray *)urls
                            paras:(NSArray *)paras
                          success:(HYHttpSuccessBlock)success
                          failure:(HYHttpFaultBlock)failure{
    // 准备保存结果的数组
    NSMutableArray * result = [NSMutableArray array];
    NSMutableArray * errors = [NSMutableArray array];
    for (int i = 0; i < urls.count; i++) {
        [result addObject:[NSNull null]];
        [errors addObject:[NSNull null]];
    }
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = 0; i < paras.count; i++) {
        dispatch_group_enter(group);
        NSDictionary * dict = paras[i];
        if ([dict[@"type"] isEqualToString:@"1"]) {
            UIImage * image = dict[@"image"];
            [self uploadImage:image imageName:[NSString stringWithFormat:@"%@",@(i)] url:urls[i] progress:nil success:^(id responseObject) {
                NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
                NSDictionary * dict1 = (NSDictionary *)responseObject;
                [dictionary setObject:dict1[@"data"] forKey:@"url"];
                [dictionary setObject:@"1" forKey:@"type"];
                
                @synchronized (result) {
                    result[i] = dictionary;
                }
                dispatch_group_leave(group);
            } failure:^(id error) {
                @synchronized (errors) {
                    errors[i] = error;
                }
                dispatch_group_leave(group);
            }];
        }else{
            NSString * path = dict[@"path"];
            [self uploadMovieWithParam:path movieName:[NSString stringWithFormat:@"%@",@(i)] url:urls[i] success:^(id responseObject) {
                NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithCapacity:3];
                NSDictionary * dict1 = (NSDictionary *)responseObject;
                if (![dict1 isNULL]) {
                    [dictionary setObject:dict1[@"data"] forKey:@"url"];
                    [dictionary setObject:@"2" forKey:@"type"];
                }
                @synchronized (result) {
                    result[i] = dictionary;
                }
                dispatch_group_leave(group);
            } failure:^(id error) {
                @synchronized (errors) {
                    errors[i] = error;
                }
                dispatch_group_leave(group);
            }];
        }
        
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (failure && errors) {
            failure(errors);
        }
        if (success && result) {
            success(result);
        }

    });
}

//视频
+ (void)uploadMovieWithParam:(NSString *)videoPath
                     movieName:(NSString *)videoName
                           url:(NSString *)url
                       success:(HYHttpSuccessBlock)success
                       failure:(HYHttpFaultBlock)failure {
    
    [HYVideoTool convertMovSourceURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",videoPath]] Complete:^(NSString * _Nonnull filePath, NSArray * _Nonnull files) {
        NSLog(@"%@==%@",filePath,files);
        //获取文件的后缀名
        NSString *extension = [filePath componentsSeparatedByString:@"."].lastObject;
        NSString *mimeType = [NSString stringWithFormat:@"video/%@",extension];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer    = [AFJSONResponseSerializer serializer];
        manager.requestSerializer     = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = nil;
        [manager.requestSerializer setTimeoutInterval:20.0];
        [manager.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
//        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",filePath]]];
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSError *error;
            BOOL success = [formData appendPartWithFileURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",filePath]] name:@"img" fileName:[NSString stringWithFormat:@"%@iosVideo.%@",videoName,extension] mimeType:mimeType error:&error];
//            [formData appendPartWithFileData:data name:@"img" fileName:[NSString stringWithFormat:@"%@iosVideo.%@",videoName,extension] mimeType:mimeType];
            if (!success) {
                NSLog(@"error:%@",error);
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            DISMISS
              [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];

            if(success){
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            DISMISS
              [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
        }];
    }];
}

/**
 上传头像
 */
+ (void)uploadWithParameters:(id)parameters UrlString:(NSString *)urlString header:(NSDictionary *)header upImg:(NSData *)upImg imgNamge:(NSString *)imgName successBlock:(HYHttpSuccessBlock)successBlock failureBlock:(HYHttpFaultBlock)failure{
    HYAFHttpClient *manager = [HYAFHttpClient sharedClient];
    manager.requestSerializer.timeoutInterval = 20;
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    //在请求头里 添加自己需要的参数
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
    
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (upImg) {
            [formData appendPartWithFileData:upImg name:imgName fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![[self returnErrorWithError:error].localizedDescription isNULL]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];
}

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
                failureBlock:(HYHttpFaultBlock)failure
{
    HYAFHttpClient *manager = [HYAFHttpClient sharedClient];
    manager.requestSerializer.timeoutInterval = 20;
     manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    //在请求头里 添加自己需要的参数
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    
    // 文件名,如果fileN有值,使用  没值使用当前日期时间作为文件名
    NSString *fileName = fileN;
    if (HYStringEmpty(fileN)) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        fileName = [NSString stringWithFormat:@"%@.%@", dateString,fileType];
    }
    
    // 上传
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (upData) {
            [formData appendPartWithFileData:upData name:name fileName:fileName mimeType:@"Content-Disposition:multipart/form-data"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (![[self returnErrorWithError:error].localizedDescription isNULL]) {
            ERRORWith([self returnErrorWithError:error].localizedDescription)
        }
        if (failure) {
            failure([self returnErrorWithError:error]);
        }
    }];
}

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
            complete:(void (^)(BOOL))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        /* 创建网络下载对象 */
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        /* 下载地址 */
        NSURL *url = [NSURL URLWithString:[urlStr
        stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
        URLFragmentAllowedCharacterSet]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        /* 开始请求下载 */
        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            NSString *pro = [NSString stringWithFormat:@"%.0f％",downloadProgress.fractionCompleted * 100];
            dispatch_async(dispatch_get_main_queue(), ^{
                //如果需要进行UI操作，需要获取主线程进行操作
                if (downProgress) {
                    downProgress(pro);
                }
            });
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            /* 设定下载到的位置 */
            return [NSURL fileURLWithPath:savePath];
                    
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                BOOL suc = error ? NO : YES;
                if (complete) {
                    complete(suc);
                }
            });
        }];
        [downloadTask resume];
    });
}


#pragma mark -
#pragma mark - 网络状态
+ (void)NetworkMonitoringStatus:(HYTheNetworkStatusBlock)state{
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.开启监听
    [manger startMonitoring];
    //3.监听网络状态的改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        state(status);
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知 -1
                INFOWith(@"网络未知")
                break;
            case AFNetworkReachabilityStatusNotReachable://没有网络 0
                INFOWith(@"网络似乎断开了")
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://移动网络 1
                INFOWith(@"当前是移动网络，请注意流量使用")
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WIFI 2
                INFOWith(@"当前是WI-FI")
                break;
            default:
                break;
        }
    }];
}



/**
 error转换中文

 @param error errpr
 @return 结果
 */
+ (NSError *)returnErrorWithError:(NSError *)error{
    NSString *errorMesg = @"";
    switch (error.code) {
        case -1://NSURLErrorUnknown
            errorMesg = @"未知错误";
            break;
        case -999://NSURLErrorCancelled
            errorMesg = @"无效的URL地址";
            break;
        case -1000://NSURLErrorBadURL
            errorMesg = @"无效的URL地址";
            break;
        case -1001://NSURLErrorTimedOut
            errorMesg = @"网络不给力，请稍后再试";
            break;
        case -1002://NSURLErrorUnsupportedURL
            errorMesg = @"不支持的URL地址";
            break;
        case -1003://NSURLErrorCannotFindHost
            errorMesg = @"找不到服务器";
            break;
        case -1004://NSURLErrorCannotConnectToHost
            errorMesg = @"连接不上服务器";
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
            errorMesg = @"请求数据长度超出最大限度";
            break;
        case -1005://NSURLErrorNetworkConnectionLost
            errorMesg = @"网络连接异常";
            break;
        case -1006://NSURLErrorDNSLookupFailed
            errorMesg = @"DNS查询失败";
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
            errorMesg = @"HTTP请求重定向";
            break;
        case -1008://NSURLErrorResourceUnavailable
            errorMesg = @"资源不可用";
            break;
        case -1009://NSURLErrorNotConnectedToInternet
            errorMesg = @"无网络连接";
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
            errorMesg = @"重定向到不存在的位置";
            break;
        case -1011://NSURLErrorBadServerResponse
            errorMesg = @"服务器响应异常";
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
            errorMesg = @"用户取消授权";
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
            errorMesg = @"需要用户授权";
            break;
        case -1014://NSURLErrorZeroByteResource
            errorMesg = @"零字节资源";
            break;
        case -1015://NSURLErrorCannotDecodeRawData
            errorMesg = @"无法解码原始数据";
            break;
        case -1016://NSURLErrorCannotDecodeContentData
            errorMesg = @"无法解码内容数据";
            break;
        case -1017://NSURLErrorCannotParseResponse
            errorMesg = @"无法解析响应";
            break;
        case -1018://NSURLErrorInternationalRoamingOff
            errorMesg = @"国际漫游关闭";
            break;
        case -1019://NSURLErrorCallIsActive
            errorMesg = @"被叫激活";
            break;
        case -1020://NSURLErrorDataNotAllowed
            errorMesg = @"数据不被允许";
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
            errorMesg = @"请求体";
            break;
        case -1100://NSURLErrorFileDoesNotExist
            errorMesg = @"文件不存在";
            break;
        case -1101://NSURLErrorFileIsDirectory
            errorMesg = @"文件是个目录";
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
            errorMesg = @"无读取文件权限";
            break;
        case -1200://NSURLErrorSecureConnectionFailed
            errorMesg = @"安全连接失败";
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
            errorMesg = @"服务器证书失效";
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
            errorMesg = @"不被信任的服务器证书";
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
            errorMesg = @"未知Root的服务器证书";
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
            errorMesg = @"服务器证书未生效";
            break;
        case -1205://NSURLErrorClientCertificateRejected
            errorMesg = @"客户端证书被拒";
            break;
        case -1206://NSURLErrorClientCertificateRequired
            errorMesg = @"需要客户端证书";
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
            errorMesg = @"无法从网络获取";
            break;
        case -3000://NSURLErrorCannotCreateFile
            errorMesg = @"无法创建文件";
            break;
        case -3001:// NSURLErrorCannotOpenFile
            errorMesg = @"无法打开文件";
            break;
        case -3002://NSURLErrorCannotCloseFile
            errorMesg = @"无法关闭文件";
            break;
        case -3003://NSURLErrorCannotWriteToFile
            errorMesg = @"无法写入文件";
            break;
        case -3004://NSURLErrorCannotRemoveFile
            errorMesg = @"无法删除文件";
            break;
        case -3005://NSURLErrorCannotMoveFile
            errorMesg = @"无法移动文件";
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
            errorMesg = @"下载解码数据失败";
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
            errorMesg = @"下载解码数据失败";
            break;
    }
    // 重点： 根据错误的code码，替换AFN传入的error 中NSLocalizedDescriptionKey键值对，重新组装返回
    NSMutableDictionary *errorInfo = [[NSMutableDictionary alloc]initWithDictionary:error.userInfo];
    [errorInfo setObject:errorMesg forKey:NSLocalizedDescriptionKey];
    NSError *newError = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:4 userInfo:errorInfo];
    return newError;
}

@end
