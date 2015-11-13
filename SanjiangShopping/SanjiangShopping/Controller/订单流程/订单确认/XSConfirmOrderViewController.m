//
//  XSConfirmOrderViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/9.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSConfirmOrderViewController.h"
#import "XSNavigationBarHelper.h"

#import "ThemeColor.h"

#import "XSAddressSelectedTableViewCell.h"
#import "XSPayOptionTableViewCell.h"
#import "XSCouponOptionTableViewCell.h"
#import "XSSummaryTableViewCell.h"
#import "XSItemListTableViewCell.h"

#import "XSOrderCompletedViewController.h"
#import "XSSelectCouponViewController.h"

static NSString * const addressID   = @"address";
static NSString * const payID       = @"pay";
static NSString * const couponID    = @"coupon";
static NSString * const summaryID   = @"summary";
static NSString * const listID      = @"list";

@interface XSConfirmOrderViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *submitOrderView;
@end

@implementation XSConfirmOrderViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customeNavigationBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitOrderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - events response
- (IBAction)submitOrder:(UIButton *)sender {
    XSOrderCompletedViewController *ovc = [[XSOrderCompletedViewController alloc] init];
    [self.navigationController pushViewController:ovc animated:YES];
}

#pragma mark - private methods
- (void)customeNavigationBar {
    self.navigationItem.title = @"确认订单";
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
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:listID];
        
        [_tableView registerClass:[XSAddressSelectedTableViewCell class] forCellReuseIdentifier:addressID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSAddressSelectedTableViewCell" bundle:nil] forCellReuseIdentifier:addressID];
        [_tableView registerClass:[XSPayOptionTableViewCell class] forCellReuseIdentifier:payID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSPayOptionTableViewCell" bundle:nil] forCellReuseIdentifier:payID];
        [_tableView registerClass:[XSCouponOptionTableViewCell class] forCellReuseIdentifier:couponID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSCouponOptionTableViewCell" bundle:nil] forCellReuseIdentifier:couponID];
        [_tableView registerClass:[XSSummaryTableViewCell class] forCellReuseIdentifier:summaryID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSSummaryTableViewCell" bundle:nil] forCellReuseIdentifier:summaryID];
        [_tableView registerClass:[XSItemListTableViewCell class] forCellReuseIdentifier:listID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSItemListTableViewCell" bundle:nil] forCellReuseIdentifier:listID];
    }
    return _tableView;
}

- (UIView *)submitOrderView {
    if (_submitOrderView == nil) {
        _submitOrderView = [[[NSBundle mainBundle] loadNibNamed:@"SubmitOrderView" owner:self options:nil] objectAtIndex:0];
        _submitOrderView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        _submitOrderView.layer.borderWidth = 0.5f;
        _submitOrderView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return _submitOrderView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        // 后期改
        return 5;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XSAddressSelectedTableViewCell *cell = (XSAddressSelectedTableViewCell *)[tableView dequeueReusableCellWithIdentifier:addressID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 1) {
        XSPayOptionTableViewCell *cell = (XSPayOptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:payID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 2) {
        XSCouponOptionTableViewCell *cell = (XSCouponOptionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:couponID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        XSSummaryTableViewCell *cell = (XSSummaryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:summaryID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 4) {
        XSItemListTableViewCell *cell = (XSItemListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:listID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        return nil;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        [self.navigationController pushViewController:[[XSSelectCouponViewController alloc] init] animated:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 76.0;
    } else if (indexPath.section == 1) {
        return 135.0;
    } else if (indexPath.section == 2) {
        return 50;
    } else if (indexPath.section == 3) {
        return 124.0;
    } else if (indexPath.section == 4) {
        return 85.0;
    } else {
        return 0.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
