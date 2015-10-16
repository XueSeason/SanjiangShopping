//
//  XSPromotionViewController.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSPromotionViewController.h"

#import "XSNavigationBarHelper.h"

#import "AppMacro.h"

#import "NetworkConstant.h"
#import <AFNetworking.h>
#import "PromotionModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import <MJRefresh.h>

#import "XSPromotionCell.h"

#import "XSCommodityListViewController.h"

static NSString * const promotionCellID = @"promotion";

@interface XSPromotionViewController ()

@property (strong, nonatomic) PromotionDataModel *data;

@end

@implementation XSPromotionViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"活动促销";
    [XSNavigationBarHelper hackPlainNavigationBar:self.navigationController.navigationBar];
    
    [self.tableView registerClass:[XSPromotionCell class] forCellReuseIdentifier:promotionCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XSPromotionCell" bundle:nil] forCellReuseIdentifier:promotionCellID];
    
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator   = NO;
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadPromotionData)];
    self.tableView.separatorColor = [UIColor clearColor];
    [self loadPromotionData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark - private methods
- (void)loadPromotionData {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_PROMOTION];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        weakSelf.data = [PromotionModel objectWithKeyValues:responseObject].data;
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.header endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [weakSelf.tableView.header endRefreshing];
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSPromotionCell *cell = (XSPromotionCell *)[tableView dequeueReusableCellWithIdentifier:promotionCellID forIndexPath:indexPath];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:[self.data.list[indexPath.row] img]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.picture.layer.cornerRadius = 10;
    cell.picture.clipsToBounds = YES;
    return cell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([UIScreen mainScreen].bounds.size.width - 16) / 72 * 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[XSCommodityListViewController alloc] init] animated:YES];
}

@end
