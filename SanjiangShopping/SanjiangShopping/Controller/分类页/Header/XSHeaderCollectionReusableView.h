//
//  XSHeaderCollectionReusableView.h
//  XSMutiCatagoryView
//
//  Created by 薛纪杰 on 15/8/14.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionListModel;

@interface XSHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)configureForCollectionList:(CollectionListModel *)item;

@end
