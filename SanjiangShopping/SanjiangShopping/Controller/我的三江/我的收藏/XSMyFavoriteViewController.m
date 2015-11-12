//
//  XSMyFavoriteViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyFavoriteViewController.h"

#import "XSMyFavoriteTableViewCell.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const cellID = @"cell";

@interface XSMyFavoriteViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIBarButtonItem *rightButtonItem;
@end

@implementation XSMyFavoriteViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavigationBar];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden           = YES;
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSMyFavoriteTableViewCell *cell = (XSMyFavoriteTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row % 2 == 0) {
        [cell invalid];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 121.0;
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"我的收藏";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    // 编辑
    self.navigationItem.rightBarButtonItem = self.rightButtonItem;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)edit {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing) {
        self.rightButtonItem.title = @"完成";
    } else {
        self.rightButtonItem.title = @"编辑";
    }
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[XSMyFavoriteTableViewCell class] forCellReuseIdentifier:cellID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSMyFavoriteTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (UIBarButtonItem *)rightButtonItem {
    if (_rightButtonItem == nil) {
        _rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
        _rightButtonItem.tintColor = MAIN_TITLE_COLOR;
    }
    return _rightButtonItem;
}

@end
