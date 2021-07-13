//
//  ZhenIndicatorImgView.h
//  findme
//
//  Created by 臻尚 on 2021/3/11.
//  Copyright © 2021 Zhen. All rights reserved.
//

/**
 * 游标是imageView的类
 */

#import "HYIndicatorView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYIndicatorImgView : HYIndicatorView

// 游标图片名(默认 icon_oral_primary)
@property (nonatomic, copy) NSString *flageImageName;

// 游标宽高(默认 10)
@property (nonatomic, assign) CGFloat flagSize;
// 游标top约束间距(默认 15)
@property (nonatomic, assign) CGFloat flagTopConstrain;

@end

NS_ASSUME_NONNULL_END
