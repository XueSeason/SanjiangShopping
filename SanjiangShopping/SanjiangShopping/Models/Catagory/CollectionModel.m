//
//  CollectionModel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "CollectionModel.h"

#import <MJExtension.h>

#import "XSAPIManager.h"
#import "NetworkConstant.h"

@implementation CollectionItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [CollectionItemModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
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
        [CollectionListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"items": [CollectionItemModel class]
                     };
        }];
        
        [CollectionListModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
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
        [CollectionDataModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [CollectionListModel class]
                     };
        }];
    }
    return self;
}
@end

@implementation CollectionModel
- (void)loadCollectionWithMenuID:(NSString *)menuID Success:(SuccessCollectionBlock)success Failure:(FailureCollectionBlock)failure {
    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CATAGORY_COLLECTION, menuID];
    
    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:URLString parameters:nil success:^(id responseObject) {
        CollectionModel *model = [CollectionModel mj_objectWithKeyValues:responseObject];
        weakSelf.data        = model.data;
        weakSelf.code        = model.code;
        weakSelf.codeMessage = model.codeMessage;
        
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
