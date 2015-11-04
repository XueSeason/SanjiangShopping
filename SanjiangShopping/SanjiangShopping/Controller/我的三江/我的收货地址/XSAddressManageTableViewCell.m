//
//  XSAddressManageTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/3/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSAddressManageTableViewCell.h"

#import "ThemeColor.h"
@interface XSAddressManageTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *myView;

@end
@implementation XSAddressManageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = BACKGROUND_COLOR;
//    self.myView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
//    self.myView.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
