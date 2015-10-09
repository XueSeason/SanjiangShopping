//
//  XSMutiCatagoryViewController.m
//  XSMutiCatagoryView
//
//  Created by 薛纪杰 on 15/8/13.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSMutiCatagoryViewController.h"
#import "XSMutiCatagoryCollectionViewCell.h"
#import "XSHeaderCollectionReusableView.h"
#import "XSBannerCollectionReusableView.h"
#import "XSMutiCatagoryTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "NetworkConstant.h"
#import "XSNavigationBarHelper.h"
#import "MenuModel.h"
#import "CollectionModel.h"

#import "XSSearchTableViewController.h"
#import "XSResultTableViewController.h"
#import "XSSearchBarHelper.h"

#import "ThemeColor.h"

#import "XSCommodityListViewController.h"

static NSString * const tableCellId        = @"menu";
static NSString * const collectionCellId   = @"item";
static NSString * const collectionFooterId = @"footer";
static NSString * const collectionHeaderId = @"header";
static NSString * const collectionBannerID = @"banner";

#define MENU_COLOR [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0]

@interface XSMutiCatagoryViewController ()
<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) MenuDataModel       *menuData;
@property (strong, nonatomic) CollectionDataModel *collectionData;

@property (weak, nonatomic) IBOutlet UITableView      *tableView;
@property (assign, nonatomic) NSInteger currentMenuIndex;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) UISearchController          *searchController;
@property (strong, nonatomic) XSSearchTableViewController *searchTableViewController;
@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;
@property (strong, nonatomic) UIBarButtonItem *scanButton;

@end

@implementation XSMutiCatagoryViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    if (self.searchController.active) {
        self.searchController.active = NO;
    }
    self.definesPresentationContext = YES;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 加载搜索框
    [self loadSearchBar];
    
    /**
     *  设置 Table View
     */
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MENU_COLOR;
    _tableView.separatorColor  = MENU_COLOR;
    [_tableView registerClass:[XSMutiCatagoryTableViewCell class] forCellReuseIdentifier:tableCellId];
    
    /**
     *  设置 Collection View
     */
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[XSMutiCatagoryCollectionViewCell class] forCellWithReuseIdentifier:collectionCellId];
    [_collectionView registerNib:[UINib nibWithNibName:@"XSMutiCatagoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellId];
    
    [_collectionView registerClass:[XSHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderId];
    [_collectionView registerNib:[UINib nibWithNibName:@"XSHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderId];
    
    [_collectionView registerClass:[XSBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionBannerID];
    [_collectionView registerNib:[UINib nibWithNibName:@"XSBannerCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionBannerID];
    
    _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    
}

#pragma mark - 加载搜索框
- (void)loadSearchBar {
    _resultTableViewController = [[XSResultTableViewController alloc] init];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultTableViewController];
    _searchController.searchBar.searchBarStyle             = UISearchBarStyleMinimal;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    _searchController.dimsBackgroundDuringPresentation     = NO;
    
    _searchController.delegate             = self;
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.delegate   = self;
    
    // 设置搜索框样式
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *data = [defaults dictionaryForKey:@"HomeModel"];
    NSString *keyword = [data[@"data"] objectForKey:@"keyword"];
    if (keyword == nil) {
        keyword = @"搜索商品名称/商品编号";
    }
    [XSSearchBarHelper hackStandardSearchBar:_searchController.searchBar keyword:keyword];
    
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.navigationItem.titleView = _searchController.searchBar;
    
    // 添加扫描二维码按钮
    _scanButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ScanQRCode"] style:UIBarButtonItemStylePlain target:self action:@selector(scanQRCode)];
    _scanButton.tintColor = [UIColor lightGrayColor];
    self.navigationItem.leftBarButtonItem = _scanButton;
    
    /**
     *  获取JSON数据
     */
    [self loadMenuData];
}

- (void)scanQRCode {
    NSLog(@"Scan QRCode");
}

#pragma mark - 加载网络数据

- (void)loadMenuData {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CATAGORY_MENU];
    NSDictionary *parameters = @{};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.menuData = [[MenuModel objectWithKeyValues:responseObject] data];
        [weakSelf.tableView reloadData];
        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error);
    }];
}

- (void)loadCollectionData:(NSString *)menuID {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSString *URLString = [NSString stringWithFormat:@"%@%@:%@%@%@", PROTOCOL, SERVICE_ADDRESS, DEFAULT_PORT, ROUTER_CATAGORY_COLLECTION, menuID];
    NSDictionary *parameters = @{};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"utf-8" forHTTPHeaderField:@"charset"];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.collectionData = [[CollectionModel objectWithKeyValues:responseObject] data];
        [weakSelf.collectionView reloadData];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未连接" message:@"无法加载数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", error);
    }];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuData.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMutiCatagoryTableViewCell *cell = (XSMutiCatagoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellId forIndexPath:indexPath];
    MenuItemModel *item              = (MenuItemModel *)_menuData.list[indexPath.row];
    cell.textLabel.text              = item.ItemName;
    cell.textLabel.font              = [UIFont systemFontOfSize:12];
    cell.textLabel.textAlignment     = NSTextAlignmentCenter;
    cell.menuID                      = item.ItemID;
    cell.backgroundColor             = MENU_COLOR;
    cell.contentView.backgroundColor = MENU_COLOR;
    
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMutiCatagoryTableViewCell *cell = (XSMutiCatagoryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor  = [UIColor whiteColor];
    cell.backgroundColor              = [UIColor whiteColor];
    cell.textLabel.textColor          = THEME_RED;
    // 滚动到顶部
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self loadCollectionData:[_menuData.list[indexPath.row] ItemID]];
    _currentMenuIndex = indexPath.row;
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [[UIColor whiteColor] CGColor];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell            = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = MENU_COLOR;
    cell.backgroundColor             = MENU_COLOR;
    cell.textLabel.textColor         = [UIColor blackColor];
    
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
}

#pragma mark - Collection View Data Source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _collectionData.list.count + 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    
    return [_collectionData.list[section - 1] items].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return nil;
    }
    
    XSMutiCatagoryCollectionViewCell *cell = (XSMutiCatagoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
  
    CollectionItemModel *item = (CollectionItemModel *)[[_collectionData.list[indexPath.section - 1] items] objectAtIndex:indexPath.row];
    
    cell.itemID = item.itemID;
    cell.name.text = item.itemName;
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:item.img]];
    
    return cell;
}

#pragma mark - Collection Flow Layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeZero;
    }
    
    CGFloat side = ( _collectionView.frame.size.width - 6 * 8 ) / 3.0 - 8.0;
    return CGSizeMake(side, side + 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 8, 0, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (_collectionData.headAD == nil) {
            return CGSizeZero;
        }
        return CGSizeMake(_collectionView.frame.size.width, _collectionView.frame.size.width / 3.0);
    }
    
    return CGSizeMake(_collectionView.frame.size.width, 30);
}

#pragma mark - Collection View Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XSCommodityListViewController *listViewController = [[XSCommodityListViewController alloc] init];
    self.definesPresentationContext = NO;
    CollectionItemModel *item = (CollectionItemModel *)[[_collectionData.list[indexPath.section - 1] items] objectAtIndex:indexPath.row];
    
    listViewController.searchWords = item.itemName;
    [self.navigationController pushViewController:listViewController animated:YES];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 暂无
        return nil;
    } else {
        if (indexPath.section == 0) {
            XSBannerCollectionReusableView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionBannerID forIndexPath:indexPath];
            [header.picture sd_setImageWithURL:[NSURL URLWithString:_collectionData.headAD]];
            return header;
        }
        
        XSHeaderCollectionReusableView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderId forIndexPath:indexPath];
        header.titleLabel.text = [_collectionData.list[indexPath.section -1] title];
        header.colorLabel.backgroundColor = THEME_RED;
        return header;
    }
}

#pragma mark - Search Bar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"开始搜索");
    if ([searchBar.text isEqualToString:@""]) {
        NSLog(@"搜索默认热词");
        XSSearchBarHelper *searchBarHelper = [[XSSearchBarHelper alloc] initWithNavigationBar:_searchController.searchBar];
        [searchBarHelper peek];
        searchBar.text = searchBarHelper.UISearchBarTextField.placeholder;
    }
    [_searchTableViewController.recentSearchData addUniqueString:searchBar.text];
    [_searchTableViewController.tableView reloadData];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - Search Result Updater
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
}

#pragma mark - Search Controller Delegate
- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"开始进入搜索");
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"将要进入搜索");
    
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationItem.leftBarButtonItem = nil;
    }];
    
    _searchTableViewController = [[XSSearchTableViewController alloc] init];
    _searchTableViewController.searchBar = _searchController.searchBar;
    _searchTableViewController.contextViewController = self;
    _searchTableViewController.tableView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_searchTableViewController.tableView];
    
    _searchController.searchBar.showsCancelButton = YES; // 显示删除按钮
    // 设置取消按钮的颜色
    UIView *firstView = _searchController.searchBar.subviews[0];
    for (UIView *secondView in firstView.subviews) {
        if ([secondView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            UIButton *cancelButton = (UIButton *)secondView;
            cancelButton.tintColor = [UIColor lightGrayColor];
        }
    }
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"进入搜索");
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"将要隐藏搜索");
    if (_searchTableViewController != nil) {
        [_searchTableViewController.tableView removeFromSuperview];
        _searchTableViewController = nil;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.navigationItem.leftBarButtonItem = _scanButton;
    }];
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"隐藏搜索");
}

@end
