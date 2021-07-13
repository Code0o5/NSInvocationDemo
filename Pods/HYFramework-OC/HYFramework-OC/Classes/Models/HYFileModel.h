//
//  HYFileModel.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/26.
//

#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYFileModel : HYBaseModel

// 文件二进制数据
@property (nonatomic, strong) NSData *data;

// 文件名
@property (nonatomic, copy) NSString *fileName;

// 文件本地路径
@property (nonatomic, copy) NSString *localPath;

// 文件远程路径,一般是上传完成，服务器返回的网络半路径
@property (nonatomic, copy) NSString *remotePath;

// 文件远程url,上传完成后服务器返回的网络全路径
@property (nonatomic, copy) NSString *remoteUrl;

// 文件后缀类型,一般为文件后缀名，比如：png,jpg,doc,docx,txt等
@property (nonatomic, copy) NSString *fileType;

@end

NS_ASSUME_NONNULL_END
