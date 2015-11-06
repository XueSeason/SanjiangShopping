//
//  XSHeaderCollectionReusableView.m
//  XSMutiCatagoryView
//
//  Created by 薛纪杰 on 15/8/14.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSHeaderCollectionReusableView.h"
#import "CollectionModel.h"
#import "ThemeColor.h"

@implementation XSHeaderCollectionReusableView

- (void)awakeFromNib {
    self.colorLabel.backgroundColor = THEME_RED;
}

- (void)configureForCollectionList:(CollectionListModel *)item {
    self.titleLabel.text = item.title;
}

@end
