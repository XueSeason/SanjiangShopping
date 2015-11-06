//
//  XSSearchTableViewController.h
//  XSSearchController
//
//  Created by 薛纪杰 on 15/8/21.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableArray (add)
- (void)addUniqueString:(NSString *)str;
@end

@interface XSSearchTableViewController : UITableViewController

@property (weak, nonatomic)   UIViewController *contextViewController;
@property (strong, nonatomic) NSMutableArray   *recentSearchData;
@property (strong, nonatomic) UISearchBar      *searchBar;

- (void)loadHotWords;
- (void)loadHistoryRecord;

@end
