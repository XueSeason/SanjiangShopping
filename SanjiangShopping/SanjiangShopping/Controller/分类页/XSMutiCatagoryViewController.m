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

#import "XSResultTableViewController.h"
#import "XSSearchController.h"

#import "XSCommodityListViewController.h"

#import "UIView+State.h"

#import <MBProgressHUD.h>

static NSString * const tableCellId        = @"menu";
static NSString * const collectionCellId   = @"item";
static NSString * const collectionHeaderId = @"header";
static NSString * const collectionBannerID = @"banner";

#define MENU_COLOR [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0]

@interface XSMutiCatagoryViewController () <UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIViewStateDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) XSMutiCatagoryTableViewDataSource *mutiCatagoryTableViewDataSource;
@property (strong, nonatomic) XSMutiCatagoryCollectionViewDataSource *mutiCatagoryCollectionViewDataSource;

@property (strong, nonatomic) MenuModel *menu;
@property (strong, nonatomic) CollectionModel *collection;

@property (assign, nonatomic) NSInteger currentMenuIndex;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) XSSearchController          *searchController;
@property (strong, nonatomic) XSResultTableViewController *resultTableViewController;

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
    self.view.delegate = self;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    [self loadMenuData];
}

#pragma mark - private methods
- (void)customNavigationBar {
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.navigationItem.titleView = self.searchController.searchBar;
}

- (void)loadMenuData {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.menu loadMenuSuccess:^{
        [weakSelf.view xs_switchToContentState];
        weakSelf.mutiCatagoryTableViewDataSource.items = weakSelf.menu.data.list;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
        [weakSelf tableView:weakSelf.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    } Failure:^(NSError *error) {
        [weakSelf.view xs_switchToErrorStateWithErrorCode:error.code];
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}

- (void)loadCollectionData:(NSString *)menuID {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.collection loadCollectionWithMenuID:menuID Success:^{
        weakSelf.mutiCatagoryCollectionViewDataSource.data = weakSelf.collection.data;
        [weakSelf.collectionView reloadData];
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    } Failure:^(NSError *error) {
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}

#pragma mark - UIViewStateDelegate
- (void)viewStateShouldChange {
    [self loadMenuData];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 滚动到顶部
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self loadCollectionData:[self.menu.data.list[indexPath.row] ItemID]];
    self.currentMenuIndex = indexPath.row;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeZero;
    }
    
    CGFloat side = ( self.collectionView.frame.size.width - 6 * 8 ) / 3.0 - 8.0;
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
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.width / 3.0);
    }
    
    return CGSizeMake(self.collectionView.frame.size.width, 30);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.definesPresentationContext = NO;
    
    XSCommodityListViewController *listViewController = [[XSCommodityListViewController alloc] init];
    CollectionItemModel *item = (CollectionItemModel *)[[self.collection.data.list[indexPath.section - 1] items] objectAtIndex:indexPath.row];
    listViewController.searchWords = item.itemName;
    
    [self.navigationController pushViewController:listViewController animated:YES];
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

- (XSSearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[XSSearchController alloc] initWithSearchResultsController:self.resultTableViewController];
        
        __weak typeof(self) weakSelf = self;
        _searchController.searchWordQuery = ^(NSString *searchWord) {
            
            if ([weakSelf isKindOfClass:[XSCommodityListViewController class]]) {
                XSCommodityListViewController *lvc = (XSCommodityListViewController *)weakSelf;
                [lvc searchController].active = NO;
                lvc.searchWords = searchWord;
                [lvc reloadData];
            } else {
                XSCommodityListViewController *comListViewController = [[XSCommodityListViewController alloc] init];
                comListViewController.searchWords = searchWord;
                weakSelf.definesPresentationContext = NO;
                [weakSelf.navigationController pushViewController:comListViewController animated:YES];
            }
        };
    }
    return _searchController;
}

@end
