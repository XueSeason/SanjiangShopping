//
//  MenuModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "MenuModel.h"
#import "NetworkConstant.h"
#import "XSAPIManager.h"

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

- (void)loadMenuSuccess:(SuccessMenuBlock)success Failure:(FailureMenuBlock)failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CATAGORY_MENU];
    
    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:URLString parameters:nil success:^(id responseObject) {
        
        MenuModel *model = [MenuModel objectWithKeyValues:responseObject];
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
