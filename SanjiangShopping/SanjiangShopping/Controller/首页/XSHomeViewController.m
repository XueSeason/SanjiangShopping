//
//  XSHomeViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSHomeViewController.h"
#import "ThemeColor.h"

#import "XSNavigationBarHelper.h"
#import "XSSearchBarHelper.h"

#import "XSSearchTableViewController.h"
#import "XSResultTableViewController.h"

#import "XSHomeStaticViewController.h"
#import "XSHomeDynamicViewController.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import "HomeModel.h"
#import "HomeMoreModel.h"
#import "NetworkConstant.h"
#import "NotificationNameConstant.h"

@interface XSHomeViewController () <UIScrollViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) UIScrollView    *scrollView;
@property (strong, nonatomic) UIButton        *toTopButton;
@property (strong, nonatomic) UIBarButtonItem *scanButton;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) XSSearchTableViewController *searchTableViewController;
@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;
@property (assign, nonatomic) BOOL active;

@property (strong, nonatomic) XSHomeStaticViewController  *staticViewController;
@property (strong, nonatomic) XSHomeDynamicViewController *dynamicViewController;
@end

@implementation XSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstLoad) name:HomeModelNotificationName object:nil];
    
    // 设置导航栏
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
    [navHelper peek];
    navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_TRANSPARENT;
    navHelper._UIBackdropEffectView.hidden = YES;
    navHelper.UIImageView.hidden = YES; // 去除UIImageView带来的线框

    // 设置搜索框
    _resultTableViewController = [[XSResultTableViewController alloc] init];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultTableViewController];
    _searchController.searchBar.searchBarStyle             = UISearchBarStyleMinimal;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation     = NO;
    
    _searchController.delegate             = self;
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate   = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = [defaults dictionaryForKey:@"HomeModel"];
    NSString *keyword = [data[@"data"] objectForKey:@"keyword"];
    if (keyword == nil) {
        keyword = @"搜索商品名称/商品编号";
    }
    
    [XSSearchBarHelper hackStandardSearchBar:_searchController.searchBar keyword:keyword];
    
    self.navigationItem.titleView = _searchController.searchBar;
    
    // 添加扫描二维码按钮
    _scanButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ScanQRCode"] style:UIBarButtonItemStylePlain target:self action:@selector(scanQRCode)];
    _scanButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = _scanButton;
    
    // 滚动视图
    _scrollView                                = [[UIScrollView alloc] init];
    _scrollView.frame                          = [UIScreen mainScreen].bounds;
    _scrollView.contentInset                   = UIEdgeInsetsMake(0.0f, 0.0f, self.tabBarController.tabBar.frame.size.height, 0.0f);
    _scrollView.delegate                       = self;
    _scrollView.backgroundColor                = BACKGROUND_COLOR;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _active = YES;
    
    // 加载静态视图
    _staticViewController  = [[XSHomeStaticViewController alloc] init];
    _staticViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 375.0 * 379.0);
    _staticViewController.contextViewController = self;
    [_scrollView addSubview:_staticViewController.view];
    
    // 加载动态视图
    _dynamicViewController = [[XSHomeDynamicViewController alloc] init];
    [_scrollView addSubview:_dynamicViewController.view];
    
    // 设置contentSize
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _staticViewController.view.frame.origin.y + _staticViewController.view.frame.size.height);
    [self.view addSubview:_scrollView];
    
    _scrollView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    // 加载置顶按钮
    _toTopButton = [[UIButton alloc] init];
    [_toTopButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    _toTopButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_toTopButton setImage:[UIImage imageNamed:@"ToTop"] forState:UIControlStateNormal];
    [self.view addSubview:_toTopButton];
    _toTopButton.hidden = YES;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==44)]-8-|" options:0 metrics:nil views:@{@"button": _toTopButton}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==44)]-57-|" options:0 metrics:nil views:@{@"button": _toTopButton}]];
    
    [_toTopButton layoutIfNeeded];
    _toTopButton.layer.cornerRadius = _toTopButton.frame.size.width / 2.0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 取消滚动视图相对导航栏自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.tabBarController.tabBar.hidden = NO;
    if (self.searchController.active) {
        self.searchController.active = NO;
    }
    
    [self scrollViewDidScroll:_scrollView];
    
    // 加载本地JSON
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _homeModel = [defaults objectForKey:@"HomeModel"];
    
    self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark - 网络数据
- (void)refreshData {
    NSLog(@"刷新数据");
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_HOME];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        // JSON数据存储到本地
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:responseObject forKey:@"HomeModel"];
        [defaults synchronize];
        
        weakSelf.homeModel = [HomeModel objectWithKeyValues:responseObject];
        // 视图刷新
        [weakSelf reloadViewData];
        
        [weakSelf.scrollView.header endRefreshing];
        NSLog(@"刷新数据成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [weakSelf.scrollView.header endRefreshing];
        [alert show];
    }];
}

- (void)firstLoad {
    NSLog(@"首次加载");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id responseObject = [defaults objectForKey:@"HomeModel"];
    self.homeModel = [HomeModel objectWithKeyValues:responseObject];
    [self reloadViewData];
}

- (void)loadMoreData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_HOME_MORE];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        weakSelf.homeMoreMedel = [HomeMoreModel objectWithKeyValues:responseObject];
        
        [weakSelf.dynamicViewController generateMoreView:weakSelf.homeMoreMedel.data.list];
        
        [weakSelf resizeDynamicView];
        
        [weakSelf.scrollView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [weakSelf.scrollView.footer noticeNoMoreData];
    }];
}

#pragma mark - 视图刷新
- (void)reloadViewData {
    // 更新数据
    _staticViewController.bannerView.dataModels          = _homeModel.data.head;
    _staticViewController.buttonGridView.imageURLStrings = _homeModel.data.group;
    _dynamicViewController.data                          = _homeModel.data;
    [self resizeDynamicView];
}

- (void)resizeDynamicView {
    // 动态更新视图大小
    _dynamicViewController.view.frame = CGRectMake(0, _staticViewController.view.frame.size.height + _staticViewController.view.frame.origin.y, _dynamicViewController.dynamicSize.width, _dynamicViewController.dynamicSize.height);
    
    // 设置contentSize
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, _dynamicViewController.view.frame.origin.y + _dynamicViewController.view.frame.size.height);
    // 添加上拉刷新
    if (!_scrollView.footer) {
        _scrollView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}

#pragma mark - button click
- (void)scanQRCode {
    NSLog(@"Scan QRCode");
}

- (void)toTop {
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {

    }];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat offset = _scrollView.contentOffset.y;
    
    if (offset < 216.75 && _active) {
        XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
        [navHelper peek];
        navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(offset / 255.0);
    }
    
    // 显示置顶按钮
    if (offset < [UIScreen mainScreen].bounds.size.height) {
        _toTopButton.hidden = YES;
    } else {
        _toTopButton.hidden = NO;
    }
}

#pragma mark - Search Bar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"开始搜索");
    if ([searchBar.text isEqualToString:@""]) {
        NSLog(@"搜索默认热词");
        XSSearchBarHelper *searchBarHelper = [[XSSearchBarHelper alloc] initWithNavigationBar:_searchController.searchBar];
        [searchBarHelper peek];
        searchBar.text = searchBarHelper.UISearchBarTextField.placeholder;
    }
    [_searchTableViewController.recentSearchData addUniqueString:searchBar.text];
    [_searchTableViewController.tableView reloadData];
    
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Search Result Updater
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
}

#pragma mark - Search Controller Delegate
- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"开始进入搜索");
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    _active = NO;
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
    [navHelper peek];
    [UIView animateWithDuration:0.5 animations:^{
        navHelper._UINavigationBarBackground.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"将要进入搜索");
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationItem.leftBarButtonItem = nil;
    }];
    
    _searchTableViewController = [[XSSearchTableViewController alloc] init];
    _searchTableViewController.searchBar = _searchController.searchBar;
    _searchTableViewController.contextViewController = self;
    _searchTableViewController.tableView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_searchTableViewController.tableView];
    
    _searchController.searchBar.showsCancelButton = YES;
    UIView *firstView = _searchController.searchBar.subviews[0];
    for (UIView *secondView in firstView.subviews) {
        if ([secondView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *cancelButton = (UIButton *)secondView;
            cancelButton.tintColor = [UIColor lightGrayColor];
        }
    }
    
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
    [navHelper peek];
    navHelper.UIImageView.hidden = NO; // 显示UIImageView带来的线框
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"进入搜索");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"将要隐藏搜索");
    
    if (_searchTableViewController != nil) {
        [_searchTableViewController.tableView removeFromSuperview];
        _searchTableViewController = nil;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.navigationItem.leftBarButtonItem = _scanButton;
    }];
    
    _active = YES;
    CGFloat offset = _scrollView.contentOffset.y;
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
    [navHelper peek];
    if (offset < 216.75) {
        navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(offset / 255.0);
    } else {
        navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(0.85);
    }
    
    navHelper.UIImageView.hidden = YES; // 隐藏UIImageView带来的线框
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"隐藏搜索");
}

@end
