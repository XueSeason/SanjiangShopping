//
//  HotWordsModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HotWordsModel.h"
#import <MJExtension.h>

@implementation HotWordsDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [HotWordsDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [NSString class]
                     };
        }];
    }
    return self;
}

@end

@implementation HotWordsModel

@end
