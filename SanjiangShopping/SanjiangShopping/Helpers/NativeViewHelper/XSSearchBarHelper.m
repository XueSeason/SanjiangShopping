//
//  XSSearchBarHelper.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSSearchBarHelper.h"

#import "UtilsMacro.h"

@implementation XSSearchBarHelper

+ (void)hackStandardSearchBar:(UISearchBar *)searchBar keyword:(NSString *)keyword {
    XSSearchBarHelper *searchBarHelper = [[XSSearchBarHelper alloc] initWithNavigationBar:searchBar];
    [searchBarHelper peek];
    
    searchBarHelper.UISearchBarTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:keyword attributes:@{NSForegroundColorAttributeName: UIColorFromRGB(0xAAAAAA, 1.0)}];
    searchBarHelper.UISearchBarTextField.textColor = UIColorFromRGB(0xAAAAAA, 1.0);
    searchBarHelper.UISearchBarTextField.enablesReturnKeyAutomatically = NO;
    searchBarHelper._UISearchBarSearchFieldBackgroundView.backgroundColor = UIColorFromRGB(0xF8F8F8, 0.85);
    searchBarHelper._UISearchBarSearchFieldBackgroundView.layer.cornerRadius = 5;
}

- (instancetype)initWithNavigationBar:(UISearchBar *)searchBar
{
    self = [super init];
    if (self) {
        _searchBar = searchBar;
    }
    return self;
}

- (void)peek {
    [self recursion:_searchBar];
}

- (void)recursion:(UIView *)superView
{
    if (_UISearchBarTextField && __UISearchBarSearchFieldBackgroundView) {
        return;
    }
    
    if([superView isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
        _UISearchBarTextField = (UITextField *)superView;
    } else if ([superView isKindOfClass:NSClassFromString(@"_UISearchBarSearchFieldBackgroundView")]) {
        __UISearchBarSearchFieldBackgroundView = superView;
    }
    
    for (UIView *view in superView.subviews) {
        [self recursion:view];
    }
}

@end
