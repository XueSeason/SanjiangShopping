//
//  XSMyFavoriteTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyFavoriteTableViewCell.h"

#import "UIImage+Filter.h"
#import <UIImageView+WebCache.h>

@implementation XSMyFavoriteTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:_priceOldLabel.text];
    [attribute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, _priceOldLabel.text.length)];
    [_priceOldLabel setAttributedText:attribute];
    
    self.shoppingCartButton.layer.cornerRadius = self.shoppingCartButton.frame.size.width / 2.0;
    self.shoppingCartButton.clipsToBounds = YES;
    
    self.labelButton.layer.cornerRadius = 3;
    self.labelButton.clipsToBounds = YES;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:@"http://img4.douban.com/mpic/s28265867.jpg"]];
    
    self.invalidLabel.hidden = YES;
    self.invalidLabel.backgroundColor = [UIColor colorWithHue:0.0 saturation:0.0 brightness:0.0 alpha:0.3];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)invalid {
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.priceNowLabel.textColor = [UIColor lightGrayColor];
    self.priceOldLabel.textColor = [UIColor lightGrayColor];
    self.dateLabel.textColor = [UIColor lightGrayColor];
    
    [self.shoppingCartButton setImage:[UIImage getGrayImage:[UIImage imageNamed:@"ShoppingCart"]] forState:UIControlStateNormal];
    self.img.image = [UIImage getGrayImage:self.img.image];
    
    self.invalidLabel.hidden = NO;
}

@end
