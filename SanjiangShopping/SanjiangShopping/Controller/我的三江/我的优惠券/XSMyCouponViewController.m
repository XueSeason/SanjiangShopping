//
//  XSMyCouponViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyCouponViewController.h"
#import "XSMyCouponTableViewCell.h"
#import "XSCouponInfoViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const cellID = @"cell";

@interface XSMyCouponViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation XSMyCouponViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMyCouponTableViewCell *cell = (XSMyCouponTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[XSCouponInfoViewController alloc] init] animated:YES];
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"我的优惠券";
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
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[XSMyCouponTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSMyCouponTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end
