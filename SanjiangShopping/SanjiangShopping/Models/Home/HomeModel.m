//
//  HomeModel.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HomeModel.h"

#import <MJExtension.h>

#import "NetworkConstant.h"
#import "XSAPIManager.h"

@implementation FloorModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [FloorModel mj_setupObjectClassInArray:^NSDictionary *{
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
        [SubjectModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
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
        [HomeDataModel mj_setupObjectClassInArray:^NSDictionary *{
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

- (void)loadHomeSuccess:(SuccessHomeBlock)success Failure:(FailureHomeBlock)failure {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_HOME];
    
    __weak typeof(self) weakSelf = self;
    XSAPIManager *manager = [XSAPIManager manager];
    [manager GET:urlStr parameters:nil success:^(id responseObject) {
        HomeModel *model = [HomeModel mj_objectWithKeyValues:responseObject];
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
