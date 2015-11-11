//
//  XSDeliveredInformationViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/19.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSDeliveredInformationViewController.h"
#import "XSNavigationBarHelper.h"

#import "XSSegmentControl.h"
#import "XSDeliveredAddressTableViewCell.h"
#import "XSEditAddressViewController.h"
#import "ThemeColor.h"

static NSString * const cellID = @"address";

@interface XSDeliveredInformationViewController () <XSSegmentControlDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) XSSegmentControl *segmentControl;

@property (strong, nonatomic) UIView *addressView;
@property (strong, nonatomic) UITableView *addressTableView;
@property (strong, nonatomic) UIButton *addAddressButton;

@property (strong, nonatomic) UIView *selfHelpView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@end

@implementation XSDeliveredInformationViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBar];
    
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.selfHelpView];
    self.selfHelpView.hidden = YES;
    
    self.view.backgroundColor = BACKGROUND_COLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    CGFloat y = self.segmentControl.frame.size.height + self.segmentControl.frame.origin.y;
    self.addressView.frame = CGRectMake(0, y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - y);
    self.addressTableView.frame = self.addressView.bounds;
    self.addAddressButton.frame = CGRectMake(0, CGRectGetHeight(self.addressView.bounds) - 50, CGRectGetWidth(self.addressView.bounds), 50);
    self.addressTableView.contentInset = UIEdgeInsetsMake(0, 0, self.addAddressButton.frame.size.height, 0);
    
    self.selfHelpView.frame = CGRectMake(0, y, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - y);
    
}

#pragma mark - XSSegmentControlDelegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    [self resignAllFirstResponder];
    if (self.segmentControl.selectedIndex == 0) {
        self.addressView.hidden = NO;
        self.selfHelpView.hidden = YES;
    } else {
        self.addressView.hidden = YES;
        self.selfHelpView.hidden = NO;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XSDeliveredAddressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.hasSelected = YES;
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"收货信息";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resignAllFirstResponder {
    [self.nameTextField resignFirstResponder];
    [self.phoneNumberTextField resignFirstResponder];
}

- (void)addAddress {
    [self.navigationController pushViewController:[[XSEditAddressViewController alloc] init] animated:YES];
}

#pragma mark - getters and setters
- (UIView *)addressView {
    if (_addressView == nil) {
        _addressView = [[UIView alloc] init];
        [_addressView addSubview:self.addressTableView];
        [_addressView addSubview:self.addAddressButton];
    }
    return _addressView;
}

- (UITableView *)addressTableView {
    if (_addressTableView == nil) {
        _addressTableView = [[UITableView alloc] init];
        _addressTableView.delegate   = self;
        _addressTableView.dataSource = self;
        _addressTableView.backgroundColor = BACKGROUND_COLOR;
        _addressTableView.tableFooterView = [UIView new];
        _addressTableView.showsHorizontalScrollIndicator = NO;
        _addressTableView.showsVerticalScrollIndicator   = NO;
        [_addressTableView registerClass:[XSDeliveredAddressTableViewCell class] forCellReuseIdentifier:cellID];
        [_addressTableView registerNib:[UINib nibWithNibName:@"XSDeliveredAddressTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _addressTableView;
}

- (UIButton *)addAddressButton {
    if (_addAddressButton == nil) {
        _addAddressButton = [[UIButton alloc] init];
        [_addAddressButton setTitle: @"+添加新地址" forState:UIControlStateNormal];
        _addAddressButton.backgroundColor = [UIColor redColor];
        _addAddressButton.tintColor       = [UIColor whiteColor];
        [_addAddressButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressButton;
}

- (UIView *)selfHelpView {
    if (_selfHelpView == nil) {
        _selfHelpView = [[UIView alloc] init];

        UIView *tempView = [[[NSBundle mainBundle] loadNibNamed:@"FillSelfHelpView" owner:self options:nil] objectAtIndex:0];
        tempView.backgroundColor = BACKGROUND_COLOR;
        [_selfHelpView addSubview:tempView];
        
        tempView.translatesAutoresizingMaskIntoConstraints = NO;
        // 自动布局
        NSDictionary *mainMap = @{
                                  @"v": tempView
                                  };
        [_selfHelpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v]-0-|" options:0 metrics:nil views:mainMap]];
        [_selfHelpView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v]-0-|" options:0 metrics:nil views:mainMap]];
    }
    return _selfHelpView;
}

- (XSSegmentControl *)segmentControl {
    if (_segmentControl == nil) {
        NSArray *segmentTitles = @[@"三江配送", @"门店自提"];
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 64 + 10, CGRectGetWidth(self.view.bounds), 50)];
        _segmentControl.titles = segmentTitles;
        _segmentControl.delegate = self;
        _segmentControl.hasLine = YES;
        _segmentControl.selectedIndex = 0;
        _segmentControl.backgroundColor = [UIColor whiteColor];
        _segmentControl.layer.borderColor = [BACKGROUND_COLOR CGColor];
        _segmentControl.layer.borderWidth = 1.0f;
    }
    return _segmentControl;
}

@end
