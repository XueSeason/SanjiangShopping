//
//  XSMutiCatagoryTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/1.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSMutiCatagoryTableViewCell.h"

#import "MenuModel.h"

#import "ThemeColor.h"
#define MENU_COLOR [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0]

@implementation XSMutiCatagoryTableViewCell

- (void)awakeFromNib {
    self.backgroundColor             = MENU_COLOR;
    self.contentView.backgroundColor = MENU_COLOR;
    self.layer.borderWidth           = 0.5f;
    self.layer.borderColor           = [OTHER_SEPARATOR_COLOR CGColor];
    
    self.textLabel.font              = [UIFont systemFontOfSize:12];
    self.textLabel.textAlignment     = NSTextAlignmentCenter;
}

- (void)configureForMenuItem:(MenuItemModel *)item {
    self.textLabel.text = item.ItemName;
    self.menuID         = item.ItemID;
    self.selected = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {
        self.contentView.backgroundColor  = [UIColor whiteColor];
        self.backgroundColor              = [UIColor whiteColor];
        self.textLabel.textColor          = THEME_RED;
        self.layer.borderColor            = [[UIColor whiteColor] CGColor];
    } else {
        self.contentView.backgroundColor = MENU_COLOR;
        self.backgroundColor             = MENU_COLOR;
        self.textLabel.textColor         = [UIColor blackColor];
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];

    }
}

@end
