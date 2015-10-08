//
//  XSCommodityListModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/17.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "CommodityListModel.h"
#import <MJExtension.h>

@implementation CommodityListItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CommodityListItemModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"itemID": @"id"
                     };
        }];
    }
    return self;
}
@end

@implementation CommodityListDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CommodityListDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [CommodityListItemModel class]
                     };
        }];
    }
    return self;
}
@end


@implementation CommodityListModel

@end
