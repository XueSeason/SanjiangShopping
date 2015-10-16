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
    self.minusButton.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.minusButton.layer.borderWidth = 0.5f;
    self.plusButton.layer.borderColor  = [OTHER_SEPARATOR_COLOR CGColor];
    self.plusButton.layer.borderWidth  = 0.5f;
    self.countLabel.layer.borderColor  = [OTHER_SEPARATOR_COLOR CGColor];
    self.countLabel.layer.borderWidth  = 0.5f;
    
    self.img.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.img.layer.borderWidth = 0.5f;
}

#pragma mark - private methods
- (IBAction)selectCell:(UIButton *)sender {
    if (self.isSelected) {
        self.isSelected = NO;
        [self.selectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    } else {
        self.isSelected = YES;
        [self.selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }
}

- (IBAction)minus:(UIButton *)sender {
    if (self.item.count > 0) {
        self.item.count--;
        self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)self.item.count];
    }
    
}

- (IBAction)plus:(UIButton *)sender {
    self.item.count++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)self.item.count];
}

#pragma mark - getters and setters
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        [self.selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    } else {
        [self.selectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    }
}

- (void)setItem:(CartItemModel *)item {
    _item = item;
    
    self.nameLabel.text = _item.name;
    [self.img sd_setImageWithURL:[NSURL URLWithString:_item.img]];
    self.pnLabel.text = [NSString stringWithFormat:@"￥%.2f", [_item.pn floatValue]];
    self.countLabel.text = [NSString stringWithFormat:@"%ld", (long)_item.count];
}

@end
