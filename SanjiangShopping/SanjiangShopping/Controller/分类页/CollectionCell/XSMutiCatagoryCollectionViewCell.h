//
//  XSMutiCatagoryCollectionViewCell.h
//  XSMutiCatagoryView
//
//  Created by 薛纪杰 on 15/8/14.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionItemModel;

@interface XSMutiCatagoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (copy, nonatomic) NSString *itemID;

- (void)configureForCollectionItem:(CollectionItemModel *)collectionItem;

@end
