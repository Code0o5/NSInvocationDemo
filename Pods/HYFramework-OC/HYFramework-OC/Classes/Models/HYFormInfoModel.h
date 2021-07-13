//
//  ZhenFormInfoModel.h
//  findme
//
//  Created by 臻尚 on 2021/2/24.
//  Copyright © 2021 Zhen. All rights reserved.
//

/**
 本类功能: 表单页面分块创建view，该model存储每一块的信息
 */
#import "HYFormInfoModel.h"
#import "HYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

// 样式类型
typedef NS_ENUM(NSInteger, SegmentType) {
    segmentTypeInputSingle,     // 输入单行文字内容
    segmentTypeInputMulti,      // 输入多行文本
    segmentTypeSelectContent,   // 选择内容
    segmentTypeSelectImage,     // 选择图片
};

// 标题位置类型
typedef NS_ENUM(NSInteger, TitlePosition) {
    TitlePositionTop,           // 顶部
    TitlePositionInnerLeft,     // 和输入框同在一个背景视图内，居左
};

@interface HYFormInfoModel : HYBaseModel

// 样式类型
@property (nonatomic, assign) SegmentType segmentType;
// 是否有标题
@property (nonatomic, assign, getter=isShowTitle) BOOL showTitle;
// 标题内容
@property (nonatomic, copy) NSString *titleText;
// 标题位置
@property (nonatomic, assign) TitlePosition titlePosition;
// 占位文字
@property (nonatomic, copy) NSString *placeholdText;

@end

NS_ASSUME_NONNULL_END
