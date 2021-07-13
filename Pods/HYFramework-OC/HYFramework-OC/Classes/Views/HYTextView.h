//
//  HYTextView.h
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYTextView : UITextView

// 占位文字
@property (nonatomic, copy) NSString *placeholder;
// 占位文字颜色
@property (nonatomic, strong) UIColor *placeholderColor;

@end

NS_ASSUME_NONNULL_END
