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

#import "XSBannerView.h"
#import "XSButtonGridView.h"
#import "XSFreshFoodViewController.h"
#import "XSNearByViewController.h"

#import "XSBuyNowViewController.h"

#import "XS4211View.h"
#import "XS1111GrayView.h"
#import "XS1111WhiteView.h"
#import "XSScrollView.h"
#import "XSBuyNowView.h"
#import "XSThemeView.h"
#import "XSMoreView.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import "HomeModel.h"
#import "HomeMoreModel.h"
#import "NetworkConstant.h"
#import "NotificationNameConstant.h"

static const CGFloat step = 9.0f;

@interface XSHomeViewController () <UIScrollViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>
{
    CGSize dynamicSize;
}

// main view
@property (strong, nonatomic) UIScrollView     *scrollView;

@property (strong, nonatomic) UIView           *staticView;
@property (strong, nonatomic) XSBannerView     *bannerView;
@property (strong, nonatomic) XSButtonGridView *buttonGridView;
@property (strong, nonatomic) UIView           *dynamicView;

// widget view
@property (strong, nonatomic) UIButton        *toTopButton;
@property (strong, nonatomic) UIBarButtonItem *scanButton;

// other property
@property (strong, nonatomic) XSNavigationBarHelper *navHelper;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) XSSearchTableViewController *searchTableViewController;
@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;
@property (assign, nonatomic) BOOL active;

@property (strong, nonatomic) NSMutableArray *moreViewArr;

@end

@implementation XSHomeViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 自定义导航栏
    [self customNavigationBar];
    
    // 添加滚动视图
    [self.view addSubview:self.scrollView];
    
    // 添加置顶按钮
    [self.view addSubview:self.toTopButton];
    
    // 添加观察者
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(firstDownload) name:HomeModelNotificationName object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self transparentizeNavigationBar];
    [self adjustView];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.homeModel = [defaults objectForKey:@"HomeModel"];
    
    self.definesPresentationContext = YES;
    
    self.scrollView.frame         = self.view.bounds;
    self.scrollView.contentInset  = UIEdgeInsetsMake(0.0f, 0.0f, self.tabBarController.tabBar.frame.size.height, 0.0f);
    self.staticView.frame         = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 375.0 * 379.0);
    self.bannerView.frame         = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 25 * 14);
    self.buttonGridView.frame     = CGRectMake(0, self.bannerView.frame.size.height + self.bannerView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.width / 750 * 338);
    self.staticView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.staticView.layer.borderWidth = 0.5f;
    self.scrollView.contentSize   = CGSizeMake(self.view.frame.size.width, self.staticView.frame.origin.y + self.staticView.frame.size.height);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==44)]-8-|" options:0 metrics:nil views:@{@"button": self.toTopButton}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==44)]-57-|" options:0 metrics:nil views:@{@"button": self.toTopButton}]];
    [self.toTopButton layoutIfNeeded];
    self.toTopButton.layer.cornerRadius = self.toTopButton.frame.size.width / 2.0;
    
    [self downloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HomeModelNotificationName object:nil];
    self.navHelper._UINavigationBarBackground.opaque = YES;
    self.scrollView.footer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat offset = self.scrollView.contentOffset.y;
    
    if (offset < 216.75 && self.active) {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(offset / 255.0);
    }
    
    // 显示置顶按钮
    if (offset < [UIScreen mainScreen].bounds.size.height) {
        self.toTopButton.hidden = YES;
    } else {
        self.toTopButton.hidden = NO;
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"开始搜索");
    if ([searchBar.text isEqualToString:@""]) {
        NSLog(@"搜索默认热词");
        XSSearchBarHelper *searchBarHelper = [[XSSearchBarHelper alloc] initWithNavigationBar:_searchController.searchBar];
        [searchBarHelper peek];
        searchBar.text = searchBarHelper.UISearchBarTextField.placeholder;
    }
    [self.searchTableViewController.recentSearchData addUniqueString:searchBar.text];
    [self.searchTableViewController.tableView reloadData];
    
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
}

#pragma mark - UISearchControllerDelegate
- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"开始进入搜索");
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.active = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.navHelper._UINavigationBarBackground.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"将要进入搜索");
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationItem.leftBarButtonItem = nil;
    }];
    
    self.searchTableViewController.tableView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:self.searchTableViewController.tableView];
    
    self.navHelper.UIImageView.hidden = NO; // 显示UIImageView带来的线框
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"进入搜索");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"将要隐藏搜索");
    
    if (self.searchTableViewController != nil) {
        [self.searchTableViewController.tableView removeFromSuperview];
        self.searchTableViewController = nil;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.navigationItem.leftBarButtonItem = self.scanButton;
    }];
    
    self.active = YES;
    CGFloat offset = self.scrollView.contentOffset.y;
    if (offset < 216.75) {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(offset / 255.0);
    } else {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(0.85);
    }
    
    self.navHelper.UIImageView.hidden = YES; // 隐藏UIImageView带来的线框
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"隐藏搜索");
}

#pragma mark - event response
- (void)scanQRCode {
    NSLog(@"Scan QRCode");
}

- (void)toTop {
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)freshFood {
    XSFreshFoodViewController *fvc = [[XSFreshFoodViewController alloc] init];
    [self.navigationController pushViewController:fvc animated:YES];
}

- (void)nearBy {
    XSNearByViewController *nvc = [[XSNearByViewController alloc] init];
    [self.navigationController pushViewController:nvc animated:YES];
}

- (void)buyNow {
    [self.navigationController pushViewController:[[XSBuyNowViewController alloc] init] animated:YES];
}

#pragma mark - private methods
- (void)adjustView {
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 取消滚动视图相对导航栏自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 不隐藏TabBar
    self.tabBarController.tabBar.hidden = NO;
    
    // 取消搜索框聚焦
    if (self.searchController.active) {
        self.searchController.active = NO;
    }
    
    // 调整渐变颜色
    [self scrollViewDidScroll:_scrollView];
}

- (void)customNavigationBar {
    self.navigationItem.titleView = self.searchController.searchBar;
    self.navigationItem.leftBarButtonItem = self.scanButton;
}

- (void)transparentizeNavigationBar {
    self.navHelper._UINavigationBarBackground.backgroundColor = THEME_TRANSPARENT;
    self.navHelper._UINavigationBarBackground.opaque = NO;
    self.navHelper._UIBackdropEffectView.hidden = YES;
    self.navHelper.UIImageView.hidden = YES; // 去除UIImageView带来的线框
}

- (void)generateDynamicSubview {
    NSArray *floors = self.homeDataModel.floors;
    CGFloat height = 0.0f;
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    
    for (FloorModel *floor in floors) {
        if (floor.vt == 1) {
            height += step;
            CGRect frame         = CGRectMake(0, height, width, width / 75 * 38 );
            XS4211View *tempView = [[XS4211View alloc] initWithFrame:frame];
            tempView.floorModel  = floor;
            [self.dynamicView addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 2) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, (width - 2) / 2 + 2 + 40 );
            XS1111GrayView *tempView = [[XS1111GrayView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.dynamicView addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 3) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, (width - 2) / 2 + 2 + 40 );
            XS1111WhiteView *tempView = [[XS1111WhiteView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.dynamicView addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 4) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, 160 + 40 );
            XSScrollView *tempView = [[XSScrollView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.dynamicView addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 5) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, width / 75.0 * 24.0 + 40);
            XSBuyNowView *tempView = [[XSBuyNowView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.dynamicView addSubview:tempView];
            height += frame.size.height;
            
            // 添加事件
            [tempView.moreControl addTarget:self action:@selector(buyNow) forControlEvents:UIControlEventTouchUpInside];
        } else if (floor.vt == 6) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, width / 15.0 * 4.0 );
            XSBannerView *tempView = [[XSBannerView alloc] initWithFrame:frame];
            tempView.dataModels = floor.data;
            [self.dynamicView addSubview:tempView];
            height += frame.size.height;
        }
    }
    
    height += step;
    
    // 加载主题区
    CGRect themeFrame = CGRectMake(0, height, width, width / 75.0 * 84.0 + 40);
    XSThemeView *themeView = [[XSThemeView alloc] initWithFrame:themeFrame];
    themeView.subject      = _homeDataModel.subject;
    [self.dynamicView addSubview:themeView];
    height += themeView.frame.size.height;
    
    // 加载推荐视图
    CGRect recommendFrame = CGRectMake(0, themeFrame.size.height + themeFrame.origin.y, width, 44);
    UIView *recommend = [[UIView alloc] initWithFrame:recommendFrame];
    [self.dynamicView addSubview:recommend];
    height += recommendFrame.size.height;
    recommend.backgroundColor = [UIColor clearColor];
    UIView *temp = [[[NSBundle mainBundle] loadNibNamed:@"RecommendView" owner:self options:nil] objectAtIndex:0];
    temp.frame = recommend.bounds;
    [recommend addSubview:temp];
    
    dynamicSize = CGSizeMake(width, height);
}

- (void)generateMoreView:(NSArray *)list {
    UIView *moreView = [[UIView alloc] init];
    
    CGFloat width = (self.view.frame.size.width - 30) / 2.0;
    CGFloat height = width * 100 / 69.0;
    CGFloat dynamicHeight = 0.0f;
    
    for (int i = 0; i < list.count; i++) {
        CGRect frame = CGRectMake((i % 2) * (width + 10) + 10, dynamicHeight, width, height);
        
        XSMoreView *tempView = [[XSMoreView alloc] initWithFrame:frame];
        tempView.item        = list[i];
        [moreView addSubview:tempView];
        [_moreViewArr addObject:tempView];
        if (i % 2 == 1) {
            dynamicHeight += frame.size.height + 10;
        }
    }
    
    [self.dynamicView addSubview:moreView];
    
    CGFloat tempWidth = dynamicSize.width;
    CGFloat tempHeight = dynamicSize.height;
    
    moreView.frame = CGRectMake(0, tempHeight, self.view.frame.size.width, dynamicHeight);
    dynamicSize = CGSizeMake(tempWidth, tempHeight + moreView.frame.size.height);
}

- (void)firstDownload {
    NSLog(@"首次加载");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id responseObject = [defaults objectForKey:@"HomeModel"];
    self.homeModel = [HomeModel objectWithKeyValues:responseObject];
    [self refreshView];
}

- (void)downloadData {
    NSLog(@"下载数据");
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_HOME];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:responseObject forKey:@"HomeModel"];
        [defaults synchronize];
        
        weakSelf.homeModel = [HomeModel objectWithKeyValues:responseObject];
        [weakSelf refreshView];
        
        NSLog(@"下载数据完成");
        [weakSelf.scrollView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [weakSelf.scrollView.header endRefreshing];
        [alert show];
    }];
}

- (void)downloadMoreData {
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
        
        [weakSelf generateMoreView:weakSelf.homeMoreMedel.data.list];
        
        [weakSelf refreshDynamicView];
        
        [weakSelf.scrollView.footer endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [weakSelf.scrollView.footer endRefreshingWithNoMoreData];
    }];
}

- (void)refreshView {
    [self refreshStaticView];
    [self refreshDynamicView];
}

- (void)refreshStaticView {
    self.bannerView.dataModels          = self.homeModel.data.head;
    self.buttonGridView.imageURLStrings = self.homeModel.data.group;
    self.homeDataModel                  = self.homeModel.data;
}

- (void)refreshDynamicView {
    
    // 设置 dynamicView 的 frame
    self.dynamicView.frame = CGRectMake(0, self.staticView.frame.size.height + self.staticView.frame.origin.y, dynamicSize.width, dynamicSize.height);
    
    // 设置 ScrollView 的 contentSize
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.dynamicView.frame.origin.y + self.dynamicView.frame.size.height);

    if (!self.scrollView.footer) {
        self.scrollView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downloadMoreData)];
    }
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        // 滚动视图
        _scrollView                 = [[UIScrollView alloc] init];
        _scrollView.delegate        = self;
        _scrollView.backgroundColor = BACKGROUND_COLOR;
        
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downloadData)];
        
        // 加载静态视图
        [_scrollView addSubview:self.staticView];
        
        // 加载动态视图
        [_scrollView addSubview:self.dynamicView];
        
        _active = YES;
    }
    return _scrollView;
}

- (UIButton *)toTopButton {
    if (_toTopButton == nil) {
        _toTopButton = [[UIButton alloc] init];
        [_toTopButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
        [_toTopButton setImage:[UIImage imageNamed:@"ToTop"] forState:UIControlStateNormal];
        _toTopButton.hidden = YES;
        _toTopButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _toTopButton;
}

- (UISearchController *)searchController {
    if (_searchController == nil) {
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
    }
    return _searchController;
}

- (UIBarButtonItem *)scanButton {
    if (_scanButton == nil) {
        _scanButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ScanQRCode"] style:UIBarButtonItemStylePlain target:self action:@selector(scanQRCode)];
        _scanButton.tintColor = [UIColor whiteColor];
    }
    return _scanButton;
}

- (XSNavigationBarHelper *)navHelper {
    if (_navHelper == nil) {
        _navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
        [_navHelper peek];
    }
    return _navHelper;
}

- (XSSearchTableViewController *)searchTableViewController {
    if (_searchTableViewController == nil) {
        _searchTableViewController = [[XSSearchTableViewController alloc] init];
        _searchTableViewController.searchBar = _searchController.searchBar;
        _searchTableViewController.contextViewController = self;
        
        _searchController.searchBar.showsCancelButton = YES;
        UIView *firstView = _searchController.searchBar.subviews[0];
        for (UIView *secondView in firstView.subviews) {
            if ([secondView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
                UIButton *cancelButton = (UIButton *)secondView;
                cancelButton.tintColor = [UIColor lightGrayColor];
            }
        }
    }
    return _searchTableViewController;
}

- (UIView *)staticView {
    if (_staticView == nil) {
        _staticView = [[UIView alloc] init];
        [_staticView addSubview:self.bannerView];
        [_staticView addSubview:self.buttonGridView];
    }
    return _staticView;
}

- (XSBannerView *)bannerView {
    if (_bannerView == nil) {
        _bannerView = [[XSBannerView alloc] init];
        _bannerView.animationSwitch = YES;
    }
    
    return _bannerView;
}

- (XSButtonGridView *)buttonGridView {
    if (_buttonGridView == nil) {
        _buttonGridView = [[XSButtonGridView alloc] init];
        _buttonGridView.backgroundColor = [UIColor whiteColor];
        
        [_buttonGridView.button1 addTarget:self action:@selector(freshFood) forControlEvents:UIControlEventTouchUpInside];
        [_buttonGridView.button7 addTarget:self action:@selector(nearBy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonGridView;
}

- (UIView *)dynamicView {
    if (_dynamicView == nil) {
        _dynamicView = [[UIView alloc] init];
    }
    return _dynamicView;
}

- (void)setHomeDataModel:(HomeDataModel *)homeDataModel {
    // 清空所有子视图
    [self.dynamicView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    _homeDataModel = homeDataModel;
    
    [self generateDynamicSubview];
}

@end
