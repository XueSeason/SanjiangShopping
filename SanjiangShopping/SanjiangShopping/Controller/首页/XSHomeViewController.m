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

#import "XSBannerView.h"
#import "XSButtonGridView.h"

#import "XSFreshFoodViewController.h"
#import "XSNearByViewController.h"
#import "XSBuyNowViewController.h"
#import "XSCommodityListViewController.h"

#import "XS4211View.h"
#import "XS1111GrayView.h"
#import "XS1111WhiteView.h"
#import "XSScrollView.h"
#import "XSBuyNowView.h"
#import "XSThemeView.h"
#import "XSMoreView.h"

#import <MJRefresh.h>
#import "HomeModel.h"
#import "HomeMoreModel.h"
#import "NotificationNameConstant.h"

#import "XSSearchController.h"
#import "XSResultTableViewController.h"

#import <MBProgressHUD.h>

static const CGFloat step = 9.0f;

@interface XSHomeViewController () <UIScrollViewDelegate>
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

// other property
@property (strong, nonatomic) XSNavigationBarHelper *navHelper;

// search controller
@property (strong, nonatomic) XSSearchController *searchController;
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
    
    [self downloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self transparentizeNavigationBar];
    [self adjustView];
    
    self.definesPresentationContext = YES;
    
    self.scrollView.frame        = self.view.bounds;
    self.staticView.frame        = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 375.0 * 379.0);
    self.bannerView.frame        = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width / 25 * 14);
    self.buttonGridView.frame    = CGRectMake(0, self.bannerView.frame.size.height + self.bannerView.frame.origin.y, self.view.frame.size.width, self.view.frame.size.width / 750 * 338);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(==44)]-8-|" options:0 metrics:nil views:@{@"button": self.toTopButton}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button(==44)]-57-|" options:0 metrics:nil views:@{@"button": self.toTopButton}]];
    [self.toTopButton layoutIfNeeded];
    self.toTopButton.layer.cornerRadius = self.toTopButton.frame.size.width / 2.0;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navHelper._UINavigationBarBackground.opaque = YES;
    self.scrollView.mj_footer = nil;
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

- (void)downloadData {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.homeModel loadHomeSuccess:^{        
        [weakSelf refreshView];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:weakSelf.homeModel.data.keyword forKey:@"hotWord"];
        [defaults synchronize];
        
        [weakSelf refreshView];
        [weakSelf.scrollView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    } Failure:^(NSError *error) {
        [weakSelf.scrollView.mj_header endRefreshing];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

- (void)downloadMoreData {
    __weak typeof(self) weakSelf = self;
    [self.homeMoreMedel loadHomeMoreSuccess:^{
        [weakSelf generateMoreView:weakSelf.homeMoreMedel.data.list];
        
        [weakSelf refreshDynamicView];
        
        [weakSelf.scrollView.mj_footer endRefreshing];
    } Failure:^(NSError *error) {
        [weakSelf.scrollView.mj_footer endRefreshingWithNoMoreData];
    }];
}

- (void)refreshView {
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.staticView.frame.origin.y + self.staticView.frame.size.height);
    
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

    if (!self.scrollView.mj_footer) {
        self.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(downloadMoreData)];
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
        _scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(downloadData)];
        
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

- (XSSearchController *)searchController {
    if (_searchController == nil) {
        _resultTableViewController = [[XSResultTableViewController alloc] init];
        _searchController = [[XSSearchController alloc] initWithSearchResultsController:self.resultTableViewController];

        __weak typeof(self) weakSelf = self;
        _searchController.searchWordQuery = ^(NSString *searchWord) {
            
            if ([weakSelf isKindOfClass:[XSCommodityListViewController class]]) {
                XSCommodityListViewController *lvc = (XSCommodityListViewController *)weakSelf;
                [lvc searchController].active = NO;
                lvc.searchWords = searchWord;
                [lvc reloadDataWithQuery:@"1"];
            } else {
                XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
                comListViewController.searchWords = searchWord;
                weakSelf.definesPresentationContext = NO;
                [weakSelf.navigationController pushViewController:comListViewController animated:YES];
            }
        };
        
        _searchController.presentSearchBlock = ^(UISearchController *searchController) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        
            weakSelf.active = NO;
            weakSelf.navHelper._UINavigationBarBackground.backgroundColor = [UIColor whiteColor];
        };
        
        _searchController.willPresentSearchBlock = ^(UISearchController *searchController) {
            weakSelf.navHelper.UIImageView.hidden = NO; // 显示UIImageView带来的线框
        };
        
        _searchController.didDismissSearchBlock = ^(UISearchController *searchController) {
            weakSelf.active = YES;
            CGFloat offset = weakSelf.scrollView.contentOffset.y;
            if (offset < 216.75) {
                weakSelf.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(offset / 255.0);
            } else {
                weakSelf.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(0.85);
            }
            
            weakSelf.navHelper.UIImageView.hidden = YES; // 隐藏UIImageView带来的线框
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        };
    }
    return _searchController;
}

- (XSResultTableViewController *)resultTableViewController {
    if (_resultTableViewController == nil) {
        _resultTableViewController = [[XSResultTableViewController alloc] init];
    }
    return _resultTableViewController;
}

- (XSNavigationBarHelper *)navHelper {
    if (_navHelper == nil) {
        _navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
        [_navHelper peek];
    }
    return _navHelper;
}

- (UIView *)staticView {
    if (_staticView == nil) {
        _staticView = [[UIView alloc] init];
        _staticView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        _staticView.layer.borderWidth = 0.5f;
        _scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, self.tabBarController.tabBar.frame.size.height, 0.0f);
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

- (HomeModel *)homeModel {
    if (_homeModel == nil) {
        _homeModel = [[HomeModel alloc] init];
    }
    return _homeModel;
}

- (HomeMoreModel *)homeMoreMedel {
    if (_homeMoreMedel == nil) {
        _homeMoreMedel = [[HomeMoreModel alloc] init];
    }
    return _homeMoreMedel;
}

@end
