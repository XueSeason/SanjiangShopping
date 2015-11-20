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
#import "XSExchangeCouponViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const cellID = @"cell";

@interface XSMyCouponViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIButton *codeButton;

@end

@implementation XSMyCouponViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    
    [self.view addSubview:self.codeButton];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.codeButton.frame = CGRectMake(8, 64 + 8, CGRectGetWidth(self.view.bounds) - 16, 44);
    CGFloat y = self.codeButton.frame.origin.y + self.codeButton.frame.size.height;
    self.tableView.frame  = CGRectMake(8, y + 8, CGRectGetWidth(self.view.bounds) - 16, CGRectGetHeight(self.view.bounds) - y - 8);
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

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"我的优惠券";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"使用说明" style:UIBarButtonItemStylePlain target:self action:@selector(useDetail)];
    rightButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [rightButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)useDetail {
    [self.navigationController pushViewController:[[XSCouponInfoViewController alloc] init] animated:YES];
}

- (void)exchangeCoupon {
    [self.navigationController pushViewController:[[XSExchangeCouponViewController alloc] init] animated:YES];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.tableFooterView = [UIView new];
        
        [_tableView registerClass:[XSMyCouponTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSMyCouponTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UIButton *)codeButton {
    if (_codeButton == nil) {
        _codeButton = [[UIButton alloc] init];
        [_codeButton setTitle:@"优惠码兑换" forState:UIControlStateNormal];
        [_codeButton setTitleColor:THEME_RED forState:UIControlStateNormal];
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _codeButton.layer.borderWidth = 0.5f;
        _codeButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _codeButton.layer.cornerRadius = 5.0;
        _codeButton.clipsToBounds = YES;
        
        [_codeButton addTarget:self action:@selector(exchangeCoupon) forControlEvents:UIControlEventTouchUpInside];
    }
    return _codeButton;
}

@end
