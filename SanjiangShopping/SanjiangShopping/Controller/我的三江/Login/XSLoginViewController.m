//
//  XSLoginViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/15.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSLoginViewController.h"

#import "XSRegisterViewController.h"
#import "XSForgetPasswordViewController.h"

#import "ThemeColor.h"
#import "XSNavigationBarHelper.h"

@interface XSLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *pwdSwitchButton;

@end

@implementation XSLoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"快速注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAccount)];
    [rightButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [leftButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    [_accountTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [_passwordTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)customNavigationBar {
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    self.navigationItem.title = @"登录";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 按钮事件
- (void)registerAccount {
    [self.navigationController pushViewController:[[XSRegisterViewController alloc] init] animated:YES];
}

- (IBAction)login:(UIButton *)sender {
    
}

- (IBAction)forgetPassword:(UIButton *)sender {
    XSForgetPasswordViewController *forgetPassword = [[XSForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPassword animated:YES];
}

- (IBAction)pwdSwitch:(UIButton *)sender {
    _passwordTextField.secureTextEntry = !_passwordTextField.secureTextEntry;
    [self.pwdSwitchButton setImage:_passwordTextField.secureTextEntry ? [UIImage imageNamed:@"pwd_eye_open"] : [UIImage imageNamed:@"pwd_eye_close"] forState:UIControlStateNormal];
}

- (void)back {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidChange {
    if (_accountTextField.text && _accountTextField.text.length > 0 && _passwordTextField.text && _passwordTextField.text.length > 0) {
        _loginButton.enabled = YES;
        _loginButton.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1.0];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        _loginButton.enabled = NO;
        _loginButton.backgroundColor = [UIColor colorWithRed:204 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
        [_loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_accountTextField resignFirstResponder];
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
