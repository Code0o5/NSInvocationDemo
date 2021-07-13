//
//  ZhenImageView.m
//  findme
//
//  Created by 臻尚 on 2021/3/3.
//  Copyright © 2021 Zhen. All rights reserved.
//

#import "HYImageView.h"

@implementation HYImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end
