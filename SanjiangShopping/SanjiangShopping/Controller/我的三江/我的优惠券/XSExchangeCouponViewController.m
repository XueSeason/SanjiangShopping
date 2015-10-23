//
//  XSExchangeCouponViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/23.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSExchangeCouponViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSExchangeCouponViewController ()
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation XSExchangeCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.confirmButton.layer.cornerRadius = 5.0f;
    self.confirmButton.clipsToBounds = YES;
}

- (void)customNavigationBar {
    self.navigationItem.title = @"优惠码";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirm:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
