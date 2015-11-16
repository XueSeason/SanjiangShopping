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

#import "UserModel.h"

#import "XSSettingViewController.h"

#import "XSLoginViewController.h"

#import "XSLogisticsViewController.h"

#import "XSMyOrderViewController.h"
#import "XSMyCouponViewController.h"
#import "XSMyFavoriteViewController.h"
#import "XSAddressManageViewController.h"

#import "XSWriteMemberNameViewController.h"
#import "XSBindMemberCardViewController.h"

#import "XSMyMemberCardViewController.h"

#import "XSHelpCenterViewController.h"

@interface XSAccountViewController ()
@property (strong, nonatomic) XSAccountCenterView *mainView;
@property (strong, nonatomic) UserModel *user;
@end

@implementation XSAccountViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden           = NO;
    self.automaticallyAdjustsScrollViewInsets     = NO;
    
    if (self.user != nil) {
        self.mainView.loginButton.hidden = YES;
        self.mainView.loginLabel.hidden = YES;
        
        self.mainView.avatar.hidden = NO;
        self.mainView.nameLabel.hidden = NO;
        self.mainView.memberLabel.hidden = NO;
        self.mainView.updateMemberButton.hidden = NO;
        self.mainView.memberImageView.hidden = NO;
    } else {
        self.mainView.loginButton.hidden = NO;
        self.mainView.loginLabel.hidden = NO;
        
        self.mainView.avatar.hidden = YES;
        self.mainView.nameLabel.hidden = YES;
        self.mainView.memberLabel.hidden = YES;
        self.mainView.updateMemberButton.hidden = YES;
        self.mainView.memberImageView.hidden = YES;

    }
}

#pragma mark - getters and setters
- (XSAccountCenterView *)mainView {
    if (_mainView == nil) {
        _mainView = [[XSAccountCenterView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        [_mainView.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.settingButton addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.orderView addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.tradeView.waitPayControl addTarget:self action:@selector(waitPay) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.tradeView.waitReceiptControl addTarget:self action:@selector(waitReceipt) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.tradeView.waitFeedbackControl addTarget:self action:@selector(waitFeedback) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.memberCardView addTarget:self action:@selector(memberCard) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.favoriteView addTarget:self action:@selector(favorite) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.addressView addTarget:self action:@selector(address) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.couponView addTarget:self action:@selector(coupon) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.scoreView addTarget:self action:@selector(score) forControlEvents:UIControlEventTouchUpInside];
        [_mainView.helpView addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainView;
}

#pragma mark - private methods
- (UserModel *)user {
    _user = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"user"]];
    return _user;
}

#pragma mark - event response
- (void)login {
    XSLoginViewController *loginViewController = [[XSLoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self.parentViewController presentViewController:nav animated:YES completion:nil];
}

- (void)setting {
    [self.navigationController pushViewController:[[XSSettingViewController alloc] init] animated:YES];
}

- (void)order {
    if (self.user) {
        [self.navigationController pushViewController:[[XSMyOrderViewController alloc] init] animated:YES];
    } else {
        [self login];
    }
}

- (void)waitPay {
    NSLog(@"waitPay");
    if (self.user) {

    } else {
        [self login];
    }
}

- (void)waitReceipt {
    if (self.user) {
        [self.navigationController pushViewController:[[XSLogisticsViewController alloc] init] animated:YES];
    } else {
        [self login];
    }
}

- (void)waitFeedback {
    NSLog(@"wait feed back");
    if (self.user) {

    } else {
        [self login];
    }
}

- (void)memberCard {
    NSLog(@"memberCard");

    if (self.user) {
        //    XSWriteMemberNameViewController *wvc = [[XSWriteMemberNameViewController alloc] init];
        //    [self.navigationController pushViewController:wvc animated:YES];
        
        XSBindMemberCardViewController *bvc = [[XSBindMemberCardViewController alloc] init];
        [self.navigationController pushViewController:bvc animated:YES];
        
        //    XSMyMemberCardViewController *mvc = [[XSMyMemberCardViewController alloc] init];
        //    [self.navigationController pushViewController:mvc animated:YES];
    } else {
        [self login];
    }
}

- (void)favorite {
    if (self.user) {
        [self.navigationController pushViewController:[[XSMyFavoriteViewController alloc] init] animated:YES];
    } else {
        [self login];
    }
}

- (void)address {
    if (self.user) {
        [self.navigationController pushViewController:[[XSAddressManageViewController alloc] init] animated:YES];
    } else {
        [self login];
    }
}

- (void)coupon {
    if (self.user) {
        [self.navigationController pushViewController:[[XSMyCouponViewController alloc] init] animated:YES];
    } else {
        [self login];
    }
}

- (void)score {
    NSLog(@"score");
    
    if (self.user) {

    } else {
        [self login];
    }
}

- (void)help {
    [self.navigationController pushViewController:[[XSHelpCenterViewController alloc] init] animated:YES];
}

@end
