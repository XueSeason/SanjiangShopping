//
//  CartModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/8.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "CartModel.h"

#import <MJExtension.h>

@implementation CartItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CartItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"itemID": @"id"
                     };
        }];
    }
    return self;
}
@end

@implementation CartDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CartDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [CartItemModel class]
                     };
        }];
    }
    return self;
}
@end

@implementation CartModel

@end
