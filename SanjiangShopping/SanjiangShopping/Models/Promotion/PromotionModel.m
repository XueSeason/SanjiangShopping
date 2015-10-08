//
//  PromotionModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "PromotionModel.h"

#import <MJExtension.h>

@implementation PromotionItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [PromotionItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"itemID": @"id"
                     };
        }];
    }
    return self;
}

@end

@implementation PromotionDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [PromotionDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [PromotionItemModel class]
                     };
        }];
    }
    return self;
}

@end

@implementation PromotionModel

@end
