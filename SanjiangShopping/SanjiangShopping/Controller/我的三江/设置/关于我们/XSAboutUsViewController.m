//
//  XSAboutUsViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSAboutUsViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSAboutUsViewController ()

@end

@implementation XSAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavigationBar];
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"关于我们";
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
