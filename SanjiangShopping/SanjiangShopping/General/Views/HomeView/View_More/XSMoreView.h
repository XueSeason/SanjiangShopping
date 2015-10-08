//
//  XSMoreView.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/28.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSHomeViewController;
@class ListItemModel;

@interface XSMoreView : UIView
@property (strong, nonatomic) ListItemModel *item;

@property (strong, nonatomic) UIButton  *shoppingCart;
@property (strong, nonatomic) UIControl *mainControl;

@end
