//
//  XSBuyNowTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/2/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSBuyNowTableViewCell.h"

@implementation XSBuyNowTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _buyNowButton.clipsToBounds = YES;
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:_priceOldLabel.text];
    [attribute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, _priceOldLabel.text.length)];
    [_priceOldLabel setAttributedText:attribute];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
