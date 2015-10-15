//
//  XSNearByViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/10.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSNearByViewController.h"

#import "ThemeColor.h"
#import "XSNavigationBarHelper.h"
#import <UIImageView+WebCache.h>

#import "XSNearbyTableViewCell.h"
#import "XSMarketViewController.h"

static NSString * const headID   = @"head";
static NSString * const nearbyID = @"nearby";

@interface XSNearByViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) XSNavigationBarHelper *navHelper;
@end

@implementation XSNearByViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self scrollViewDidScroll:_tableView];
    self.navHelper.UIImageView.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"身边三江";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    self.navHelper._UINavigationBarBackground.backgroundColor = THEME_TRANSPARENT;
    self.navHelper._UIBackdropEffectView.hidden = YES;
    self.navHelper.UIImageView.hidden = YES; // 去除UIImageView带来的线框
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) style:UITableViewStyleGrouped];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator   = NO;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:headID];
    [_tableView registerClass:[XSNearbyTableViewCell class] forCellReuseIdentifier:nearbyID];
    [_tableView registerNib:[UINib nibWithNibName:@"XSNearbyTableViewCell" bundle:nil] forCellReuseIdentifier:nearbyID];
    
    [self.view addSubview:_tableView];
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (XSNavigationBarHelper *)navHelper {
    if (_navHelper == nil) {
        _navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
        [_navHelper peek];
    }
    return _navHelper;
}

#pragma mark - Table View DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headID forIndexPath:indexPath];
        cell.selectionStyle   = UITableViewCellSelectionStyleNone;
        UIImageView *backgroundView = [[UIImageView alloc] init];
        [backgroundView sd_setImageWithURL:[NSURL URLWithString:@"https://gw.alicdn.com/tps/TB1EBwsJFXXXXcVXpXXXXXXXXXX-750-291.jpg_Q90.jpg"]];
        cell.backgroundView = backgroundView;
        return cell;
    }
    
    XSNearbyTableViewCell *cell = (XSNearbyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:nearbyID forIndexPath:indexPath];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - Table View Deleagete
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.section == 0 && indexPath.row == 0)) {
        XSMarketViewController *mvc = [[XSMarketViewController alloc] init];
        [self.navigationController pushViewController:mvc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 200;
    } else {
        return 70.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 44.0;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *nearView = [[[NSBundle mainBundle] loadNibNamed:@"NearbyView" owner:self options:nil] objectAtIndex:0];
        return nearView;
    }
    return nil;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat offset = _tableView.contentOffset.y;
    if (offset < 100.0) {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(offset / 100.0);
    } else {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_FADE(1.0);
    }
}

@end
