//
//  HotWordsModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HotWordsModel.h"
#import <MJExtension.h>

#import "NetworkConstant.h"
#import "XSAPIManager.h"

@implementation HotWordsDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [HotWordsDataModel setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"list": [NSString class]
                     };
        }];
    }
    return self;
}

@end

@implementation HotWordsModel

- (void)loadHotWordsSuccess:(SuccessHotWordsBlock)success Failure:(FailureHotWordsBlock)failure {

    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_SEARCH_HOTWORDS];
    
    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:URLString parameters:nil success:^(id responseObject) {
        
        HotWordsModel *model = [HotWordsModel objectWithKeyValues:responseObject];
        weakSelf.data         = model.data;
        weakSelf.code         = model.code;
        weakSelf.codeMessage  = model.codeMessage;
        
        success();
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
