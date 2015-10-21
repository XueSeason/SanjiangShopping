//
//  XSMyCouponTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyCouponTableViewCell.h"

@implementation XSMyCouponTableViewCell

- (void)awakeFromNib {
    
    self.typeLabel.layer.cornerRadius = 10.5f;
    self.typeLabel.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
