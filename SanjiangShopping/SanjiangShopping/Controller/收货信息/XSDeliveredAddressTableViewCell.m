//
//  XSDeliveredAddressTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/19.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSDeliveredAddressTableViewCell.h"

@implementation XSDeliveredAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHasSelected:(BOOL)hasSelected {
    _hasSelected = hasSelected;
    if (_hasSelected) {
        [self.selectButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        self.defaultAddressLabel.hidden = NO;
    } else {
        [self.selectButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        self.defaultAddressLabel.hidden = YES;
    }
}

@end
