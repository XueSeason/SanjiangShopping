//
//  HeadModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HeadModel.h"

@implementation HeadModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [HeadModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"headID": @"id"
                     };
        }];
    }
    return self;
}

@end
