//
//  XSSelectCouponViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/13/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSelectCouponViewController.h"
#import "XSMyCouponTableViewCell.h"
#import "XSSegmentControl.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const cellID = @"coupon";

@interface XSSelectCouponViewController () <UITableViewDataSource, UITableViewDelegate, XSSegmentControlDelegate>

@property (strong, nonatomic) XSSegmentControl *segmentControl;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation XSSelectCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self customeNavigationBar];
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat y = self.segmentControl.frame.origin.y + self.segmentControl.frame.size.height;
    self.tableView.frame = CGRectMake(0, y, self.segmentControl.frame.size.width, [UIScreen mainScreen].bounds.size.height - y);
}

#pragma mark - private methods
- (void)customeNavigationBar {
    self.navigationItem.title = @"优惠券";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
    [rightButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)confirm {
    
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - XSSegmentControlDelegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMyCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:[XSMyCouponTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSMyCouponTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (XSSegmentControl *)segmentControl {
    if (_segmentControl == nil) {
        NSArray *segmentTitles = @[@"可使用券(4)", @"不可使用券(5)"];
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 64 + 20, [UIScreen mainScreen].bounds.size.width, 44)];
        _segmentControl.titles = segmentTitles;
        _segmentControl.hasLine  = YES;
        _segmentControl.delegate = self;
        _segmentControl.selectedIndex = 0;
        _segmentControl.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        _segmentControl.layer.borderWidth = 1.0f;
        _segmentControl.backgroundColor = [UIColor whiteColor];
    }
    return _segmentControl;
}

@end
