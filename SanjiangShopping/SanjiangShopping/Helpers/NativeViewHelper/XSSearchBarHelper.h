//
//  XSSearchBarHelper.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSSearchBarHelper : NSObject

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) UITextField *UISearchBarTextField;
@property (strong, nonatomic) UIView      *_UISearchBarSearchFieldBackgroundView;

+ (void)hackStandardSearchBar:(UISearchBar *)searchBar keyword:(NSString *)keyword;

- (instancetype)initWithNavigationBar:(UISearchBar *)searchBar;
- (void)peek;

@end
