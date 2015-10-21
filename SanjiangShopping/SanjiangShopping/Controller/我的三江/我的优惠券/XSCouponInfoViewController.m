//
//  XSCouponInfoViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCouponInfoViewController.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSCouponInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation XSCouponInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self customNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"优惠券使用说明";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
