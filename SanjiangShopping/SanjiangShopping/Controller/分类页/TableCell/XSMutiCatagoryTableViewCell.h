//
//  XSMutiCatagoryTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuItemModel;

@interface XSMutiCatagoryTableViewCell : UITableViewCell

@property (copy, nonatomic) NSString *menuID;
- (void)configureForMenuItem:(MenuItemModel *)item;

@end
