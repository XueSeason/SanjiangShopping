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

- (instancetype)initWithSearchResultsController:(XSResultTableViewController *)searchResultsController;

@end
