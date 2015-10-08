//
//  XSRegisterViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/16.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSRegisterViewController.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;

//@property (strong, nonatomic) NSTimer *timer;

@end

@implementation XSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏返回按钮文字
    self.navigationItem.title = @"注册";
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _verifyButton.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1.0] CGColor];
    
    [_phoneNumberTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [_verifyCodeTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮事件
- (void)textFieldDidChange {
    if (_phoneNumberTextField.text && _phoneNumberTextField.text.length > 0
        && _passwordTextField.text && _passwordTextField.text.length > 0
        && _verifyCodeTextField.text && _verifyCodeTextField.text.length > 0) {
        _registerButton.enabled = YES;
        _registerButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1.0];
        [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        _registerButton.enabled = NO;
        _registerButton.backgroundColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
        [_registerButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (IBAction)registerAccount:(UIButton *)sender {

}

- (IBAction)getVerifyCode:(UIButton *)sender {
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_phoneNumberTextField resignFirstResponder];
    [_verifyCodeTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
