//
//  HomeModel.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "BaseModel.h"

#import "HeadModel.h"
#import "FloorDataModel.h"

#import <MJExtension.h>

@interface FloorModel : NSObject

@property (assign, nonatomic) NSInteger vt;    // 视图类型
@property (assign, nonatomic) NSInteger more;
@property (copy, nonatomic)   NSString  *flag;
@property (copy, nonatomic)   NSString  *title;
@property (copy, nonatomic)   NSArray   *data;  // 存储数据 FloorDataModel 类型

@end

@interface SubjectModel : NSObject
@property (copy, nonatomic) NSString *subjectID;
@property (assign, nonatomic) NSInteger jt;
@property (copy, nonatomic) NSString *img;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *subtitle;
@end

@interface HomeDataModel : NSObject

@property (copy, nonatomic) NSString *keyword;
@property (copy, nonatomic) NSArray  *head;   // 存储数据 HeadModel    类型
@property (copy, nonatomic) NSArray  *group;  // 存储数据 NSString     类型
@property (copy, nonatomic) NSArray  *subject;// 存储数据 SubjectModel 类型
@property (copy, nonatomic) NSArray  *floors; // 存储数据 FloorModel   类型

@end


@interface HomeModel : BaseModel

@property (strong, nonatomic) HomeDataModel *data;

@end
