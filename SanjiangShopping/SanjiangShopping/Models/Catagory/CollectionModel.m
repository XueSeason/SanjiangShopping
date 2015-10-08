//
//  CollectionModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "CollectionModel.h"

#import <MJExtension.h>

@implementation CollectionItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CollectionItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"itemID": @"id",
                     @"itemName": @"item"
                     };
        }];
    }
    return self;
}
@end

@implementation CollectionListModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CollectionListModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"items": [CollectionItemModel class]
                     };
        }];
        
        [CollectionListModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"title": @"subtitle",
                     @"items": @"subs"
                     };
        }];
    }
    return self;
}
@end

@implementation CollectionDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CollectionDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [CollectionListModel class]
                     };
        }];
    }
    return self;
}
@end

@implementation CollectionModel

@end
