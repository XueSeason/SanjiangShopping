//
//  XSBannerCollectionReusableView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/2.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSBannerCollectionReusableView.h"

#import "CollectionModel.h"
#import <UIImageView+WebCache.h>

@implementation XSBannerCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
}

- (void)configureForCollectionData:(CollectionDataModel *)data {
    [self.picture sd_setImageWithURL:[NSURL URLWithString:data.headAD]];
}

@end
