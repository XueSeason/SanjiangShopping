//
//  CartModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/8.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "CartModel.h"
#import "NetworkConstant.h"
#import "XSAPIManager.h"

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
- (void)loadCartSuccess:(SuccessCartBlock)success Failure:(FailureCartBlock)failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CART_LIST];
    
    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:urlStr parameters:nil success:^(id responseObject) {
        CartModel *model = [CartModel objectWithKeyValues:responseObject];
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
