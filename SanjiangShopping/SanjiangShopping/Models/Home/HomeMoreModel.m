//
//  HomeMoreModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/27.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HomeMoreModel.h"
#import <MJExtension.h>

@implementation ListItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [ListItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"itemID": @"id"
                     };
        }];
    }
    return self;
}

@end

@implementation HomeMoreDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [HomeMoreDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [ListItemModel class]
                     };
        }];
    }
    return self;
}

@end

@implementation HomeMoreModel

@end
