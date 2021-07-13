//
//  ZhenFormSegmentView.h
//  findme
//
//  Created by 臻尚 on 2021/2/24.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFormInfoModel.h"
#import "HYImageVideoModel.h"
#import "HYTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYFormSegmentView : UIView

// 数据模型 存储界面样式数据
@property (nonatomic, strong) HYFormInfoModel *model;

// 是否可编辑
@property (nonatomic, assign) BOOL canEdit;

// 标题
@property (nonatomic, strong, readonly) UILabel *tLabel;

// 输入框背景
@property (nonatomic, weak, readonly) UIView *inputBgView;

// 单行输入框
@property (nonatomic, weak, readonly) UITextField *inputTf;

// 多行输入框
@property (nonatomic, weak, readonly) HYTextView *inputTV;

// 选择按钮点击回调
@property (nonatomic, copy) void (^selectBtnClickBlock)(void);

// 上传点击回调
@property (nonatomic, copy) void (^chooseImageBlock)(void);

// 点击图片回调
@property (nonatomic, copy) void (^imageClickBlock)(HYImageVideoModel *m);

// 删除图片/视频按钮点击回调
@property (nonatomic, copy) void (^delBtnClickBlock)(HYFormSegmentView *v,HYImageVideoModel *imageModel);

#pragma mark - 初始化
- (instancetype)initWithSuperView:(UIView *)superView;

// 刷新图片/视频列表
- (void)reloadImageOrVideoViews:(NSArray <HYImageVideoModel *>*)data;

// 添加一个图片/视频
- (void)addImageOrVideo:(HYImageVideoModel *)model;

@end

NS_ASSUME_NONNULL_END
