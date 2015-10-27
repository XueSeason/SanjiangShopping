//
//  XSMyFavoriteTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyFavoriteTableViewCell.h"

@implementation XSMyFavoriteTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:_priceOldLabel.text];
    [attribute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, _priceOldLabel.text.length)];
    [_priceOldLabel setAttributedText:attribute];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
