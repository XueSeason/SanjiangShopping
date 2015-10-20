//
//  XSMyOrderViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyOrderViewController.h"
#import "XSSegmentControl.h"
#import "XSOrderTableViewCell.h"
#import "XSOrderHeaderTableViewCell.h"
#import "XSOrderFooterTableViewCell.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const headerID = @"header";
static NSString * const cellID = @"order";
static NSString * const footerID = @"footer";

@interface XSMyOrderViewController () <UITableViewDataSource, UITableViewDelegate, XSSegmentControlDelegate>

@property (strong, nonatomic) XSSegmentControl *segmentControl;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation XSMyOrderViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    CGFloat y = self.segmentControl.frame.origin.y + self.segmentControl.frame.size.height;
    self.tableView.frame = CGRectMake(0, y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - y);
}

#pragma mark - XSSegmentControlDelegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSOrderTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = (XSOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:headerID forIndexPath:indexPath];
        cell.backgroundColor = BACKGROUND_COLOR;
    } else if (indexPath.row == 3 - 1) {
        cell = (XSOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:footerID forIndexPath:indexPath];
        cell.layer.borderWidth = 0.5f;
        cell.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    } else {
        cell = (XSOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        cell.layer.borderWidth = 0.5f;
        cell.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 51.0;
    } else if (indexPath.row == 3 - 1) {
        return 41.0;
    } else {
        return 86.0;
    }
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"我的订单";
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
- (XSSegmentControl *)segmentControl {
    if (_segmentControl == nil) {
        NSArray *segmentTitles = @[@"全部", @"已完成", @"待收货", @"待评价"];
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 50)];
        _segmentControl.titles = segmentTitles;
        _segmentControl.delegate = self;
        _segmentControl.hasLine = YES;
        _segmentControl.selectedIndex = 0;
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.layer.borderColor = [BACKGROUND_COLOR CGColor];
        _segmentControl.layer.borderWidth = 1.0f;
    }
    return _segmentControl;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        [_tableView registerClass:[XSOrderTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSOrderTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        
        [_tableView registerClass:[XSOrderHeaderTableViewCell class] forCellReuseIdentifier:headerID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSOrderHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:headerID];
        
        [_tableView registerClass:[XSOrderFooterTableViewCell class] forCellReuseIdentifier:footerID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSOrderFooterTableViewCell" bundle:nil] forCellReuseIdentifier:footerID];
    }
    return _tableView;
}


@end
