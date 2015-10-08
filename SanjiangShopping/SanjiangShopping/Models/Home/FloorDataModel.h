//
//  FloorDataModel.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

@interface FloorDataModel : NSObject

@property (copy, nonatomic) NSString *floorDataID;
@property (assign, nonatomic) NSInteger jt;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *po; // 原价
@property (copy, nonatomic) NSString *pn; // 当前价格

@end
