//
//  PromotionModel.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "BaseModel.h"

typedef void (^SuccessPromotionBlock)();
typedef void (^FailurePromotionBlock)(NSError *error);

@interface PromotionItemModel : NSObject
@property (copy, nonatomic) NSString *itemID;
@property (assign, nonatomic) NSInteger jt;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *subtitle;
@property (copy, nonatomic) NSString *pn;
@property (copy, nonatomic) NSString *po;

@end

@interface PromotionDataModel : NSObject
@property (copy, nonatomic) NSArray *list;
@end

@interface PromotionModel : BaseModel
@property (strong, nonatomic) PromotionDataModel *data;

- (void)loadPromotionSuccess:(SuccessPromotionBlock)success Failure:(FailurePromotionBlock)failure;
@end
