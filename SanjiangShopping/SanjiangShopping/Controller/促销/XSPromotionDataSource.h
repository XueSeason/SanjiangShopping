//
//  XSPromotionDataSource.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/5/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface XSPromotionDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, copy) NSArray *items;

- (id)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier configureCellBlock:(TableViewCellConfigureBlock)configureCellBlock;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
