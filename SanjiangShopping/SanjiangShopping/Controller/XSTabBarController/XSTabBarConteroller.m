//
//  XSTabBarConteroller.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/24.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSTabBarConteroller.h"

#import "XSHomeViewController.h"
#import "XSMutiCatagoryViewController.h"
#import "XSPromotionViewController.h"
#import "XSShoppingCartViewController.h"
#import "XSAccountViewController.h"

#import "AppDelegate.h"

#import "ThemeColor.h"

#import <EAIntroView.h>

@interface XSTabBarConteroller ()

@end

@implementation XSTabBarConteroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XSHomeViewController *home                 = [[XSHomeViewController alloc] init];
    UINavigationController *homeNav            = [[UINavigationController alloc] initWithRootViewController:home];
    homeNav.tabBarItem.title                   = @"首页";
    homeNav.tabBarItem.selectedImage           = [UIImage imageNamed:@"tab1_p"];
    homeNav.tabBarItem.image                   = [UIImage imageNamed:@"tab1"];

    XSMutiCatagoryViewController *catagory     = [[XSMutiCatagoryViewController alloc] init];
    UINavigationController *catagoryNav        = [[UINavigationController alloc] initWithRootViewController:catagory];
    catagoryNav.tabBarItem.title               = @"分类";
    catagoryNav.tabBarItem.selectedImage       = [UIImage imageNamed:@"tab2_p"];
    catagoryNav.tabBarItem.image               = [UIImage imageNamed:@"tab2"];

    XSPromotionViewController *promotion       = [[XSPromotionViewController alloc] init];
    UINavigationController *promotionNav       = [[UINavigationController alloc] initWithRootViewController:promotion];
    promotionNav.tabBarItem.title              = @"促销";
    promotionNav.tabBarItem.selectedImage      = [UIImage imageNamed:@"tab3_p"];
    promotionNav.tabBarItem.image              = [UIImage imageNamed:@"tab3"];

    XSShoppingCartViewController *shoppingCart = [[XSShoppingCartViewController alloc] init];
    UINavigationController *shoppingCartNav    = [[UINavigationController alloc] initWithRootViewController:shoppingCart];
    shoppingCartNav.tabBarItem.title           = @"购物车";
    shoppingCartNav.tabBarItem.selectedImage   = [UIImage imageNamed:@"tab4_p"];
    shoppingCartNav.tabBarItem.image           = [UIImage imageNamed:@"tab4"];

    XSAccountViewController *account           = [[XSAccountViewController alloc] init];
    UINavigationController *accountNav         = [[UINavigationController alloc] initWithRootViewController:account];
    accountNav.tabBarItem.title                = @"我的三江";
    accountNav.tabBarItem.selectedImage        = [UIImage imageNamed:@"tab5_p"];
    accountNav.tabBarItem.image                = [UIImage imageNamed:@"tab5"];
    
    // 设置 tabbar 控制器
    self.viewControllers  = @[homeNav, catagoryNav, promotionNav, shoppingCartNav, accountNav];
    self.tabBar.tintColor = THEME_RED;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

@end
