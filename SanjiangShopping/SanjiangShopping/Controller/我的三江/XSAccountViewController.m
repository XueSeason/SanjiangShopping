//
//  XSAccountViewController.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSAccountViewController.h"
#import "XSAccountCenterView.h"
#import "AppMacro.h"

#import "XSLoginViewController.h"

#import "XSMyOrderViewController.h"

#import "XSWriteMemberNameViewController.h"
#import "XSBindMemberCardViewController.h"

#import "XSMyMemberCardViewController.h"

@interface XSAccountViewController ()

@end

@implementation XSAccountViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden           = NO;
    self.automaticallyAdjustsScrollViewInsets     = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    XSAccountCenterView *mainView = [[XSAccountCenterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [mainView.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [mainView.settingButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [mainView.orderView addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
    [mainView.tradeView.waitPayControl addTarget:self action:@selector(waitPay) forControlEvents:UIControlEventTouchUpInside];
    [mainView.tradeView.waitReceiptControl addTarget:self action:@selector(waitReceipt) forControlEvents:UIControlEventTouchUpInside];
    [mainView.tradeView.waitFeedbackControl addTarget:self action:@selector(waitFeedback) forControlEvents:UIControlEventTouchUpInside];
    [mainView.memberCardView addTarget:self action:@selector(memberCard) forControlEvents:UIControlEventTouchUpInside];
    [mainView.favoriteView addTarget:self action:@selector(favorite) forControlEvents:UIControlEventTouchUpInside];
    [mainView.couponView addTarget:self action:@selector(coupon) forControlEvents:UIControlEventTouchUpInside];
    [mainView.scoreView addTarget:self action:@selector(score) forControlEvents:UIControlEventTouchUpInside];
    [mainView.helpView addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:mainView];
}

#pragma mark 按钮点击事件
- (void)login {
    XSLoginViewController *loginViewController = [[XSLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

- (void)setting {
    NSLog(@"setting");
}

- (void)order {
    [self.navigationController pushViewController:[[XSMyOrderViewController alloc] init] animated:YES];
}

- (void)waitPay {
    NSLog(@"waitPay");
}

- (void)waitReceipt {
    NSLog(@"wait receipt");
}

- (void)waitFeedback {
    NSLog(@"wait feed back");
}

- (void)memberCard {
    NSLog(@"memberCard");
    
//    XSWriteMemberNameViewController *wvc = [[XSWriteMemberNameViewController alloc] init];
//    [self.navigationController pushViewController:wvc animated:YES];
    
    XSBindMemberCardViewController *bvc = [[XSBindMemberCardViewController alloc] init];
    [self.navigationController pushViewController:bvc animated:YES];
    
//    XSMyMemberCardViewController *mvc = [[XSMyMemberCardViewController alloc] init];
//    [self.navigationController pushViewController:mvc animated:YES];
}

- (void)favorite {
    NSLog(@"favorite");
}

- (void)coupon {
    NSLog(@"coupon");
}

- (void)score {
    NSLog(@"score");
}

- (void)help {
    NSLog(@"help");
}

@end
