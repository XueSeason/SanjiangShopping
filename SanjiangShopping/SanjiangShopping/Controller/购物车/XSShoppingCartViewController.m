//
//  XSShoppingCartViewController.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSShoppingCartViewController.h"
#import "XSAddressTableViewCell.h"
#import "XSShoppingCartTableViewCell.h"
#import "XSDeliveredInformationViewController.h"

#import "XSNavigationBarHelper.h"

#import "ThemeColor.h"

#import "CartModel.h"

#import "XSConfirmOrderViewController.h"

#import <MBProgressHUD.h>

#import "UIView+State.h"

#import "XSCommodityListViewController.h"

#import "XSShoppingCartViewDataSource.h"

static NSString * const cellID    = @"ShopCart";
static NSString * const addressID = @"Address";

@interface XSShoppingCartViewController () <UITableViewDelegate, UIViewStateDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) XSShoppingCartViewDataSource *shoppingCartDataSource;

@property (strong, nonatomic) UIView *controlPannelView;

@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (weak, nonatomic) IBOutlet UIButton *otherSelectAllButton;
@property (weak, nonatomic) IBOutlet UILabel *priceNowLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet UIButton *settlementButton;

@property (strong, nonatomic)  UIView *editPanelView;
@property (weak, nonatomic) IBOutlet UIButton *addToFavoritesButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (strong, nonatomic) CartModel *cartModel;

@property (assign, nonatomic) BOOL hasSelectedAll;

@end

@implementation XSShoppingCartViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    [self.view addSubview:self.editPanelView];
    [self.view addSubview:self.controlPannelView];
    [self.view addSubview:self.tableView];
    
    self.view.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if ([self.navigationController.tabBarItem.title isEqualToString:@"购物车"]) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    CGRect pannelFrame;
    if (!self.tabBarController.tabBar.hidden) {
        pannelFrame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - self.tabBarController.tabBar.frame.size.height - 49, CGRectGetWidth([UIScreen mainScreen].bounds), 49);
    } else {
        pannelFrame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - 49, CGRectGetWidth([UIScreen mainScreen].bounds), 49);
    }
    self.controlPannelView.frame = pannelFrame;
    self.editPanelView.frame     = pannelFrame;
    
    self.tableView.frame = CGRectMake(0, 0, pannelFrame.size.width, pannelFrame.origin.y);
    [self loadCartItem];
    
    self.hasSelectedAll = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

#pragma mark - UIViewStateDelegate
- (void)viewStateShouldChange {
    if (self.cartModel.data != nil && self.cartModel.data.list.count == 0) {
        [self.navigationController pushViewController:[[XSCommodityListViewController alloc] init] animated:YES];
    } else {
        [self loadCartItem];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110.0;
    }
    return 85.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XSDeliveredInformationViewController *vc = [[XSDeliveredInformationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSLog(@"click");
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
// 分割线
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = OTHER_SEPARATOR_COLOR;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5f;
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"购物车";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    editButton.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = editButton;

}

- (void)loadCartItem {
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.cartModel loadCartSuccess:^{
        weakSelf.shoppingCartDataSource.items = weakSelf.cartModel.data.list;
        [weakSelf.tableView reloadData];
        [weakSelf.view xs_switchToContentState];

        if (weakSelf.cartModel.data.list.count == 0) {
            [weakSelf.view xs_switchToEmptyState];
        }
        
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    } Failure:^(NSError *error) {
        [weakSelf.view xs_switchToErrorStateWithErrorCode:error.code];
        [MBProgressHUD hideAllHUDsForView:weakSelf.view animated:YES];
    }];
}

#pragma mark - event response
- (IBAction)selectAllButtonClick:(UIButton *)sender {
    
    if (self.hasSelectedAll) {
        for (CartItemModel *item in self.cartModel.data.list) {
            item.selected = 0;
        }
    } else {
        for (CartItemModel *item in self.cartModel.data.list) {
            item.selected = 1;
        }
    }
    [self.tableView reloadData];
    self.hasSelectedAll = !self.hasSelectedAll;
}

- (IBAction)settlementButtonClick:(UIButton *)sender {
    XSConfirmOrderViewController *confirmViewController = [[XSConfirmOrderViewController alloc] init];
    [self.navigationController pushViewController:confirmViewController animated:YES];
}

- (IBAction)addToFavorites:(UIButton *)sender {
    NSLog(@"加入收藏");
}

- (IBAction)delete:(UIButton *)sender {
    NSLog(@"删除");
}

- (void)edit:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        sender.title = @"完成";
        self.controlPannelView.hidden = YES;
        self.editPanelView.hidden = NO;
    } else {
        sender.title = @"编辑";
        self.controlPannelView.hidden = NO;
        self.editPanelView.hidden = YES;
    }
}

#pragma mark - getters and setters
- (UIView *)editPanelView {
    if (_editPanelView == nil) {
        _editPanelView = [[[NSBundle mainBundle] loadNibNamed:@"EditPanelView" owner:self options:nil] objectAtIndex:0];
        _editPanelView.hidden = YES;
        _editPanelView.layer.borderWidth = 0.5f;
        _editPanelView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        
        [_addToFavoritesButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _addToFavoritesButton.layer.borderWidth  = 1.0f;
        _addToFavoritesButton.layer.borderColor  = [[UIColor lightGrayColor] CGColor];
        _addToFavoritesButton.layer.cornerRadius = 5.0f;
        
        _deleteButton.layer.cornerRadius = 5.0f;
    }
    return _editPanelView;
}

- (UIView *)controlPannelView {
    if (_controlPannelView == nil) {
        _controlPannelView = [[[NSBundle mainBundle] loadNibNamed:@"ControlPannelView" owner:self options:nil] objectAtIndex:0];
        _settlementButton.backgroundColor = THEME_RED;
        _controlPannelView.layer.borderWidth = 0.5f;
        _controlPannelView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    }
    return _controlPannelView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.delegate        = self;
        _tableView.contentInset    = UIEdgeInsetsMake(64, 0, 0, 0);
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        [_tableView registerClass:[XSAddressTableViewCell class] forCellReuseIdentifier:addressID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSAddressTableViewCell" bundle:nil] forCellReuseIdentifier:addressID];
        [_tableView registerClass:[XSShoppingCartTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSShoppingCartTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        
        _tableView.dataSource = self.shoppingCartDataSource;
    }
    return _tableView;
}

- (XSShoppingCartViewDataSource *)shoppingCartDataSource {
    if (_shoppingCartDataSource == nil) {
        _shoppingCartDataSource = [[XSShoppingCartViewDataSource alloc] initWithItems:self.cartModel.data.list addressIdentifier:addressID cellIdentifier:cellID configureAddressBlock:^(XSAddressTableViewCell *cell, CartItemModel *item) {
            cell.backgroundColor = BACKGROUND_COLOR;
        } configureCellBlock:^(XSShoppingCartTableViewCell *cell, CartItemModel *item) {
            cell.item = item;
            if (item.selected) {
                cell.isSelected = YES;
            } else {
                cell.isSelected = NO;
            }
        }];
    }
    return _shoppingCartDataSource;
}

- (CartModel *)cartModel {
    if (_cartModel == nil) {
        _cartModel = [[CartModel alloc] init];
    }
    return _cartModel;
}

- (void)setHasSelectedAll:(BOOL)hasSelectedAll {
    if (hasSelectedAll) {
        [self.selectAllButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
        [self.otherSelectAllButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    } else {
        [self.selectAllButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [self.otherSelectAllButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    }
    _hasSelectedAll = hasSelectedAll;
}

@end
