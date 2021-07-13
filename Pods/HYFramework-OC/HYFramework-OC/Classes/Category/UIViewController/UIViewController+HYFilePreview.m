//
//  UIViewController+HYFilePreview.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/24.
//

#import "UIViewController+HYFilePreview.h"
#import <objc/runtime.h>
#import "HYConstMacro.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+HYAdd.h"

static char documentControllerKey;

@implementation UIViewController (HYFilePreview)


#pragma mark - 关联属性
//getter
- (UIDocumentInteractionController *)documentCtr
{
    UIDocumentInteractionController *dCtr = objc_getAssociatedObject(self, &documentControllerKey);
    if (dCtr == nil) {
        dCtr = [[UIDocumentInteractionController alloc]init];
        self.documentCtr = dCtr;
    }
    return dCtr;
}

- (void)setDocumentCtr:(UIDocumentInteractionController *)documentCtr
{
    objc_setAssociatedObject(self, &documentControllerKey, documentCtr, OBJC_ASSOCIATION_RETAIN);
}

/**
 * 预览/分享文件
 * @param url 文件地址(本地地址)
 * @param isShare 是否是分享
 */
- (void)previewFile:(NSURL *)url share:(BOOL)isShare
{
        
    self.documentCtr.URL = url;
    
    // Configure Document Interaction Controller
    self.documentCtr.delegate = self;
    
    // loading
    WAITING

    //有选择view（直接打开和选择view选择其一写）
    if (isShare) {
        // 分享
        [self.documentCtr presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }else{
        // 开启预览
        [self.documentCtr presentPreviewAnimated:YES];
    }
}

/**
 * 分享文件
 */
- (void)shareFileWithUrl:(NSURL *)url
{
    [self previewFile:url share:YES];
}

/**
 * 预览文件
 */
- (void)previewFileWithUrl:(NSURL *)url
{
    [self previewFile:url share:NO];
}

#pragma mark - UIDocumentInteractionControllerDelegate
//实现代理，继承<UIDocumentInteractionControllerDelegate>
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

// Preview presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller{
    // loading消失
    DISMISS
    controller.name = @"附件预览";
    NSLog(@"willBeginPreview");
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller{
    // loading消失
    DISMISS
    NSLog(@"didEndPreview");
//    [self.navigationController popViewControllerAnimated:YES];
}

// Options menu presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillPresentOptionsMenu:(UIDocumentInteractionController *)controller{
    // loading消失
    DISMISS
    NSLog(@"willPresentOptionsMenu");
}

- (void)documentInteractionControllerDidDismissOptionsMenu:(UIDocumentInteractionController *)controller{
    // loading消失
    DISMISS
    NSLog(@"didDismissOptionsMenu");
}

// Open in menu presented/dismissed on document.  Use to set up any HI underneath.
- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller{
    // loading消失
    DISMISS
    NSLog(@"willPresentOpenInMenu");
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller{
    // loading消失
    DISMISS
    NSLog(@"didDismissOpenInMenu");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
