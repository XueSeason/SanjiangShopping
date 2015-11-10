//
//  HomeMoreModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/27.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HomeMoreModel.h"
#import <MJExtension.h>

#import "XSAPIManager.h"
#import "NetworkConstant.h"

@implementation ListItemModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [ListItemModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
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
        [HomeMoreDataModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [ListItemModel class]
                     };
        }];
    }
    return self;
}

@end

@implementation HomeMoreModel

- (void)loadHomeMoreSuccess:(SuccessHomeMoreBlock)success Failure:(FailureHomeMoreBlock)failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_HOME_MORE];
    
    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:urlStr parameters:nil success:^(id responseObject) {
        HomeMoreModel *model = [HomeMoreModel mj_objectWithKeyValues:responseObject];
        weakSelf.data         = model.data;
        weakSelf.code         = model.code;
        weakSelf.codeMessage  = model.codeMessage;
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
