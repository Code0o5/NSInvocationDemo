//
//  UIImage+HYAdd.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "UIImage+HYAdd.h"
#import <AVKit/AVKit.h>

@implementation UIImage (HYAdd)

/**
 *  压缩图片尺寸
 *
 *  @param defineWidth 图片最大宽度
 *
 *  @return 真实图片
 */

- (UIImage *)imageCompressWithTargetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 * 获取视频第一帧(同步，阻塞主线程)
 * @param path 图片地址(本地视频或者在线视频)
 */
+ (UIImage *)getVideoImageWithUrl:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

/**
 * 获取视频第一帧(异步，子线程执行)
 * @param path 图片地址(本地视频或者在线视频)
 * @param complete 获取完成回调
 */
+ (void)getVideoImageAsynWithUrl:(NSURL *)path complete:(void (^)(UIImage *img))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self getVideoImageWithUrl:path];
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(image);
            }
        });
    });
}

/**
 * 图片/视频预览
 * @param imagesData 图片/视频数据集合
 * @param currentModel 当前要预览的图片数据模型
 */
//+ (void)imagePreviewWithPhotos:(NSArray <ZhenImageOrVideoModel *>*)imagesData
//                  currentModel:(ZhenImageOrVideoModel *)currentModel
//{
//    if (imagesData.count == 0) return;
//    
//    // 当前预览图片索引
//    NSInteger currentIndex = 0;
//    if ([imagesData containsObject:currentModel]) {
//        currentIndex = [imagesData indexOfObject:currentModel];
//    }
//    
//    // 设置图片预览数据
//    NSMutableArray *array = [NSMutableArray new];
//    for (ZhenImageOrVideoModel *model in imagesData) {
//        NSMutableDictionary *params = [NSMutableDictionary new];
//        params[ZLPreviewPhotoTyp] = model.isVideo ? @(ZLPreviewPhotoTypeURLVideo) : @(ZLPreviewPhotoTypeURLImage);
//        params[ZLPreviewPhotoObj] = [NSURL URLWithString:ServiceUrlStr(model.imageOrVideoUrl)];
//        [array addObject:params];
//    }
//    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
//    ac.sender = kAppKeyWindow.rootViewController;
//    [ac previewPhotos:array index:currentIndex hideToolBar:YES complete:^(NSArray * _Nonnull photos) {
//    }];
//}

/**
 * 根据指定颜色生成图片
 * @param color 颜色
 * @param size  生成图片的大小
 * @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
