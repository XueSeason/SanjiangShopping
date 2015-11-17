//
//  XSBuyNowViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/2/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSBuyNowViewController.h"

#import "XSBuyNowTableViewHeader.h"
#import "XSBuyNowTableViewCell.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const cellID = @"buynow";

@interface XSBuyNowViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation XSBuyNowViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];

    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    self.automaticallyAdjustsScrollViewInsets     = NO;
    
    self.tableView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSBuyNowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125.0;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XSBuyNowTableViewHeader *header = [[XSBuyNowTableViewHeader alloc] init];
    header.timeLabel.text = @"10-12点";
    header.descLabel.text = @"疯抢中";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 40.0;
    } else {
        return 0.0;
    }
}

#pragma mark - private method
- (void)customNavigationBar {
    self.navigationItem.title = @"今日秒杀";
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"秒杀说明" style:UIBarButtonItemStylePlain target:self action:@selector(buyNowDetail)];
    [rightButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buyNowDetail {
    
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor  = [UIColor clearColor];
        _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[XSBuyNowTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSBuyNowTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end
