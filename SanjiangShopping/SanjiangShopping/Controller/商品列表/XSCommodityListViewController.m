//
//  XSCommodityListViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/9.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityListViewController.h"

#import "XSCommodityViewController.h"

#import "XSResultTableViewController.h"
#import "XSSearchBarHelper.h"
#import "XSNavigationBarHelper.h"

#import "XSFilterViewController.h"

#import "XSCommodityListTableViewCell.h"

#import "UtilsMacro.h"

#import <AFNetworking.h>
#import "NetworkConstant.h"
#import "CommodityListModel.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>

#import "ThemeColor.h"

static NSString * const cellID = @"commodityList";

@interface XSCommodityListViewController () <XSSegmentControlDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray   *segmentArr;
@property (strong, nonatomic) UITableView      *tableView;

@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;

@property (strong, nonatomic) CommodityListModel *commodityListModel;

@property (strong, nonatomic) XSFilterViewController *filterController;

@end

@implementation XSCommodityListViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    [self loadSearchBar];
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tabBarController.tabBar.hidden = YES;
    self.definesPresentationContext     = YES;
    self.searchController.active        = NO;
    
    self.segmentControl.selectedIndex = 0;
    
    CGFloat x = 0;
    CGFloat y = self.segmentControl.frame.origin.y + self.segmentControl.frame.size.height;
    CGFloat width  = self.segmentControl.frame.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - y;
    self.tableView.frame = CGRectMake(x, y, width, height);
    
    [self reloadDataWithQuery:@"1"];
}

#pragma mark - prviate methods
- (void)customNavigationBar {
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reloadDataWithQuery:(NSString *)query {
    __weak typeof(self) weakSelf = self;
    [self.commodityListModel loadCommodityListWithQueryFormat:query Success:^{
        [weakSelf.tableView reloadData];
    } Failure:nil];
}

- (void)loadSearchBar {
    NSString *keyword = _searchWords;
    if (keyword == nil) {
        keyword = @"搜索商品名称/商品编号";
        [XSSearchBarHelper hackStandardSearchBar:self.searchController.searchBar keyword:keyword];
    } else {
        self.searchController.searchBar.text = keyword;
    }
    
    self.navigationItem.titleView = _searchController.searchBar;
}

#pragma mark - XSSegmentControlDelegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    
    if (item.tag == 3) {
        
        if (![self.view.subviews containsObject:self.filterController.view]) {
            [self.view addSubview:self.filterController.view];
            self.filterController.view.frame = CGRectMake(self.tableView.frame.origin.x + self.tableView.frame.size.width, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
            [UIView animateWithDuration:0.4 animations:^{
                self.filterController.view.frame = self.tableView.frame;
            }];
        }
        
        return;
    }
    
    if (_filterController != nil) {
        [UIView animateWithDuration:0.4 animations:^{
            self.filterController.view.frame = CGRectMake(self.tableView.frame.origin.x + self.tableView.frame.size.width, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height);
        } completion:^(BOOL finished) {
            [self.filterController.view removeFromSuperview];
            self.filterController = nil;
        }];
    }
    
    [self reloadDataWithQuery:[NSString stringWithFormat:@"%ld", (long)item.tag % 3 + 1]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commodityListModel.data.list.count;
}

- (XSCommodityListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSCommodityListTableViewCell *cell = (XSCommodityListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    CommodityListItemModel *item = self.commodityListModel.data.list[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BACKGROUND_COLOR;
    
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:item.img]];
    cell.name.text = item.name;
    cell.pn.text = [NSString stringWithFormat:@"￥%@", item.pn];
    cell.rate.text = [NSString stringWithFormat:@"好评率%@%%", item.rate];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XSCommodityViewController *viewController = [[XSCommodityViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - getters and setters
- (XSSegmentControl *)segmentControl {
    if (_segmentControl == nil) {
        NSArray *segmentTitles = @[@"综合排序", @"销量", @"价格", @"筛选"];
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
        _segmentControl.titles = segmentTitles;
        _segmentControl.delegate = self;
        _segmentControl.selectedIndex = 0;
        _segmentControl.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        _segmentControl.layer.borderWidth = 1.0f;
    }
    return _segmentControl;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.backgroundColor = OTHER_SEPARATOR_COLOR;
        
        [_tableView registerClass:[XSCommodityListTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSCommodityListTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (CommodityListModel *)commodityListModel {
    if (_commodityListModel == nil) {
        _commodityListModel = [[CommodityListModel alloc] init];
    }
    return _commodityListModel;
}

- (XSResultTableViewController *)resultTableViewController {
    if (_resultTableViewController == nil) {
        _resultTableViewController = [[XSResultTableViewController alloc] init];
    }
    return _resultTableViewController;
}

- (XSSearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[XSSearchController alloc] initWithSearchResultsController:self.resultTableViewController];
        
        __weak typeof(self) weakSelf = self;
        _searchController.searchWordQuery = ^(NSString *searchWord) {
            
            if ([weakSelf isKindOfClass:[XSCommodityListViewController class]]) {
                XSCommodityListViewController *lvc = (XSCommodityListViewController *)weakSelf;
                [lvc searchController].active = NO;
                lvc.searchWords = searchWord;
                [lvc reloadDataWithQuery:@"1"];
            } else {
                XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
                comListViewController.searchWords = searchWord;
                weakSelf.definesPresentationContext = NO;
                [weakSelf.navigationController pushViewController:comListViewController animated:YES];
            }
        };
        
        _searchController.willPresentSearchBlock = ^(UISearchController *searchController) {
            weakSelf.navigationItem.hidesBackButton = YES;
            weakSelf.navigationItem.leftBarButtonItem = nil;
        };
        
        _searchController.willDismissSearchBlock = ^(UISearchController *searchController) {
            [UIView animateWithDuration:0.4 animations:^{
                UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:weakSelf action:@selector(comeBack)];
                leftButtonItem.tintColor = MAIN_TITLE_COLOR;
                weakSelf.navigationItem.leftBarButtonItem = leftButtonItem;
                weakSelf.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)weakSelf;
            }];
        };
    }
    return _searchController;
}

- (XSFilterViewController *)filterController {
    if (_filterController == nil) {
        _filterController = [[XSFilterViewController alloc] init];
    }
    return _filterController;
}

@end
