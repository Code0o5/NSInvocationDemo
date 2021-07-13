//
//  HYTextView.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "HYTextView.h"
#import "Masonry.h"
#import "HYConstMacro.h"
#import "NSString+HYAdd.h"

@interface HYTextView ()

// 显示占位文本
@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation HYTextView

#pragma mark - 生命周期
// 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认占位文本颜色
        self.placeholderColor = [UIColor colorWithRed:206/255.0 green:206/255.0 blue:211/255.0 alpha:1];
        
        // 添加文本变化通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextViewTextDidChangeNotification object:nil];
        
        // 添加占位文本框
        [self addSubview:self.placeHolderLabel];
        [self sendSubviewToBack:self.placeHolderLabel];
        [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(8);
            make.left.equalTo(self);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}


// 释放，移除通知
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - setter
// 设置占位文字
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeHolderLabel.text = placeholder;
    self.placeHolderLabel.hidden = !HYStringEmpty(self.text);
}

// 设置占位文字颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeHolderLabel.textColor = placeholderColor;
}

// 设置字体
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    // 占位文字大小和textView文本大小一致
    self.placeHolderLabel.font = font;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textChanged];
}

#pragma mark - 事件
// 文本改变，显示或隐藏占位文本
- (void)textChanged
{
    self.placeHolderLabel.hidden = !HYStringEmpty(self.text);
}

#pragma mark - 懒加载
// 占位文本显示框
- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        _placeHolderLabel = UILabel.new;
        _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _placeHolderLabel.numberOfLines = 0;
        // 默认文本字体大小
        _placeHolderLabel.font = [UIFont systemFontOfSize:15];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.hidden = YES;
    }
    
    return _placeHolderLabel;
}

@end
