//
//  CartModel.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/8.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "BaseModel.h"

@interface CartItemModel : NSObject
@property (copy, nonatomic) NSString  *itemID;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger selected;
@property (copy, nonatomic) NSString  *img;
@property (copy, nonatomic) NSString  *name;
@property (copy, nonatomic) NSString  *subtitle;
@property (copy, nonatomic) NSString  *pn;
@property (copy, nonatomic) NSString  *po;
@end

@interface CartDataModel : NSObject
@property (copy, nonatomic) NSArray *list;
@end

@interface CartModel : BaseModel
@property (strong, nonatomic) CartDataModel *data;
@end
