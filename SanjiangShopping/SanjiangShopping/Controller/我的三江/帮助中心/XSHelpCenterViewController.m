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

#import <WebViewJavascriptBridge.h>

@interface XSHelpCenterViewController () <UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WebViewJavascriptBridge* bridge;
@end

@implementation XSHelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        // 显示接受到的消息
        NSLog(@"从 JS 接受到消息: %@", data);
    }];
    
    [self.bridge registerHandler:@"submit" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"data: %@", (NSDictionary *)data);
        NSLog(@"%@", data[@"feedback"]);
        NSLog(@"%@", data[@"phone"]);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    self.automaticallyAdjustsScrollViewInsets     = NO;
    
    self.webView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    
    self.progressView.frame    = CGRectMake(0, 64, self.view.frame.size.width, 2);
    self.progressView.hidden   = NO;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.progressView.progress = 0.33f;
    }];
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

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.webView.canGoBack) {
            [self.webView goBack];
        } else {
            [self comeBack];
        }
    }
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"should start load request");

    NSLog(@"%@", request);
    NSLog(@"%ld", navigationType);

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"didSatartLoad");
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.progressView.progress = 0.66f;
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"didFinishLoad");
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.progressView.progress = 1.0f;
    } completion:^(BOOL finished) {
        weakSelf.progressView.hidden = YES;
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"didFailLoad");
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.progressView.progress = 0.0f;
    } completion:^(BOOL finished) {
        weakSelf.progressView.hidden = YES;
        // 加载失败页面
    }];
}

#pragma mark - getters and setters 
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
        [_webView addGestureRecognizer:swipeRight];
        
        NSURL *url = [NSURL URLWithString:@"http://icheng.sinaapp.com/#/appInterface/help/feedback"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progressTintColor = THEME_RED;
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}

@end
