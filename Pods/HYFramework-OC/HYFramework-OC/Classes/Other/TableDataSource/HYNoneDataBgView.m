//
//  HYNoneDataBgView.m
//  HYFramework-OC
//
//  Created by 臻尚 on 2021/5/21.
//

#import "HYNoneDataBgView.h"

@implementation HYNoneDataBgView

+ (instancetype)view
{
    HYNoneDataBgView *v = [super view];
    v.frame = CGRectMake(0, 0, HYSCREEN_Width, HYSCREEN_Height);
    return v;
}

// 添加子视图
- (void)setupSubViews
{
    [super setupSubViews];
    
    // 图片
    UIImage *image = [self imageWithName:@"emptyTable"];
    UIImageView *emptyImageV = [[UIImageView alloc]initWithImage:image];
    [self addSubview:emptyImageV];
    [emptyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.mas_equalTo(40);
    }];
}

// 获取图片资源
- (UIImage *)imageWithName:(NSString *)imageName
{
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/HYFrameworl-OC.bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    return [UIImage imageNamed:imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
}

@end
