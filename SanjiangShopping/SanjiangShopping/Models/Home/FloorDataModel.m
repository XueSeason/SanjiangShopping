//
//  FloorDataModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "FloorDataModel.h"

@implementation FloorDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [FloorDataModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"floorDataID": @"id"
                     };
        }];
    }
    return self;
}

@end
