//
//  BaseModel.m
//  FindmiWorkers
//
//  Created by 臻尚 on 2020/12/3.
//

#import "HYBaseModel.h"

@implementation HYBaseModel

// 快速创建model
+ (instancetype)model
{
    id model = [[self alloc]init];
    return model;
}

// model嵌套，内部model类型指定
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"hyList" : [HYBaseModel class]};
}

// 自定义属性名称
//+ (NSDictionary *)modelCustomPropertyMapper
//{
//    return @{@"ID":@"id"};
//}



@end
