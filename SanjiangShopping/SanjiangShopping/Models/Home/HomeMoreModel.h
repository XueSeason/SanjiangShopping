//
//  HomeMoreModel.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/27.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "BaseModel.h"

typedef void (^SuccessHomeMoreBlock)();
typedef void (^FailureHomeMoreBlock)(NSError *error);

@interface ListItemModel : NSObject
@property (copy, nonatomic) NSString *itemID;
@property (assign, nonatomic) NSInteger jt;
@property (copy, nonatomic) NSString *img;
@property (strong, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *pn;
@property (copy, nonatomic) NSString *po;
@end

@interface HomeMoreDataModel : NSObject
@property (copy, nonatomic) NSArray *list;
@end

@interface HomeMoreModel : BaseModel

@property (strong, nonatomic) HomeMoreDataModel *data;

- (void)loadHomeMoreSuccess:(SuccessHomeMoreBlock)success Failure:(FailureHomeMoreBlock)failure;

@end
