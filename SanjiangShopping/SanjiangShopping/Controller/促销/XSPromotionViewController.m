//
//  XSPromotionViewController.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSPromotionViewController.h"

#import "XSPromotionDataSource.h"
#import "XSPromotionCell.h"
#import "PromotionModel.h"

#import "XSNavigationBarHelper.h"
#import "XSCommodityListViewController.h"

#import <MJRefresh.h>

static NSString * const promotionCellID = @"promotion";

@interface XSPromotionViewController () <UITableViewDelegate>

@property (strong, nonatomic) PromotionModel *promotion;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) XSPromotionDataSource *promotionDataSource;

@end

@implementation XSPromotionViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabBarController.tabBar.hidden = NO;
    self.tableView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动促销";
    [XSNavigationBarHelper hackPlainNavigationBar:self.navigationController.navigationBar];
    [self.view addSubview:self.tableView];
    
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
    __weak typeof(self) weakSelf = self;

    [self.promotion loadPromotionSuccess:^{
        weakSelf.promotionDataSource.items = weakSelf.promotion.data.list;
        
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.header endRefreshing];
    } Failure:^(NSError *error) {
        [weakSelf.tableView.header endRefreshing];
    }];
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ([UIScreen mainScreen].bounds.size.width - 16) / 72 * 25;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[[XSCommodityListViewController alloc] init] animated:YES];
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        
        [_tableView registerClass:[XSPromotionCell class] forCellReuseIdentifier:promotionCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSPromotionCell" bundle:nil] forCellReuseIdentifier:promotionCellID];
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadPromotionData)];
        _tableView.separatorColor = [UIColor clearColor];
        
        _tableView.delegate   = self;
        _tableView.dataSource = self.promotionDataSource;
    }
    return _tableView;
}

- (XSPromotionDataSource *)promotionDataSource {
    if (_promotionDataSource == nil) {
        _promotionDataSource = [[XSPromotionDataSource alloc] initWithItems:self.promotion.data.list cellIdentifier:promotionCellID configureCellBlock:^(XSPromotionCell *cell, PromotionItemModel *item) {
            [cell configureForPromotionItem:item];
        }];
    }
    return _promotionDataSource;
}

- (PromotionModel *)promotion {
    if (_promotion == nil) {
        _promotion = [[PromotionModel alloc] init];
    }
    return _promotion;
}

@end
