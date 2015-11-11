//
//  XSShoppingCartViewDataSource.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/11/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ShoppingCartAddressConfigureBlock)(id cell, id item);
typedef void (^ShoppingCartTableViewCellConfigureBlock)(id cell, id item);

@interface XSShoppingCartViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, copy) NSArray *items;

- (id)initWithItems:(NSArray *)items
  addressIdentifier:(NSString *)addressIdentifier
     cellIdentifier:(NSString *)cellIdentifier
configureAddressBlock:(ShoppingCartAddressConfigureBlock)addressConfigureBlock
 configureCellBlock:(ShoppingCartTableViewCellConfigureBlock)cellConfigureBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
