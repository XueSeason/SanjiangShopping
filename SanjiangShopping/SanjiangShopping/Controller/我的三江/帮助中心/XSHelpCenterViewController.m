//
//  XSHelpCenterViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/9/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSHelpCenterViewController.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSHelpCenterViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation XSHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    self.automaticallyAdjustsScrollViewInsets     = NO;
    
    self.webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    NSURL *url = [NSURL URLWithString:@"http://193.0.1.246:3000/#/help"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"帮助中心";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getters and setters 
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}


@end
