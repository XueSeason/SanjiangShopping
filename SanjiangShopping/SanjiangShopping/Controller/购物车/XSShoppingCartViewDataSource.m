//
//  XSShoppingCartViewDataSource.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/11/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSShoppingCartViewDataSource.h"

#import "XSShoppingCartTableViewCell.h"
#import "XSAddressTableViewCell.h"

@interface XSShoppingCartViewDataSource ()

@property (nonatomic, copy) NSString *addressIdentifier;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) ShoppingCartAddressConfigureBlock addressConfigureBlock;
@property (nonatomic, copy) ShoppingCartTableViewCellConfigureBlock cellConfigureBlock;

@end

@implementation XSShoppingCartViewDataSource

- (id)initWithItems:(NSArray *)items addressIdentifier:(NSString *)addressIdentifier cellIdentifier:(NSString *)cellIdentifier configureAddressBlock:(ShoppingCartAddressConfigureBlock)addressConfigureBlock configureCellBlock:(ShoppingCartTableViewCellConfigureBlock)cellConfigureBlock {
    self = [super init];
    if (self) {
        self.items = items;
        
        self.addressIdentifier = addressIdentifier;
        self.addressConfigureBlock = addressConfigureBlock;
        
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = cellConfigureBlock;
    }
    return self;
}

#pragma mark - public methods
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger)indexPath.row];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self itemAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        XSAddressTableViewCell *cell = (XSAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:self.addressIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.addressConfigureBlock(cell, item);
        return cell;
    }
    
    XSShoppingCartTableViewCell *cell = (XSShoppingCartTableViewCell *)[tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.cellConfigureBlock(cell, item);
    return cell;
}


@end
