//
//  MenuModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "MenuModel.h"

#import <MJExtension.h>

@implementation MenuItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [MenuItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"ItemID": @"id",
                     @"ItemName": @"item"
                     };
        }];
    }
    return self;
}
@end

@implementation MenuDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [MenuDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [MenuItemModel class]
                     };
        }];
    }
    return self;
}

@end

@implementation MenuModel

@end
