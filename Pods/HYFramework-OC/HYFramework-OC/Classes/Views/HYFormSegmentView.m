//
//  ZhenFormSegmentView.m
//  findme
//
//  Created by 臻尚 on 2021/2/24.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYFormSegmentView.h"
#import "HYImageView.h"
#import "Masonry.h"
#import "HYConstMacro.h"
#import "NSString+HYFrame.h"
#import "UIView+HYSubview.h"

@interface HYFormSegmentView ()

// 标题
@property (nonatomic, strong) UILabel *tLabel;

// 输入框背景
@property (nonatomic, weak) UIView *inputBgView;

// 输入框
@property (nonatomic, weak) UITextField *inputTf;
// 选择内容按钮
@property (nonatomic, weak) UIButton *selectContentBtn;

// 多行输入框
@property (nonatomic, weak) HYTextView *inputTV;

// 图片显示背景
@property (nonatomic, weak) UIView *imageBgView;
// 添加图片按钮
@property (nonatomic, weak) UIButton *uploadBtn;
// 选择图片类型时  一行最多显示图片个数
@property (nonatomic, assign) int maxColumCount;
// 如果是选择图片类型 图片的宽/高
@property (nonatomic, assign) CGFloat imageW;

@end

@implementation HYFormSegmentView

#pragma mark - 初始化
- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [superView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
        }];
        
        self.maxColumCount = 3;
        // 如果是选择图片类型 计算图片的宽高
        CGFloat scWidth = [UIScreen mainScreen].bounds.size.width;
        self.imageW = (scWidth - 30 - 20)/(self.maxColumCount * 1.0);
    }
    return self;
}

#pragma mark - setter
// 根据model 创建不同的view块
- (void)setModel:(HYFormInfoModel *)model
{
    _model = model;
    
    // 标题
    self.tLabel.text = self.model.titleText;
    [self setupTitleView];
    
    // 输入框/选择内容
    [self setupInputViews];
    
    // 选择图片
    [self setupImageView];
}

// 设置是否可编辑
- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    
    self.inputTf.userInteractionEnabled = self.inputTV.userInteractionEnabled = canEdit;
    self.uploadBtn.hidden = self.selectContentBtn.hidden = !canEdit;
}

#pragma mark - 设置view
// 标题
- (void)setupTitleView
{
    // 不显示标题 什么也不做
    if (!self.model.isShowTitle) return;
    
    // 标题位置
    if (self.model.titlePosition == TitlePositionTop) {
        [self addSubview:self.tLabel];
        [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).mas_offset(10);
            make.left.equalTo(self).mas_offset(15);
            make.right.equalTo(self).mas_offset(-15);
            make.height.mas_equalTo(20);
        }];
    }
}

// 输入框/选择内容
- (void)setupInputViews
{
    if (self.model.segmentType == segmentTypeInputSingle || self.model.segmentType == segmentTypeInputMulti || self.model.segmentType == segmentTypeSelectContent) {
        // 类型 单行输入0 多行输入1 选择内容2
        CGFloat bgH = 40;
        if (self.model.segmentType == segmentTypeInputMulti) {
            bgH = 80;
        }
        
        // 输入框背景
        UIView *inputBgView = UIView.new;
        inputBgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:inputBgView];
        self.inputBgView = inputBgView;
        [inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).mas_offset(15);
            make.right.equalTo(self).mas_offset(-15);
            if (!self.model.showTitle || self.model.titlePosition == TitlePositionInnerLeft) {
                // 不显示标题
                make.top.equalTo(self).mas_offset(10);
            }else {
                // 显示标题
                make.top.equalTo(self.tLabel.mas_bottom).mas_offset(10);
            }
            make.height.mas_equalTo(bgH);
            make.bottom.equalTo(self);
        }];
        inputBgView.layer.cornerRadius = 8;
        inputBgView.layer.masksToBounds = YES;
        
        // 标题在输入框背景内
        BOOL titleInner = NO;
        if (self.model.showTitle && self.model.titlePosition == TitlePositionInnerLeft) {
            titleInner = YES;
            
            // 计算标题文本宽度
            [self.inputBgView addSubview:self.tLabel];
            CGFloat titleW = [self.model.titleText widthWithFont:self.tLabel.font];
            [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.inputBgView);
                make.left.equalTo(self.inputBgView).mas_offset(8);
                make.width.mas_equalTo(titleW);
            }];
        }
        
        // 输入框
        if(self.model.segmentType == segmentTypeInputSingle || self.model.segmentType == segmentTypeSelectContent){
            
            if (titleInner) {
                [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.inputBgView);
                }];
            }
            // 单行输入框
            UITextField *tf = UITextField.new;
            tf.font = [UIFont systemFontOfSize:14];
            tf.textColor = [UIColor blackColor];
            tf.placeholder = self.model.placeholdText;
            tf.clearButtonMode = UITextFieldViewModeWhileEditing;
            [inputBgView addSubview:tf];
            self.inputTf = tf;
            [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                if (titleInner) {
                    make.left.equalTo(self.tLabel.mas_right).mas_offset(5);
                }else {
                    make.left.mas_equalTo(10);
                }
                
                if (self.model.segmentType == segmentTypeInputSingle) {
                    make.right.mas_equalTo(-10);
                }else {
                    make.right.mas_equalTo(-30);
                }
                
                make.top.bottom.equalTo(inputBgView);
            }];
            
            // 选择内容按钮
            if (self.model.segmentType == segmentTypeSelectContent) {
                UIButton *selBtn = UIButton.new;
                [selBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
                [self.inputBgView addSubview:selBtn];
                self.selectContentBtn = selBtn;
                [selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(inputBgView);
                }];
                // 图片
                UIImageView *imageV = [[UIImageView alloc]initWithImage:HYImageNamed(@"返 回 副本 3")];
                [selBtn addSubview:imageV];
                [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(8.2);
                    make.height.mas_equalTo(15);
                    make.right.mas_equalTo(-8);
                    make.centerY.equalTo(selBtn);
                }];
            }
        }else if (self.model.segmentType == segmentTypeInputMulti) {
            // 多行输入框
            HYTextView *tv = HYTextView.new;
            tv.font = HYFontSystem(14);
            tv.textColor = [UIColor blackColor];
            tv.placeholder = self.model.placeholdText;
            [inputBgView addSubview:tv];
            self.inputTV = tv;
            [tv mas_makeConstraints:^(MASConstraintMaker *make) {
                if (titleInner) {
                    make.left.equalTo(self.tLabel.mas_right).mas_offset(5);
                }else {
                    make.left.mas_equalTo(10);
                }
                make.right.mas_equalTo(-10);
                make.top.bottom.equalTo(inputBgView);
            }];
        }else {
            
        }
        
        
    }
}

// 选择图片
- (void)setupImageView
{
    if (self.model.segmentType == segmentTypeSelectImage) {
        // 背景
        UIView *imageBgView = UIView.new;
        imageBgView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageBgView];
        self.imageBgView = imageBgView;
        [imageBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            if (self.tLabel) {
                make.top.equalTo(self.tLabel.mas_bottom).mas_offset(10);
            }else {
                make.top.equalTo(self).mas_offset(10);
            }
            make.bottom.equalTo(self);
        }];
        
        // 添加图片按钮
        UIButton *uploadBtn = UIButton.new;
        uploadBtn.layer.cornerRadius = 8;
        uploadBtn.layer.masksToBounds = YES;
        [uploadBtn setImage:HYImageNamed(@"icon_place_holder") forState:UIControlStateNormal];
        [uploadBtn addTarget:self action:@selector(chooseImageAction) forControlEvents:UIControlEventTouchUpInside];
        
        [imageBgView addSubview:uploadBtn];
        self.uploadBtn = uploadBtn;
        [uploadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(imageBgView);
            make.width.height.mas_equalTo(self.imageW);
            make.bottom.equalTo(imageBgView).mas_offset(-10);
        }];
    }
}

// 刷新图片/视频列表
- (void)reloadImageOrVideoViews:(NSArray <HYImageVideoModel *>*)data
{
    // 移除旧的图片
    [self.imageBgView removeSubviewsWithClass:[UIImageView class]];
    
    // 添加新的图片
    for (HYImageVideoModel *model in data) {
        [self addImageOrVideo:model];
    }
    
    // 如果没有图片
    if (data.count == 0) {
        [self.uploadBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.equalTo(self.imageBgView);
            make.width.height.mas_equalTo(self.imageW);
            make.bottom.equalTo(self.imageBgView).mas_offset(-10);
        }];
    }
}

// 添加一个图片/视频
- (void)addImageOrVideo:(HYImageVideoModel *)model
{
    // 获取最后添加的一个imageView
    NSArray *imageViews = [self.imageBgView subviewsWithClass:[HYImageView class]];
    HYImageView *lastImageV = imageViews.lastObject;
    
    // 添加新的图片
    HYImageView *imageV = [[HYImageView alloc]init];
    if (model.image) {
        imageV.image = model.image;
    }else if (model.isVideo) {
        // 视频
//        [UIImage getVideoImageAsynWithUrl:KSeverImageUrl(model.imageOrVideoUrl) complete:^(UIImage * _Nonnull img) {
//            if (img) {
//                imageV.image = img;
//            }else {
//                imageV.image = ImageNamed(@"placeholder");
//            }
//        }];
    }else{
        // 图片
//        [imageV sd_setImageWithURL:KSeverImageUrl(model.imageOrVideoUrl) placeholderImage:ImageNamed(@"placeholder")];
    }
    
    imageV.layer.cornerRadius = 8;
    imageV.layer.masksToBounds = YES;
    imageV.data = model;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickAction:)]];
    [self.imageBgView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        if (lastImageV == nil) {
            // 添加的是第一个imageView
            make.left.mas_equalTo(15);
            make.top.equalTo(self.imageBgView);
        }else {
            // 添加的不是第一个imageView
            if (CGRectGetMaxX(lastImageV.frame) + self.imageW > HYSCREEN_Width) {
                // 是最右边一个
                make.left.mas_equalTo(15);
                make.top.equalTo(lastImageV.mas_bottom).mas_offset(10);
            }else {
                make.left.equalTo(lastImageV.mas_right).mas_offset(10);
                make.top.equalTo(lastImageV);
            }
        }
        make.width.height.mas_equalTo(self.imageW);
    }];
    
    // 删除图片
    if (self.canEdit) {
        UIButton *delImgBtn = UIButton.new;
        [delImgBtn setImage:HYImageNamed(@"关 闭(2)") forState:UIControlStateNormal];
        [delImgBtn addTarget:self action:@selector(delImage:) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:delImgBtn];
        [delImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageV).mas_offset(5);
            make.right.equalTo(imageV).mas_offset(-5);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
    }
    
    
    // 如果是视频 添加播放图片
    if (model.isVideo) {
        UIButton *playBtn = [[UIButton alloc]init];
        playBtn.userInteractionEnabled = NO;
        playBtn.contentMode = UIViewContentModeCenter;
        playBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
        [playBtn setImage:HYImageNamed(@"play1") forState:UIControlStateNormal];
        playBtn.backgroundColor = HYColorRGBA(1, 1, 1, 0.5);
        playBtn.layer.cornerRadius = 20;
        playBtn.layer.masksToBounds = YES;
        [imageV addSubview:playBtn];
        [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.center.equalTo(imageV);
        }];
    }
    
    // 更新uploadBtn约束
    [self.imageBgView layoutIfNeeded];
    [self.uploadBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (!self.canEdit) {
            make.edges.equalTo(imageV);
        }else {
            if (CGRectGetMaxX(imageV.frame) + self.imageW > HYSCREEN_Width) {
                make.left.mas_equalTo(15);
                make.top.equalTo(imageV.mas_bottom).mas_offset(10);
            }else {
                make.left.equalTo(imageV.mas_right).mas_offset(10);
                make.top.equalTo(imageV);
            }
            make.width.height.mas_equalTo(self.imageW);
        }
        make.bottom.equalTo(self.imageBgView).mas_offset(-10);
    }];
}


#pragma mark - 事件
// 选择按钮点击
- (void)selectBtnAction
{
    if (self.selectBtnClickBlock) {
        self.selectBtnClickBlock();
    }
}

// 选择图片上传
- (void)chooseImageAction
{
    if (self.chooseImageBlock) {
        self.chooseImageBlock();
    }
}

// 删除图片/视频
- (void)delImage:(UIButton *)btn
{
    // 获取当前model
    HYImageView *imageV = (HYImageView *)btn.superview;
    HYImageVideoModel *model = (HYImageVideoModel *)imageV.data;
    
    if (self.delBtnClickBlock) {
        self.delBtnClickBlock(self,model);
    }
}

// 点击图片事件
- (void)imageClickAction:(UIGestureRecognizer *)gesture
{
    HYImageView *imgV = (HYImageView *)gesture.view;
    if (self.imageClickBlock) {
        self.imageClickBlock(imgV.data);
    }
}

#pragma mark - 懒加载
// 标题
- (UILabel *)tLabel
{
    if (!_tLabel) {
        _tLabel = UILabel.new;
        _tLabel.font = HYFontSystem(15);
        _tLabel.textColor = HYColorLightGray;
    }
    return _tLabel;
}

@end
