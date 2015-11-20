//
//  XSSelectCommodityCountTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/20/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSelectCommodityCountTableViewCell.h"
#import "ThemeColor.h"

@interface XSSelectCommodityCountTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@end

@implementation XSSelectCommodityCountTableViewCell

- (void)awakeFromNib {
    CALayer *line = [CALayer layer];
    [self.layer addSublayer:line];
    line.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 50 - 10, 0.5);
    line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
    [self borderify:self.countLabel];
    [self borderify:self.minusButton];
    [self borderify:self.plusButton];
}

- (void)borderify:(UIView *)view {
    view.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    view.layer.borderWidth = 0.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
