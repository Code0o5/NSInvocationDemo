//
//  UIViewController+HYDocumentPicker.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIViewController+HYDocumentPicker.h"
#import <objc/runtime.h>
#import "UIViewController+HYAlert.h"
#import "HYDeviceTool.h"
#import "HYConstMacro.h"
#import "NSDate+HYAdd.h"

static char filePickerBlock;

@implementation UIViewController (HYDocumentPicker)

#pragma mark - 关联属性
//getter
- (FileCompleteBlock)filePickCompleteBlock
{
    return objc_getAssociatedObject(self, &filePickerBlock);
}
- (void)setFilePickCompleteBlock:(FileCompleteBlock)filePickCompleteBlock
{
    objc_setAssociatedObject(self, &filePickerBlock, filePickCompleteBlock, OBJC_ASSOCIATION_COPY);
}

#pragma mark - 文件选择
/**
 * 打开系统文件APP,选择文件(在指定控制器内打开)
 * @param ctr 在哪个控制器打开
 * @param complete 完成回调
 */
- (void)openDocumentPickerViewInController:(UIViewController *)ctr complete:(FileCompleteBlock)complete
{
    CGFloat systemVersion = [HYDeviceTool deviceSystemVersion];
    if (systemVersion < 11.0) {
        [self showAlertWithTitle:nil message:@"系统版本低于11.0,不支持该功能" btnTitles:@[@"确定"] btnActionBlocks:@[^{}]];
        return;
    }
    
    self.filePickCompleteBlock = complete;
    
    // 打开文件app
    NSArray *documentType = @[
        @"public.content",
        @"public.text",
        @"public.source-code",
        @"public.image",
        @"public.audiovisual-content",
        @"com.adobe.pdf",
        @"com.apple.keynote.key",
        @"com.microsoft.word.doc",
        @"com.microsoft.excel.xls",
        @"com.microsoft.powerpoint.ppt"];
    UIDocumentPickerViewController *pickerController = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:documentType inMode:UIDocumentPickerModeOpen];
    pickerController.delegate = self;
    [ctr presentViewController:pickerController animated:YES completion:nil];
}


/**
 * 打开系统文件APP,选择文件(在当前控制器内打开)
 * @param complete 完成回调
 */
- (void)openDocumentPickerViewComplete:(FileCompleteBlock)complete
{
    [self openDocumentPickerViewInController:self complete:complete];
}

/**
 * 打开系统文件APP,选择文件(在root控制器内打开)
 * @param complete 完成回调
 */
- (void)openDocumentPickerViewInRootController:(FileCompleteBlock)complete
{
    UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [self openDocumentPickerViewInController:rootController complete:complete];
}

#pragma mark - UIDocumentPickerDelegate
// 文件选择完成
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls
{
    WeakSelf
    
    // model
    HYFileModel *fModel = [HYFileModel model];
    
    // 获取授权
    BOOL fileUrlAuthozied = [urls.firstObject startAccessingSecurityScopedResource];
    if (fileUrlAuthozied) {
        // 通过文件协调工具来得到新的文件地址，以此得到文件保护功能
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        
        [fileCoordinator coordinateReadingItemAtURL:urls.firstObject options:0 error:&error byAccessor:^(NSURL *newURL) {
            // 读取文件
            NSString *fileName = [newURL lastPathComponent];
            NSError *error = nil;
            NSData *fileData = [NSData dataWithContentsOfURL:newURL options:NSDataReadingMappedIfSafe error:&error];
            NSString *extension = [newURL pathExtension];
            
            fModel.data = fileData;
            fModel.fileType = extension;
            if (fileName.length == 0) {
                // 时间戳作为图片名
                fileName = [NSString stringWithFormat:@"%@.%@",[NSDate currentTimestamp],extension];
            }
            fModel.fileName = fileName;
            
            if (error) {
                // 读取出错
                if (Weakself.filePickCompleteBlock) {
                    Weakself.filePickCompleteBlock(fModel, NO, error);
                }
            } else {
                // 上传
                if (Weakself.filePickCompleteBlock) {
                    Weakself.filePickCompleteBlock(fModel, YES, error);
                }
            }
        }];
        [urls.firstObject stopAccessingSecurityScopedResource];
    } else {
        // 授权失败
        if (Weakself.filePickCompleteBlock) {
            Weakself.filePickCompleteBlock(fModel, NO, nil);
        }
    }
}

@end
