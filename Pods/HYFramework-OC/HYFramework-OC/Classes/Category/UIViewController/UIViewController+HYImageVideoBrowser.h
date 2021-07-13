//
//  UIViewController+HYImageVideoBrowser.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/14.
//

#import <UIKit/UIKit.h>
#import "HYImageVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYImageVideoBrowser)

/**
 * 图片/视频预览(支持在线图片,本地图片,在线视频)
 * @param imageVideos 图片/视频数据
 * @param currentIndex 从第几个开始预览
 * @param inController 在哪个控制器里面展示
 */
+ (void)previewImageVideo:(NSArray <HYImageVideoModel *>*)imageVideos currentIndex:(NSInteger)currentIndex inController:(UIViewController *)inController;

/**
 * 图片/视频预览,在app的rootViewController展示(支持在线图片,本地图片,在线视频)
 * @param imageVideos 图片/视频数据
 * @param currentIndex 从第几个开始预览
 */
+ (void)previewImageVideo:(NSArray <HYImageVideoModel *>*)imageVideos currentIndex:(NSInteger)currentIndex;

/**
 * 图片/视频预览(从第一个开始预览)
 * (支持在线图片,本地图片,在线视频)
 * @param imageVideos 图片/视频数据
 */
+ (void)previewImageVideo:(NSArray <HYImageVideoModel *>*)imageVideos;

@end

NS_ASSUME_NONNULL_END
