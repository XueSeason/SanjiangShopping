//
//  XSSearchController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/6/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSearchController.h"

#import "XSSearchBarHelper.h"

#import "XSResultTableViewController.h"

#import "XSNavigationBarHelper.h"

#import <MJExtension.h>
#import "HotWordsModel.h"

#import <AFNetworking.h>
#import "NetworkConstant.h"

#import "ThemeColor.h"

#import "XSClearHistoryTableViewCell.h"

#import "XSCommodityListViewController.h"

static NSString * const recentID = @"recent";
static NSString * const clearID  = @"clear";

@implementation NSMutableArray (add)

- (void)addUniqueString:(NSString *)str {
    for (NSString *temp in self) {
        if ([temp isEqualToString:str]) {
            return;
        }
    }
    [self addObject:str];
}

@end

@interface XSSearchController () <UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;

@property (strong, nonatomic) NSMutableArray   *recentSearchData;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UIView *hotWordsView;
@property (strong, nonatomic) HotWordsDataModel *dataModel;

@end

@implementation XSSearchController

- (instancetype)initWithSearchResultsController:(XSResultTableViewController *)searchResultsController {
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {
        self.resultTableViewController = searchResultsController;
        self.searchBar.searchBarStyle  = UISearchBarStyleMinimal;
    }
    return self;
}

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setKeyWord];
    
    self.tableView.frame = [UIScreen mainScreen].bounds;
    
    [self loadHotWords];
    [self loadHistoryRecord];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidesNavigationBarDuringPresentation = NO;
    self.dimsBackgroundDuringPresentation     = NO;
   
    self.delegate             = self;
    self.searchResultsUpdater = self;
    self.searchBar.delegate   = self;
    
    [self loadHotWordsView];
    self.hotWordsView.backgroundColor = BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
}

- (void)hotWordsClick:(UIButton *)sender {
    [_recentSearchData addUniqueString:[sender.titleLabel.text copy]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_recentSearchData forKey:@"histroyRecord"];
    [defaults synchronize];
    
//    if ([self.contextViewController isKindOfClass:[XSCommodityListViewController class]]) {
//        XSCommodityListViewController *lvc = (XSCommodityListViewController *)_contextViewController;
//        [lvc searchController].active = NO;
//        lvc.searchWords = sender.titleLabel.text;
//        [lvc reloadData];
//    } else {
//        XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
//        comListViewController.searchWords = sender.titleLabel.text;
//        self.contextViewController.definesPresentationContext = NO;
//        [self.contextViewController.navigationController pushViewController:comListViewController animated:YES];
//    }
    
    [self.tableView reloadData];
}

#pragma mark - Hot Words View
- (void)loadHotWordsView {
    if (_hotWordsView.subviews.count != 0) {
        [_hotWordsView.subviews[0] removeFromSuperview];
    }
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(_hotWordsView.frame.origin.x, _hotWordsView.frame.origin.y, _hotWordsView.frame.size.width, _hotWordsView.frame.size.height - 8);
    scrollView.backgroundColor                = OTHER_SEPARATOR_COLOR;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator   = NO;
    
    UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 44, 28)];
    label.text          = @"热搜";
    label.textColor     = THEME_RED;
    label.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:label];
    
    CGFloat x = label.frame.origin.x + label.frame.size.width + 8;
    for (int i = 0; i < _dataModel.list.count; i++) {
        UIButton *hotButton = [[UIButton alloc] init];
        [hotButton setTitle:_dataModel.list[i] forState:UIControlStateNormal];
        [hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        hotButton.titleLabel.font = [hotButton.titleLabel.font fontWithSize:12.0];
        hotButton.backgroundColor = [UIColor whiteColor];
        hotButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        CGSize buttonSize = [hotButton sizeThatFits:_hotWordsView.frame.size];
        hotButton.frame   = CGRectMake(x, 8, buttonSize.width + 8, 28);
        
        hotButton.layer.cornerRadius = 5.0;
        hotButton.clipsToBounds = YES;
        
        [hotButton addTarget:self action:@selector(hotWordsClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:hotButton];
        
        x = hotButton.frame.origin.x + hotButton.frame.size.width + 8;
    }
    scrollView.contentSize = CGSizeMake(x, 28);
    
    [self.hotWordsView addSubview:scrollView];
}

- (void)loadHistoryRecord {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"histroyRecord"] != nil) {
        _recentSearchData = [[defaults objectForKey:@"histroyRecord"] mutableCopy];
    } else {
        _recentSearchData = [[NSMutableArray alloc] init];
    }
}

#pragma mark - Load Data
- (void)loadHotWords {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_SEARCH_HOTWORDS];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        HotWordsModel *hotWords = [HotWordsModel objectWithKeyValues:responseObject];
        weakSelf.dataModel = hotWords.data;
        [weakSelf loadHotWordsView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _recentSearchData.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _recentSearchData.count) {
        // 清除历史
        XSClearHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clearID forIndexPath:indexPath];
        cell.backgroundColor              = [UIColor clearColor];
        cell.selectionStyle               = UITableViewCellSelectionStyleNone;
        cell.selected                     = NO;
        [cell.clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    UITableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:recentID forIndexPath:indexPath];
    cell.textLabel.text      = _recentSearchData[indexPath.row];
    cell.backgroundColor     = [UIColor clearColor];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    cell.textLabel.font      = [cell.textLabel.font fontWithSize:14.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    
    CALayer *layer    = [cell layer];
    layer.borderWidth = 0.5f;
    layer.borderColor = [[UIColor colorWithRed:226 / 255.0 green:226 / 255.0 blue:226 / 255.0 alpha:1.0] CGColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _recentSearchData.count) {
        return 250;
    }
    return 40.0;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (indexPath.row != _recentSearchData.count) {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        
//        if ([_contextViewController isKindOfClass:[XSCommodityListViewController class]]) {
//            XSCommodityListViewController *lvc = (XSCommodityListViewController *)_contextViewController;
//            [lvc searchController].active = NO;
//            lvc.searchWords = cell.textLabel.text;
//            [lvc reloadData];
//        } else {
//            XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
//            comListViewController.searchWords = cell.textLabel.text;
//            _contextViewController.definesPresentationContext = NO;
//            [_contextViewController.navigationController pushViewController:comListViewController animated:YES];
//        }
//        
//    }
//    [self.searchBar resignFirstResponder];
//}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:recentID];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:clearID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSClearHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:clearID];
        
        _tableView.contentInset    = UIEdgeInsetsMake(64, 0.0f, 49, 0.0f);
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.separatorStyle  = UITableViewCellSelectionStyleNone;
        
        _tableView.tableHeaderView = self.hotWordsView;
    }
    return _tableView;
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = BACKGROUND_COLOR;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 200, 24)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [label.font fontWithSize:14.0];
        label.text = @"搜索历史";
        [_headerView addSubview:label];
    }
    return _headerView;
}

- (UIView *)hotWordsView {
    if (_hotWordsView == nil) {
        _hotWordsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 53)];
    }
    return _hotWordsView;
}

- (void)clearHistory {
    [_recentSearchData removeAllObjects];
    [self.tableView reloadData];
}


#pragma mark - private methods
- (void)setKeyWord {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *data       = [defaults dictionaryForKey:@"HomeModel"];
    NSString *keyword        = [data[@"data"] objectForKey:@"keyword"];
    if (keyword == nil) {
        keyword = @"搜索商品名称/商品编号";
    }
    [XSSearchBarHelper hackStandardSearchBar:self.searchBar keyword:keyword];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@""]) {
        XSSearchBarHelper *searchBarHelper = [[XSSearchBarHelper alloc] initWithNavigationBar:self.searchBar];
        [searchBarHelper peek];
        searchBar.text = searchBarHelper.UISearchBarTextField.placeholder;
    }
    
    [self.recentSearchData addUniqueString:searchBar.text];
    [self.tableView reloadData];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
}

#pragma mark - UISearchControllerDelegate
- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"开始进入搜索 发送广播");
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"将要进入搜索");
    
    self.searchBar.showsCancelButton = YES; // 显示删除按钮
    
    // 设置取消按钮的颜色
    UIView *firstView = self.searchBar.subviews[0];
    for (UIView *secondView in firstView.subviews) {
        if ([secondView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *cancelButton = (UIButton *)secondView;
            cancelButton.tintColor = [UIColor lightGrayColor];
        }
    }
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"进入搜索");
    [self loadHotWords];
    [self loadHistoryRecord];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"将要隐藏搜索");
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"隐藏搜索");
}

@end
