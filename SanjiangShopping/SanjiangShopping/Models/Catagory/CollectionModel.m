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
- (void)loadMenuSuccess:(SuccessCollectionBlock)success Failure:(FailureCollectionBlock)failure {
//    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CATAGORY_COLLECTION, menuID];
//    
//    __weak typeof(self) weakSelf = self;
//    XSAPIManager *manager = [XSAPIManager manager];
//    [manager GET:URLString parameters:nil success:^(id responseObject) {
//        weakSelf.collection = [CollectionModel objectWithKeyValues:responseObject];
//        weakSelf.mutiCatagoryCollectionViewDataSource.data = weakSelf.collection.data;
//        [weakSelf.collectionView reloadData];
//    } failure:nil];
//    
//    
//    
//    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CATAGORY_MENU];
//    
//    __weak typeof(self) weakSelf = self;
//    XSAPIManager *manager = [XSAPIManager manager];
//    [manager GET:URLString parameters:nil success:^(id responseObject) {
//        
//        MenuModel *model = [MenuModel objectWithKeyValues:responseObject];
//        weakSelf.data         = model.data;
//        weakSelf.code         = model.code;
//        weakSelf.codeMessage  = model.codeMessage;
//        
//        success();
//        
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
}
@end
