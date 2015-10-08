//
//  XSWriteMemberNameViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/18.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSWriteMemberNameViewController.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

#import "XSPhoneNumberVerifyViewController.h"

@interface XSWriteMemberNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation XSWriteMemberNameViewController

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
    self.navigationItem.title = @"填写姓名";
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
    [rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameTextField resignFirstResponder];
}

- (void)done {
    XSPhoneNumberVerifyViewController *pvc = [[XSPhoneNumberVerifyViewController alloc] init];
    [self.navigationController pushViewController:pvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
