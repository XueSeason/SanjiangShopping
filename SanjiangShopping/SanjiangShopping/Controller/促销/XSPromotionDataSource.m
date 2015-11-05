//
//  XSPromotionDataSource.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/5/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSPromotionDataSource.h"

static NSString * const promotionCellID = @"promotion";

@interface XSPromotionDataSource ()

@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation XSPromotionDataSource

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
    self = [super init];
    if (self) {
        self.items = items;
        self.cellIdentifier = cellIdentifier;
        self.configureCellBlock = configureCellBlock;
    }
    return self;
}

#pragma mark - public methods
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger)indexPath.row];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:promotionCellID forIndexPath:indexPath];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

//#pragma mark - getters and setters 
//- (void)setItems:(NSArray *)items {
//    _items = [items copy];
//}

@end
