//
//  XSMutiCatagoryCollectionViewCell.m
//  XSMutiCatagoryView
//
//  Created by 薛纪杰 on 15/8/14.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSMutiCatagoryCollectionViewCell.h"

#import "CollectionModel.h"

#import <UIImageView+WebCache.h>

@implementation XSMutiCatagoryCollectionViewCell

- (void)awakeFromNib {
    
}

- (void)configureForCollectionItem:(CollectionItemModel *)collectionItem {
    self.itemID = collectionItem.itemID;
    self.name.text = collectionItem.itemName;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:collectionItem.img]];
}

@end
