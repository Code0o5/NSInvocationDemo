//
//  NSString+HYPath.h
//  HYFramework
//
//  Created by 臻尚 on 2021/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HYPath)

// 从路径中获得完整的文件名 （带后缀）
- (NSString *)fileNameWithExtension;

//获得文件名 （不带后缀）
- (NSString *)fileNameWithoutExtension;

// 获得文件的后缀名 （不带'.'）
- (NSString *)fileExtension;

@end

NS_ASSUME_NONNULL_END
