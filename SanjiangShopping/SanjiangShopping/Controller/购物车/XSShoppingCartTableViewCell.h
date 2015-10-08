//
//  XSShoppingCartTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/6.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CartItemModel;
@interface XSShoppingCartTableViewCell : UITableViewCell

@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic) CartItemModel *item;

@end
