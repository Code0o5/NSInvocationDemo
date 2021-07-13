//
//  NSString+HYPath.m
//  HYFramework
//
//  Created by 臻尚 on 2021/4/13.
//

#import "NSString+HYPath.h"

@implementation NSString (HYPath)


// 从路径中获得完整的文件名 （带后缀）
- (NSString *)fileNameWithExtension
{
    NSString *fileName = [self lastPathComponent];
    return fileName;
}

//获得文件名 （不带后缀）
- (NSString *)fileNameWithoutExtension
{
    NSString *fileName = [self stringByDeletingPathExtension];
    return fileName;
}


// 获得文件的后缀名 （不带'.'）
- (NSString *)fileExtension
{
    NSString *suffix = [self pathExtension];
    return suffix;
}

   

   

   
@end
