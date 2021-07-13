//
//  ZhenImageView.h
//  findme
//
//  Created by 臻尚 on 2021/3/3.
//  Copyright © 2021 Zhen. All rights reserved.
//

/**
 本类功能: 为了让imageView能携带自定义的数据
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYImageView : UIImageView

// 自定义数据
@property (nonatomic, weak) id data;

@end

NS_ASSUME_NONNULL_END
