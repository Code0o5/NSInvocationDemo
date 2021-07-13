//
//  UIViewController+HYFilePreview.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

/**
 * 文件预览
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HYFilePreview)<UIDocumentInteractionControllerDelegate>

// 文件预览控制器
@property (nonatomic, strong) UIDocumentInteractionController *documentCtr;

/**
 * 分享文件
 */
- (void)shareFileWithUrl:(NSURL *)url;

/**
 * 预览文件
 */
- (void)previewFileWithUrl:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
