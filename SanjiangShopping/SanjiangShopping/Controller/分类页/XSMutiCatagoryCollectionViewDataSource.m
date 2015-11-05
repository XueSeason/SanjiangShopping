//
//  XSMutiCatagoryCollectionViewDataSource.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/5/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMutiCatagoryCollectionViewDataSource.h"

#import "CollectionModel.h"

#import "XSHeaderCollectionReusableView.h"
#import "XSBannerCollectionReusableView.h"

#import "ThemeColor.h"

#import <UIImageView+WebCache.h>

static NSString * const collectionFooterId = @"footer";
static NSString * const collectionHeaderId = @"header";
static NSString * const collectionBannerID = @"banner";

@interface XSMutiCatagoryCollectionViewDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) MutiCatagoryCollectionViewCellConfigureBlock configureCellBlock;

@end

@implementation XSMutiCatagoryCollectionViewDataSource

- (id)initWithData:(CollectionDataModel *)data cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(MutiCatagoryCollectionViewCellConfigureBlock)configureCellBlock {
    self = [super init];
    if (self) {
        self.data = data;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = configureCellBlock;
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.data.list.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    
    return [self.data.list[section - 1] items].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    CollectionItemModel  *item = (CollectionItemModel *)[[self.data.list[indexPath.section - 1] items] objectAtIndex:indexPath.row];
    
    self.configureCellBlock(cell, item);
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        if (indexPath.section == 0) {
            XSBannerCollectionReusableView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionBannerID forIndexPath:indexPath];
            [header.picture sd_setImageWithURL:[NSURL URLWithString:self.data.headAD]];
            return header;
        }
        
        XSHeaderCollectionReusableView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderId forIndexPath:indexPath];
        header.titleLabel.text = [self.data.list[indexPath.section -1] title];
        header.colorLabel.backgroundColor = THEME_RED;
        return header;
    }
    return nil;
}

@end
