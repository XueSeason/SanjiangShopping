//
//  XSMutiCatagoryCollectionViewDataSource.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/5/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CollectionDataModel;

typedef void (^MutiCatagoryCollectionViewCellConfigureBlock)(id cell, id item);

@interface XSMutiCatagoryCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, strong) CollectionDataModel *data;

- (id)initWithData:(CollectionDataModel *)data
    cellIdentifier:(NSString *)cellIdentifier
  bannerIdentifier:(NSString *)bannerIdentifier
  headerIdentifier:(NSString *)headerIdentifier
configureCellBlock:(MutiCatagoryCollectionViewCellConfigureBlock)configureCellBlock;

@end
