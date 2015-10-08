//
//  XSPhoneNumberVerifyViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/18.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSPhoneNumberVerifyViewController.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSPhoneNumberVerifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;

@end

@implementation XSPhoneNumberVerifyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.navigationItem.title = @"手机验证";
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _verifyButton.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1.0] CGColor];
    
    [_phoneNumberTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [_verifyCodeTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮事件

- (void)textFieldDidChange {
    if (_phoneNumberTextField.text && _phoneNumberTextField.text.length > 0
        && _verifyCodeTextField.text && _verifyCodeTextField.text.length > 0) {
        _completeButton.enabled = YES;
        _completeButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1.0];
        [_completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        _completeButton.enabled = NO;
        _completeButton.backgroundColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
        [_completeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_phoneNumberTextField resignFirstResponder];
    [_verifyCodeTextField resignFirstResponder];
}

@end
