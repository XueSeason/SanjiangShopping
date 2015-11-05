//
//  XSPromotionCell.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PromotionItemModel;

@interface XSPromotionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;

- (void)configureForPromotionItem:(PromotionItemModel *)promotionItem;

@end
