//
//  XSSearchController.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/6/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSResultTableViewController;

@interface NSMutableArray (add)
- (void)addUniqueString:(NSString *)str;
@end

@interface XSSearchController : UISearchController

@property (copy, nonatomic) void (^searchWordQuery)(NSString *searchWord);

// delegate block
@property (copy, nonatomic) void (^presentSearchBlock)(UISearchController *searchController);
@property (copy, nonatomic) void (^willPresentSearchBlock)(UISearchController *searchController);
@property (copy, nonatomic) void (^didPresentSearchBlock)(UISearchController *searchController);
@property (copy, nonatomic) void (^willDismissSearchBlock)(UISearchController *searchController);
@property (copy, nonatomic) void (^didDismissSearchBlock)(UISearchController *searchController);


- (instancetype)initWithSearchResultsController:(XSResultTableViewController *)searchResultsController;

@end
