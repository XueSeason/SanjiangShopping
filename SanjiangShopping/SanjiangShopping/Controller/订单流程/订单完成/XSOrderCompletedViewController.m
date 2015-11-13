//
//  XSOrderCompletedViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/13/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSOrderCompletedViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSOrderCompletedViewController ()
@property (weak, nonatomic) IBOutlet UIButton *reviewOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *goShoppingButton;

@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *payOptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation XSOrderCompletedViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customeNavigationBar];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    self.reviewOrderButton.layer.borderColor = [THEME_RED CGColor];
    self.reviewOrderButton.layer.borderWidth = 0.5f;
}

#pragma mark - private methods
- (void)customeNavigationBar {
    self.navigationItem.title = @"确认订单";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
