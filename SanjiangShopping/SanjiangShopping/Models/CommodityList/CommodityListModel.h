//
//  XSCommodityListModel.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/17.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "BaseModel.h"

typedef void (^SuccessCommodityListBlock)();
typedef void (^FailureCommodityListBlock)(NSError *error);

@interface CommodityListItemModel : NSObject
@property (copy, nonatomic) NSString *itemID;
@property (assign, nonatomic) NSInteger jt;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *rate;
@property (copy, nonatomic) NSString *pn;
@property (copy, nonatomic) NSString *po;
@end

@interface CommodityListDataModel : NSObject
@property (copy, nonatomic) NSArray *list;
@end

@interface CommodityListModel : BaseModel
@property (strong, nonatomic) CommodityListDataModel *data;
- (void)loadCommodityListWithQueryFormat:(NSString *)query Success:(SuccessCommodityListBlock)success Failure:(FailureCommodityListBlock)failure;
@end
