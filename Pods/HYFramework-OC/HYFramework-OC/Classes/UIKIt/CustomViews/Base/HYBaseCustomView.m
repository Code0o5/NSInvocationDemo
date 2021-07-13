//
//  MyBaseCustemView.m
//  findme
//
//  Created by 臻尚 on 2021/2/20.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYBaseCustomView.h"
#import "HYConstMacro.h"
#import "UIView+HYAdd.h"

@interface HYBaseCustomView ()

@end

@implementation HYBaseCustomView

#pragma mark - 工厂方法
// 自定义view初始化
+ (instancetype)view
{
    HYBaseCustomView *v = [[self alloc]init];
    
    // 默认frame
    v.frame = HYSCREEN_Bounds;
    
    // 设置子view
    [v setupSubViews];
    
    return v;
}

#pragma mark - 设置子视图
// 设置子视图
- (void)setupSubViews
{
    [super setupSubViews];
    
}

@end
