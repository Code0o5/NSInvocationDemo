//
//  WGVideoTool.h
//  findmiHotel
//
//  Created by 帅棋 on 2020/12/5.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYVideoTool : NSObject
/**
 通过网址，获取视频第一针
 */
+ (void)getVideoPreViewImageURL:(NSURL *)path
                   imageSuccess:(void (^)(UIImage *image))imageSuccess;

/**
 获取视频本地地址及时长
 */
+ (void)getVideoPathFromPHAsset:(PHAsset *)asset
                       Complete:(void (^)(NSString *filePatch, NSData *data, NSString *dTime))result;
/**
 获取视频缩略图
 */
+ (void)getVideoImageFromPHAsset:(PHAsset *)asset
                        Complete:(void (^)(UIImage *image))resultBack;


/**
 转换为MP4
 */
+ (void)convertMovSourceURL:(NSURL *)sourceUrl
                   Complete:(void (^)(NSString * filePath, NSArray *files))result;
@end

NS_ASSUME_NONNULL_END
