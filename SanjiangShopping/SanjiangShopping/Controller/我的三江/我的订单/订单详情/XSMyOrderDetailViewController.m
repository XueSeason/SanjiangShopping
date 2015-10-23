//
//  XSMyOrderDetailViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/23.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyOrderDetailViewController.h"

#import "ThemeColor.h"
#import "XSNavigationBarHelper.h"

#import "XSZeroTableViewCell.h"
#import "XSOneTableViewCell.h"
#import "XSTwoTableViewCell.h"
#import "XSThreeTableViewCell.h"
#import "XSFourTableViewCell.h"

static NSString * const zeroID = @"zore";
static NSString * const oneID = @"one";
static NSString * const twoID = @"two";
static NSString * const threeID = @"three";
static NSString * const fourID = @"four";

@interface XSMyOrderDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *logisticsButton;
@property (weak, nonatomic) IBOutlet UIButton *buyAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation XSMyOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavigationBar];
    [self.view addSubview:self.tableView];
    [self loadButtonPannel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            cell = (XSZeroTableViewCell *)[tableView dequeueReusableCellWithIdentifier:zeroID forIndexPath:indexPath];
            break;
        case 1:
            cell = (XSOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:oneID forIndexPath:indexPath];
            break;
        case 2:
            cell = (XSTwoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:twoID forIndexPath:indexPath];
            break;
        case 3:
            cell = (XSThreeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:threeID forIndexPath:indexPath];
            break;
        case 4:
            cell = (XSFourTableViewCell *)[tableView dequeueReusableCellWithIdentifier:fourID forIndexPath:indexPath];
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 65.0;
            break;
        case 1:
            return 76.0;
            break;
        case 2:
            return 85.0;
            break;
        case 3:
            return 45.0;
            break;
        case 4:
            return 124.0;
            break;
        default:
            return 0.0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = BACKGROUND_COLOR;
    return view;
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"订单详情";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadButtonPannel {
    UIView *buttonPannelView = [[[NSBundle mainBundle] loadNibNamed:@"MyOrderViewButtonPannel" owner:self options:nil] objectAtIndex:0];
    buttonPannelView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - 49, CGRectGetWidth([UIScreen mainScreen].bounds), 49);
    
    [self customButton:self.buyAgainButton];
    [self customButton:self.commentButton];
    [self customButton:self.logisticsButton];
    
    self.commentButton.backgroundColor = THEME_RED;
    
    [self.view addSubview:buttonPannelView];
}

- (void)customButton:(UIButton *)button {
    button.layer.borderColor  = [[UIColor lightGrayColor] CGColor];
    button.layer.borderWidth  = 0.5f;
    button.layer.cornerRadius = 5.0f;
    button.clipsToBounds = YES;
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        _tableView.backgroundColor = BACKGROUND_COLOR;
        
        [_tableView registerClass:[XSZeroTableViewCell class] forCellReuseIdentifier:zeroID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSZeroTableViewCell" bundle:nil] forCellReuseIdentifier:zeroID];
        
        [_tableView registerClass:[XSOneTableViewCell class] forCellReuseIdentifier:oneID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSOneTableViewCell" bundle:nil] forCellReuseIdentifier:oneID];
        
        [_tableView registerClass:[XSTwoTableViewCell class] forCellReuseIdentifier:twoID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSTwoTableViewCell" bundle:nil] forCellReuseIdentifier:twoID];
        
        [_tableView registerClass:[XSThreeTableViewCell class] forCellReuseIdentifier:threeID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSThreeTableViewCell" bundle:nil] forCellReuseIdentifier:threeID];
        
        [_tableView registerClass:[XSFourTableViewCell class] forCellReuseIdentifier:fourID];
        [_tableView registerNib:[UINib nibWithNibName:@"XSFourTableViewCell" bundle:nil] forCellReuseIdentifier:fourID];
    }
    return _tableView;
}

@end
