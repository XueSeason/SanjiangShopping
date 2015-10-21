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
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 64);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMyCouponTableViewCell *cell = (XSMyCouponTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([cell.typeLabel.text isEqualToString:@"满减券"]) {
        cell.typeLabel.textColor = [UIColor colorWithRed:86.0 / 255.0 green:176.0 / 255.0 blue:245.0 / 255.0 alpha:1.0];
        cell.bgImageView.image = [UIImage imageNamed:@"blueCoupon"];
    } else if([cell.typeLabel.text isEqualToString:@"现金券"]) {
        cell.typeLabel.textColor = [UIColor colorWithRed:242.0 / 255.0 green:167.0 / 255.0 blue:48.0 / 255.0 alpha:1.0];
        cell.bgImageView.image = [UIImage imageNamed:@"orangeCoupon"];
    }
    
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
