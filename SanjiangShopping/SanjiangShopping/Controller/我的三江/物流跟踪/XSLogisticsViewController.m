//
//  XSLogisticsViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//


#import "XSLogisticsViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

#import "XSLogisticsTableViewCell.h"

static NSString * const cellID = @"cell";

@interface XSLogisticsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation XSLogisticsViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    
    [self.view addSubview:self.tableView];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.infoView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.infoView.layer.borderWidth = 0.5f;
    
    CGFloat y = self.infoView.frame.size.height + self.infoView.frame.origin.y;
    self.tableView.frame = CGRectMake(0, y, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - y);
}

#pragma mark - UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSLogisticsTableViewCell *cell = (XSLogisticsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.topLineView.hidden = YES;
        cell.logoImageView.image = [UIImage imageNamed:@"logistics"];
        cell.detailLabel.textColor = [UIColor colorWithRed:70.0 / 255.0 green:177.0 / 255.0 blue:21.0 / 255.0 alpha:1.0];
        cell.timeLabel.textColor = cell.detailLabel.textColor;
    } else if (indexPath.row == 4) {
        cell.bottomLineView.hidden = YES;
    }
    
    cell.logoImageView.layer.cornerRadius = cell.logoImageView.frame.size.width / 2.0;
    cell.logoImageView.clipsToBounds = YES;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61.0;
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"物流跟踪";
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
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        _tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[XSLogisticsTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSLogisticsTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


@end

