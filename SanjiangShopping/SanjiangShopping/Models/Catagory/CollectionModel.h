//
//  CollectionModel.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "BaseModel.h"

typedef void (^SuccessCollectionBlock)();
typedef void (^FailureCollectionBlock)(NSError *error);

@interface CollectionItemModel : NSObject
@property (copy, nonatomic) NSString *itemID;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *itemName;
@end

@interface CollectionListModel : NSObject
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSArray *items;
@end

@interface CollectionDataModel : NSObject
@property (copy, nonatomic) NSString *headAD;
@property (copy, nonatomic) NSArray *list;
@end

@interface CollectionModel : BaseModel
@property (strong, nonatomic) CollectionDataModel *data;

- (void)loadCollectionWithMenuID:(NSString *)menuID Success:(SuccessCollectionBlock)success Failure:(FailureCollectionBlock)failure;

@end
