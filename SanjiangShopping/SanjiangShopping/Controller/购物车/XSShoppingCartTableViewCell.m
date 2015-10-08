//
//  XSShoppingCartTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/6.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSShoppingCartTableViewCell.h"
#import "ThemeColor.h"

#import <UIImageView+WebCache.h>
#import "CartModel.h"

@interface XSShoppingCartTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pnLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@end

@implementation XSShoppingCartTableViewCell

- (void)awakeFromNib {
    _minusButton.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    _minusButton.layer.borderWidth = 0.5f;
    _plusButton.layer.borderColor  = [OTHER_SEPARATOR_COLOR CGColor];
    _plusButton.layer.borderWidth  = 0.5f;
    _countLabel.layer.borderColor  = [OTHER_SEPARATOR_COLOR CGColor];
    _countLabel.layer.borderWidth  = 0.5f;
    
    _img.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    _img.layer.borderWidth = 0.5f;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        [_selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    } else {
        [_selectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    }
}

- (void)setItem:(CartItemModel *)item {
    _item = item;
    
    self.nameLabel.text = _item.name;
    [self.img sd_setImageWithURL:[NSURL URLWithString:_item.img]];
    self.pnLabel.text = [NSString stringWithFormat:@"￥%.2f", [_item.pn floatValue]];
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)_item.count];
}

- (IBAction)selectCell:(UIButton *)sender {
    if (_isSelected) {
        _isSelected = NO;
        [_selectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    } else {
        _isSelected = YES;
        [_selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }
}

- (IBAction)minus:(UIButton *)sender {
    if (_item.count > 0) {
        _item.count--;
        _countLabel.text = [NSString stringWithFormat:@"%ld", (long)_item.count];
    }
    
}

- (IBAction)plus:(UIButton *)sender {
    _item.count++;
    _countLabel.text = [NSString stringWithFormat:@"%ld", (long)_item.count];
}

@end
