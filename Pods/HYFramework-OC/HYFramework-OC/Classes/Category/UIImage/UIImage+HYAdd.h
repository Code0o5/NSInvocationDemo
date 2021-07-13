//
//  UIImage+HYAdd.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (HYAdd)

/**
 *  压缩图片尺寸
 *
 *  @param defineWidth 图片最大宽度
 *
 *  @return 真实图片
 */

- (UIImage *)imageCompressWithTargetWidth:(CGFloat)defineWidth;

/**
 * 获取视频第一帧
 * @param path 图片地址(本地视频或者在线视频)
 */
+ (UIImage *)getVideoImageWithUrl:(NSURL *)path;

/**
 * 获取视频第一帧(异步，子线程执行)
 * @param path 图片地址(本地视频或者在线视频)
 * @param complete 获取完成回调
 */
+ (void)getVideoImageAsynWithUrl:(NSURL *)path complete:(void (^)(UIImage *img))complete;

/**
 * 图片/视频预览
 * @param imagesData 图片/视频数据集合
 * @param currentModel 当前要预览的图片数据模型
 */
//+ (void)imagePreviewWithPhotos:(NSArray <ZhenImageOrVideoModel *>*)imagesData
//                  currentModel:(ZhenImageOrVideoModel *)currentModel;


/**
 * 根据指定颜色生成图片
 * @param color 颜色
 * @param size  生成图片的大小
 * @return 生成的图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;



@end

NS_ASSUME_NONNULL_END
