//
//  XSSettingViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/21.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSettingViewController.h"

#import "XSNavigationBarHelper.h"

#import "ThemeColor.h"

#import "XSAboutSettingTableViewCell.h"
#import "XSShareSettingTableViewCell.h"
#import "XSClearSettingTableViewCell.h"

#import "XSAboutUsViewController.h"

static NSString * const aboutID = @"about";
static NSString * const shareID = @"share";
static NSString * const clearID = @"clear";

@interface XSSettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *logoutButton;
@end

@implementation XSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 64 - 49);
    
    self.logoutButton.frame = CGRectMake(0, self.tableView.frame.origin.y + self.tableView.frame.size.height, self.tableView.frame.size.width, 49);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:aboutID forIndexPath:indexPath];
            cell.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
            cell.layer.borderWidth = 0.5f;
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:shareID forIndexPath:indexPath];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:clearID forIndexPath:indexPath];
            cell.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
            cell.layer.borderWidth = 0.5f;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[XSAboutUsViewController alloc] init] animated:YES];
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"设置";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)logout {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.bounces    = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.separatorColor  = [UIColor clearColor];
        
        [_tableView registerClass:[XSAboutSettingTableViewCell class] forCellReuseIdentifier:aboutID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSAboutSettingTableViewCell" bundle:nil] forCellReuseIdentifier:aboutID];
        
        [_tableView registerClass:[XSShareSettingTableViewCell class] forCellReuseIdentifier:shareID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSShareSettingTableViewCell" bundle:nil] forCellReuseIdentifier:shareID];
        
        [_tableView registerClass:[XSClearSettingTableViewCell class] forCellReuseIdentifier:clearID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSClearSettingTableViewCell" bundle:nil] forCellReuseIdentifier:clearID];
    }
    return _tableView;
}

- (UIButton *)logoutButton {
    if (_logoutButton == nil) {
        _logoutButton = [[UIButton alloc] init];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        _logoutButton.backgroundColor = THEME_RED;
        _logoutButton.tintColor = [UIColor whiteColor];
        [_logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

@end
