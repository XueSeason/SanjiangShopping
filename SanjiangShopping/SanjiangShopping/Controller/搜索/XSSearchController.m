//
//  XSSearchController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/6/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSearchController.h"

#import "XSSearchBarHelper.h"

#import "HotWordsView.h"
#import "HotWordsModel.h"

#import "ThemeColor.h"
#import "XSResultTableViewController.h"
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

@property (strong, nonatomic) UITableView   *tableView;
@property (strong, nonatomic) UIView        *headerView;
@property (strong, nonatomic) HotWordsView  *hotWordsView;
@property (strong, nonatomic) HotWordsModel *hotWordsModel;

@end

@implementation XSSearchController

- (instancetype)initWithSearchResultsController:(XSResultTableViewController *)searchResultsController {
    self = [super initWithSearchResultsController:searchResultsController];
    if (self) {
        self.resultTableViewController = searchResultsController;
        self.searchBar.searchBarStyle  = UISearchBarStyleMinimal;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *hotWord        = [defaults stringForKey:@"hotWord"];
        if (hotWord == nil) {
            [XSSearchBarHelper hackStandardSearchBar:self.searchBar keyword:@"搜索商品名称/商品编号"];
        } else {
            [XSSearchBarHelper hackStandardSearchBar:self.searchBar keyword:hotWord];
        }
    }
    return self;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hidesNavigationBarDuringPresentation = NO;
    self.dimsBackgroundDuringPresentation     = NO;
    
    self.delegate             = self;
    self.searchResultsUpdater = self;
    self.searchBar.delegate   = self;
    
    [self.view addSubview:self.tableView];
    
    [self loadHotWords];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.frame = [UIScreen mainScreen].bounds;
    
    [self loadHistoryRecord];
}

#pragma mark - private methods
- (void)loadHotWords {
    __weak typeof(self) weakSelf = self;
    [self.hotWordsModel loadHotWordsSuccess:^{
        weakSelf.hotWordsView.dataModel = weakSelf.hotWordsModel.data;
    } Failure:nil];
}

- (void)loadHistoryRecord {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"histroyRecord"] != nil) {
        self.recentSearchData = [[defaults objectForKey:@"histroyRecord"] mutableCopy];
    } else {
        self.recentSearchData = [[NSMutableArray alloc] init];
    }
    [self.tableView reloadData];
}

- (void)clearHistory {
    [self.recentSearchData removeAllObjects];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"histroyRecord"];
    [defaults synchronize];
    
    [self.tableView reloadData];
}

#pragma mark - event response
- (void)hotWordsTap:(UIButton *)sender {
    [self.recentSearchData addUniqueString:[sender.titleLabel.text copy]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.recentSearchData forKey:@"histroyRecord"];
    [defaults synchronize];
    
    [self.tableView reloadData];
    
    self.searchWordQuery(sender.titleLabel.text);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recentSearchData.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.recentSearchData.count) {
        // 清除历史
        XSClearHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:clearID forIndexPath:indexPath];
        [cell.clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    UITableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:recentID forIndexPath:indexPath];
    cell.textLabel.text      = self.recentSearchData[indexPath.row];
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
    if (indexPath.row == self.recentSearchData.count) {
        return 250;
    }
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    __weak typeof(self) weakSelf = self;
    if (indexPath.row != self.recentSearchData.count) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        weakSelf.searchWordQuery(cell.textLabel.text);
    }
    [self.searchBar resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.recentSearchData addUniqueString:searchBar.text];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.recentSearchData forKey:@"histroyRecord"];
    [defaults synchronize];
    
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
    
    self.searchWordQuery(searchBar.text);
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
    NSLog(@"开始进入搜索");
    if (self.presentSearchBlock) {
        self.presentSearchBlock(searchController);
    }
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
    
    if (self.willPresentSearchBlock) {
        self.willPresentSearchBlock(searchController);
    }
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"进入搜索");
    [self loadHistoryRecord];
    
    if (self.didPresentSearchBlock) {
        self.didPresentSearchBlock(searchController);
    }
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"将要隐藏搜索");
    
    if (self.willDismissSearchBlock) {
        self.willDismissSearchBlock(searchController);
    }
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"隐藏搜索");
    
    if (self.didDismissSearchBlock) {
        self.didDismissSearchBlock(searchController);
    }
}

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
        _hotWordsView = [[HotWordsView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        _hotWordsView.backgroundColor = BACKGROUND_COLOR;
        
        __weak typeof(self) weakSelf = self;
        _hotWordsView.hotButtonClickBlock = ^(UIButton *sender) {
            [weakSelf hotWordsTap:sender];
        };
    }
    return _hotWordsView;
}

- (HotWordsModel *)hotWordsModel {
    if (_hotWordsModel == nil) {
        _hotWordsModel = [[HotWordsModel alloc] init];
    }
    return _hotWordsModel;
}

@end
