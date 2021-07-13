//
//  MyBaseCustemView.h
//  findme
//
//  Created by 臻尚 on 2021/2/20.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYBaseCustomView : UIView

// 背景视图
@property (nonatomic, weak) UIView *bgView;

#pragma mark - 工厂方法
// 自定义view初始化
+ (instancetype)view;

@end

NS_ASSUME_NONNULL_END
