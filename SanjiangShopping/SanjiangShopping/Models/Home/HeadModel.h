//
//  HeadModel.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension.h>

@interface HeadModel : NSObject

@property (copy, nonatomic)   NSString *headID;
@property (assign, nonatomic) NSInteger jt; // jump type 跳转类型
@property (copy, nonatomic)   NSString *img;

@end
