//
//  XSPayOptionTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/9.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSPayOptionTableViewCell.h"
#import "ThemeColor.h"

@implementation XSPayOptionTableViewCell

- (void)awakeFromNib {

    CALayer *line = [[CALayer alloc] init];
    line.frame = CGRectMake(8, 84, [UIScreen mainScreen].bounds.size.width - 8, 1);
    line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
    [self.layer addSublayer:line];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)payOptionSwitch:(UIButton *)sender {
    if (sender == self.onlineButton) {
        self.option = 0;
    } else {
        self.option = 1;
    }
}

- (void)setOption:(NSInteger)option {
    if (option == 0) {
        [self.onlineButton setImage:[UIImage imageNamed:@"selected_non"] forState:UIControlStateNormal];
        [self.offlineButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    } else {
        [self.onlineButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [self.offlineButton setImage:[UIImage imageNamed:@"selected_non"] forState:UIControlStateNormal];
    }
    _option = option;
}


@end
