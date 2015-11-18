//
//  XSCommodityMoreTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityMoreTableViewCell.h"
#import "ThemeColor.h"
@implementation XSCommodityMoreTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = BACKGROUND_COLOR;
    self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
