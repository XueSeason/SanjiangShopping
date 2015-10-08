//
//  HomeModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HomeModel.h"

@implementation FloorModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [FloorModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"data": [FloorDataModel class]
                     };
        }];
    }
    return self;
}

@end

@implementation SubjectModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [SubjectModel setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"subjectID": @"id"
                     };
        }];
    }
    return self;
}

@end

@implementation HomeDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [HomeDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"head": [HeadModel class],
                     @"group": [NSString class],
                     @"subject": [SubjectModel class],
                     @"floors": [FloorModel class]
                     };
        }];
    }
    return self;
}

@end

@implementation HomeModel

@end
