//
//  XSHomeStaticViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSHomeStaticViewController.h"
#import "ThemeColor.h"
#import "XSBannerView.h"
#import "XSButtonGridView.h"

#import "XSFreshFoodViewController.h"
#import "XSNearByViewController.h"

@interface XSHomeStaticViewController ()

@end

@implementation XSHomeStaticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 滚动横幅
    _bannerView = [[XSBannerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 25 * 14)];
    _bannerView.animationSwitch = YES;
    [self.view addSubview:_bannerView];
    
    // 按钮列表
    _buttonGridView = [[XSButtonGridView alloc] initWithFrame:CGRectMake(0, _bannerView.frame.size.height + _bannerView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.width / 750 * 338)];
    _buttonGridView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_buttonGridView];
    
    self.view.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.view.layer.borderWidth = 0.5f;
    
    [_buttonGridView.button1 addTarget:self action:@selector(freshFood) forControlEvents:UIControlEventTouchUpInside];
    [_buttonGridView.button7 addTarget:self action:@selector(nearBy) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)freshFood {
    XSFreshFoodViewController *fvc = [[XSFreshFoodViewController alloc] init];
    [_contextViewController.navigationController pushViewController:fvc animated:YES];
}

- (void)nearBy {
    XSNearByViewController *nvc = [[XSNearByViewController alloc] init];
    [_contextViewController.navigationController pushViewController:nvc animated:YES];
}
@end
