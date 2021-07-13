//
//  UIViewController+HYImageVideoBrowser.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/14.
//

#import "UIViewController+HYImageVideoBrowser.h"
#import "HYConstMacro.h"
#import "ZLPhotoBrowser.h"
#import "NSString+HYAdd.h"

@implementation UIViewController (HYImageVideoBrowser)

/**
 * 图片/视频预览(支持在线图片,本地图片,在线视频)
 * @param imageVideos 图片/视频数据
 * @param currentIndex 从第几个开始预览
 * @param inController 在哪个控制器里面展示
 */
+ (void)previewImageVideo:(NSArray <HYImageVideoModel *>*)imageVideos currentIndex:(NSInteger)currentIndex inController:(UIViewController *)inController
{
    //查看图片
    NSMutableArray *previewImageVideos = [NSMutableArray new];
    for (HYImageVideoModel *imageVideoModel in imageVideos) {
        NSMutableDictionary *params = [NSMutableDictionary new];
        if (imageVideoModel.image) {
            // 本地图片
            params[ZLPreviewPhotoTyp] = @(ZLPreviewPhotoTypeUIImage);
            params[ZLPreviewPhotoObj] = imageVideoModel.image;
        }else if (!HYStringEmpty(imageVideoModel.remoteUrl)){
            // 在线图片或视频
            if (imageVideoModel.isVideo) {
                // 在线视频
                params[ZLPreviewPhotoTyp] = @(ZLPreviewPhotoTypeURLVideo);
                params[ZLPreviewPhotoObj] = [NSURL URLWithString:imageVideoModel.remoteUrl];
            }else {
                // 在线图片
                params[ZLPreviewPhotoTyp] = @(ZLPreviewPhotoTypeURLImage);
                params[ZLPreviewPhotoObj] = [NSURL URLWithString:imageVideoModel.remoteUrl];
            }
        }

        [previewImageVideos addObject:params];
    }
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    ac.sender = inController;
    [ac previewPhotos:previewImageVideos index:currentIndex hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
    }];
}

/**
 * 图片/视频预览,在app的rootViewController展示(支持在线图片,本地图片,在线视频)
 * @param imageVideos 图片/视频数据
 * @param currentIndex 从第几个开始预览
 */
+ (void)previewImageVideo:(NSArray <HYImageVideoModel *>*)imageVideos currentIndex:(NSInteger)currentIndex
{
    [self previewImageVideo:imageVideos currentIndex:currentIndex inController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

/**
 * 图片/视频预览,在app的rootViewController展示(从第一个开始预览)
 * (支持在线图片,本地图片,在线视频)
 * @param imageVideos 图片/视频数据
 */
+ (void)previewImageVideo:(NSArray <HYImageVideoModel *>*)imageVideos
{
    [self previewImageVideo:imageVideos currentIndex:0];
}


@end
