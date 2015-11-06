//
//  XSMutiCatagoryViewController.m
//  XSMutiCatagoryView
//
//  Created by 薛纪杰 on 15/8/13.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSMutiCatagoryViewController.h"
#import "XSMutiCatagoryTableViewDataSource.h"
#import "XSMutiCatagoryCollectionViewDataSource.h"

#import "XSMutiCatagoryCollectionViewCell.h"
#import "XSHeaderCollectionReusableView.h"
#import "XSBannerCollectionReusableView.h"
#import "XSMutiCatagoryTableViewCell.h"

#import "XSNavigationBarHelper.h"

#import "MenuModel.h"
#import "CollectionModel.h"

#import "XSSearchTableViewController.h"
#import "XSResultTableViewController.h"
#import "XSSearchBarHelper.h"

#import "XSCommodityListViewController.h"

static NSString * const tableCellId        = @"menu";
static NSString * const collectionCellId   = @"item";
static NSString * const collectionHeaderId = @"header";
static NSString * const collectionBannerID = @"banner";

#define MENU_COLOR [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0]

@interface XSMutiCatagoryViewController ()
<UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) XSMutiCatagoryTableViewDataSource *mutiCatagoryTableViewDataSource;
@property (strong, nonatomic) XSMutiCatagoryCollectionViewDataSource *mutiCatagoryCollectionViewDataSource;

@property (strong, nonatomic) MenuModel *menu;
@property (strong, nonatomic) CollectionModel *collection;

@property (assign, nonatomic) NSInteger currentMenuIndex;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UISearchController          *searchController;
@property (strong, nonatomic) XSSearchTableViewController *searchTableViewController;
@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;
@property (strong, nonatomic) UIBarButtonItem *scanButton;

@end

@implementation XSMutiCatagoryViewController

#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    self.searchController.active = NO;
    self.definesPresentationContext = YES;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    self.tableView.frame      = CGRectMake(0, 0, width / 4, height);
    self.collectionView.frame = CGRectMake(width / 4, 0, width / 4 * 3, height);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavigationBar];

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    [self loadMenuData];
}

#pragma mark - event response
//- (void)scanQRCode {
//    NSLog(@"Scan QRCode");
//}

#pragma mark - private methods
- (void)customNavigationBar {
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.navigationItem.titleView = self.searchController.searchBar;
//    self.navigationItem.leftBarButtonItem = self.scanButton;
}

- (void)loadMenuData {
    __weak typeof(self) weakSelf = self;
    [self.menu loadMenuSuccess:^{
        weakSelf.mutiCatagoryTableViewDataSource.items = weakSelf.menu.data.list;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    } Failure:nil];
}

- (void)loadCollectionData:(NSString *)menuID {
    __weak typeof(self) weakSelf = self;
    [self.collection loadCollectionWithMenuID:menuID Success:^{
        weakSelf.mutiCatagoryCollectionViewDataSource.data = weakSelf.collection.data;
        [weakSelf.collectionView reloadData];
    } Failure:nil];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 滚动到顶部
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self loadCollectionData:[_menu.data.list[indexPath.row] ItemID]];
    _currentMenuIndex = indexPath.row;
}

#pragma mark - UICollectionViewDelegateFlowLayout
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
        if (self.collection.data.headAD == nil) {
            return CGSizeZero;
        }
        return CGSizeMake(_collectionView.frame.size.width, _collectionView.frame.size.width / 3.0);
    }
    
    return CGSizeMake(_collectionView.frame.size.width, 30);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XSCommodityListViewController *listViewController = [[XSCommodityListViewController alloc] init];
    self.definesPresentationContext = NO;
    CollectionItemModel *item = (CollectionItemModel *)[[self.collection.data.list[indexPath.section - 1] items] objectAtIndex:indexPath.row];
    
    listViewController.searchWords = item.itemName;
    [self.navigationController pushViewController:listViewController animated:YES];
}

#pragma mark - UISearchBarDelegate
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

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%@", searchController.searchBar.text);
}

#pragma mark - UISearchControllerDelegate
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

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = MENU_COLOR;
        _tableView.separatorColor  = MENU_COLOR;
        
        [_tableView registerClass:[XSMutiCatagoryTableViewCell class] forCellReuseIdentifier:tableCellId];
        [_tableView registerNib:[UINib nibWithNibName:@"XSMutiCatagoryTableViewCell" bundle:nil] forCellReuseIdentifier:tableCellId];
        
        _tableView.delegate   = self;
        _tableView.dataSource = self.mutiCatagoryTableViewDataSource;
    }
    return _tableView;
}

- (XSMutiCatagoryTableViewDataSource *)mutiCatagoryTableViewDataSource {
    if (_mutiCatagoryTableViewDataSource == nil) {
        _mutiCatagoryTableViewDataSource = [[XSMutiCatagoryTableViewDataSource alloc] initWithItems:self.menu.data.list cellIdentifier:tableCellId configureCellBlock:^(XSMutiCatagoryTableViewCell *cell, MenuItemModel *item) {
            [cell configureForMenuItem:item];
        }];
    }
    return _mutiCatagoryTableViewDataSource;
}

- (MenuModel *)menu {
    if (_menu == nil) {
        _menu = [[MenuModel alloc] init];
    }
    return _menu;
}

- (CollectionModel *)collection {
    if (_collection == nil) {
        _collection = [[CollectionModel alloc] init];
    }
    return _collection;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator   = NO;
        
        [_collectionView registerClass:[XSMutiCatagoryCollectionViewCell class] forCellWithReuseIdentifier:collectionCellId];
        [_collectionView registerNib:[UINib nibWithNibName:@"XSMutiCatagoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionCellId];
        
        [_collectionView registerClass:[XSHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderId];
        [_collectionView registerNib:[UINib nibWithNibName:@"XSHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderId];
        
        [_collectionView registerClass:[XSBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:collectionBannerID];
        [_collectionView registerNib:[UINib nibWithNibName:@"XSBannerCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionBannerID];
        
        _collectionView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
        
        _collectionView.delegate   = self;
        _collectionView.dataSource = self.mutiCatagoryCollectionViewDataSource;
    }
    return _collectionView;
}

- (XSMutiCatagoryCollectionViewDataSource *)mutiCatagoryCollectionViewDataSource {
    if (_mutiCatagoryCollectionViewDataSource == nil) {
        _mutiCatagoryCollectionViewDataSource = [[XSMutiCatagoryCollectionViewDataSource alloc] initWithData:self.collection.data cellIdentifier:collectionCellId bannerIdentifier:collectionBannerID headerIdentifier:collectionHeaderId configureCellBlock:^(id cell, id item) {
            [cell configureForCollectionItem:item];
        }];
    }
    return _mutiCatagoryCollectionViewDataSource;
}

- (XSResultTableViewController *)resultTableViewController {
    if (_resultTableViewController == nil) {
        _resultTableViewController = [[XSResultTableViewController alloc] init];
    }
    return _resultTableViewController;
}

- (UISearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultTableViewController];
        _searchController.searchBar.searchBarStyle             = UISearchBarStyleMinimal;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        _searchController.dimsBackgroundDuringPresentation     = NO;
        
        _searchController.delegate             = self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate   = self;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *data = [defaults dictionaryForKey:@"HomeModel"];
        NSString *keyword = [data[@"data"] objectForKey:@"keyword"];
        if (keyword == nil) {
            keyword = @"搜索商品名称/商品编号";
        }
        [XSSearchBarHelper hackStandardSearchBar:_searchController.searchBar keyword:keyword];
    }
    return _searchController;
}

//- (UIBarButtonItem *)scanButton {
//    if (_scanButton == nil) {
//        _scanButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ScanQRCode"] style:UIBarButtonItemStylePlain target:self action:@selector(scanQRCode)];
//        _scanButton.tintColor = [UIColor lightGrayColor];
//    }
//    return _scanButton;
//}

@end
