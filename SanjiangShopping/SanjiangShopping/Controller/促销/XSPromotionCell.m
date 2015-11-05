//
//  XSPromotionCell.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSPromotionCell.h"
#import "PromotionModel.h"

#import <UIImageView+WebCache.h>

@implementation XSPromotionCell

- (void)awakeFromNib {
    // Initialization code
    self.picture.contentMode = UIViewContentModeScaleAspectFill;
    
    self.picture.layer.cornerRadius = 10;
    self.picture.clipsToBounds      = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)configureForPromotion:(PromotionItemModel *)promotion {
    [self.picture sd_setImageWithURL:[NSURL URLWithString:promotion.img]];
}

@end
