//
//  UIViewController+HYDocumentPicker.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//


/**
 * 从系统'文件APP'选择文件,限与iOS11.0以上系统
 */


#import <UIKit/UIKit.h>
#import "HYFileModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ _Nullable FileCompleteBlock)(HYFileModel *fileModel, BOOL success, NSError * _Nullable error);

@interface UIViewController (HYDocumentPicker)<UIDocumentPickerDelegate>

/**
 文件选择完成回调
 fileData 文件二进制
 fileName 文件名称
 fileType 文件类型
 */
@property (nonatomic, copy) FileCompleteBlock filePickCompleteBlock;

/**
 * 打开系统文件APP,选择文件(在指定控制器内打开)
 * @param ctr 在哪个控制器打开
 * @param complete 完成回调
 */
- (void)openDocumentPickerViewInController:(UIViewController *)ctr complete:(FileCompleteBlock)complete;

/**
 * 打开系统文件APP,选择文件(在当前控制器内打开)
 * @param complete 完成回调
 */
- (void)openDocumentPickerViewComplete:(FileCompleteBlock)complete;

/**
 * 打开系统文件APP,选择文件(在root控制器内打开)
 * @param complete 完成回调
 */
- (void)openDocumentPickerViewInRootController:(FileCompleteBlock)complete;

@end

NS_ASSUME_NONNULL_END
