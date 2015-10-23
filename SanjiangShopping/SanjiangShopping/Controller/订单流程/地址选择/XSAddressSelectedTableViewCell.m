//
//  XSAddressSelectedTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/9.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSAddressSelectedTableViewCell.h"

@implementation XSAddressSelectedTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 去除section边框
-(void)addSubview:(UIView *)view
{
    // The separator has a height of 0.5pt on a retina display and 1pt on non-retina.
    // Prevent subviews with this height from being added.
    if (CGRectGetHeight(view.frame)*[UIScreen mainScreen].scale == 1)
    {
        return;
    }
    
    [super addSubview:view];
}

@end
