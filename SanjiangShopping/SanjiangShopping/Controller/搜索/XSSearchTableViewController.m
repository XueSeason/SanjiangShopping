//
//  XSSearchTableViewController.m
//  XSSearchController
//
//  Created by 薛纪杰 on 15/8/21.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSSearchTableViewController.h"

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

@interface XSSearchTableViewController ()
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *hotWordsView;

@property (strong, nonatomic) HotWordsDataModel *dataModel;

@end

@implementation XSSearchTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadHotWords];
    [self loadHistoryRecord];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableView.frame = [UIScreen mainScreen].bounds;
    
    [self loadHotWordsView];
    self.hotWordsView.backgroundColor = BACKGROUND_COLOR;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:recentID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:clearID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XSClearHistoryTableViewCell" bundle:nil] forCellReuseIdentifier:clearID];
    
    self.tableView.contentInset    = UIEdgeInsetsMake(64, 0.0f, 49, 0.0f);
    self.tableView.backgroundColor = BACKGROUND_COLOR;
    self.tableView.separatorStyle  = UITableViewCellSelectionStyleNone;
}

- (void)clearHistory {
    [_recentSearchData removeAllObjects];
    [self.tableView reloadData];
}

- (void)hotWordsClick:(UIButton *)sender {
    [_recentSearchData addUniqueString:[sender.titleLabel.text copy]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_recentSearchData forKey:@"histroyRecord"];
    [defaults synchronize];
    
    if ([self.contextViewController isKindOfClass:[XSCommodityListViewController class]]) {
        XSCommodityListViewController *lvc = (XSCommodityListViewController *)_contextViewController;
        [lvc searchController].active = NO;
        lvc.searchWords = sender.titleLabel.text;
        [lvc reloadData];
    } else {
        XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
        comListViewController.searchWords = sender.titleLabel.text;
        self.contextViewController.definesPresentationContext = NO;
        [self.contextViewController.navigationController pushViewController:comListViewController animated:YES];
    }

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

#pragma mark - Table view data source

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

#pragma mark - Table view delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40.0);
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _recentSearchData.count) {
        return 200;
    }
    return 40.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != _recentSearchData.count) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if ([_contextViewController isKindOfClass:[XSCommodityListViewController class]]) {
            XSCommodityListViewController *lvc = (XSCommodityListViewController *)_contextViewController;
            [lvc searchController].active = NO;
            lvc.searchWords = cell.textLabel.text;
            [lvc reloadData];
        } else {
            XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
            comListViewController.searchWords = cell.textLabel.text;
            _contextViewController.definesPresentationContext = NO;
            [_contextViewController.navigationController pushViewController:comListViewController animated:YES];
        }
        
    }
    [self.searchBar resignFirstResponder];
}

@end
