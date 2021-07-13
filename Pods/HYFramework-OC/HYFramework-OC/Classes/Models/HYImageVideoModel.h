//
//  ZhenImageOrVideoModel.h
//  findme
//
//  Created by 臻尚 on 2021/3/3.
//  Copyright © 2021 Zhen. All rights reserved.
//

/**
 本类功能: 从相册选择的图片/视频数据模型
 */
#import "HYFileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYImageVideoModel : HYFileModel

// 图片（如果是视频，表示视频封面）
@property (nonatomic, strong) UIImage *image;

// 是否是视频
@property (nonatomic, assign, getter=isVideo) BOOL video;

// 视频时长
@property (nonatomic, assign) NSInteger videoDuration;

@end

NS_ASSUME_NONNULL_END
