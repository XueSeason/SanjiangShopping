//
//  MenuModel.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "BaseModel.h"

typedef void (^SuccessMenuBlock)();
typedef void (^FailureMenuBlock)(NSError *error);


@interface MenuItemModel : NSObject
@property (copy, nonatomic) NSString *ItemID;
@property (copy, nonatomic) NSString *ItemName;
@end

@interface MenuDataModel : NSObject
@property (copy, nonatomic) NSArray *list;
@end

@interface MenuModel : BaseModel
@property (strong, nonatomic) MenuDataModel *data;
- (void)loadMenuSuccess:(SuccessMenuBlock)success Failure:(FailureMenuBlock)failure;
@end
