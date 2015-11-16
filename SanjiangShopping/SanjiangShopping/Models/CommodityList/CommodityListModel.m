//
//  XSCommodityListModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/17.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "CommodityListModel.h"
#import <MJExtension.h>

#import "XSAPIManager.h"
#import "NetworkConstant.h"

@implementation CommodityListItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CommodityListItemModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
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
        [CommodityListDataModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [CommodityListItemModel class]
                     };
        }];
    }
    return self;
}
@end


@implementation CommodityListModel
- (void)loadCommodityListWithQueryFormat:(NSString *)query Success:(SuccessCommodityListBlock)success Failure:(FailureCommodityListBlock)failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_COMMODITY_LIST, query];

    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:urlStr parameters:nil success:^(id responseObject) {
        CommodityListModel *model = [CommodityListModel mj_objectWithKeyValues:responseObject];
        weakSelf.data             = model.data;
        weakSelf.code             = model.code;
        weakSelf.codeMessage      = model.codeMessage;
        
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
