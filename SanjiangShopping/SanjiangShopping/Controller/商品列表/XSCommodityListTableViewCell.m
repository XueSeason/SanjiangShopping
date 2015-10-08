//
//  XSCommodityListTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/17.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityListTableViewCell.h"
#import "ThemeColor.h"

@implementation XSCommodityListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _picture.layer.borderWidth = 0.5f;
    _picture.layer.borderColor = [BACKGROUND_COLOR CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
