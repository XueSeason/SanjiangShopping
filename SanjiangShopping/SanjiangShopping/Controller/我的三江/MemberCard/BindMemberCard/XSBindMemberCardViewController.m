//
//  XSBindMemberCardViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/18.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSBindMemberCardViewController.h"

#import "XSSegmentControl.h"

#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

static NSString * const cellID = @"memberInfo";

@interface XSBindMemberCardViewController () <XSSegmentControlDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *memberCardNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyTextField;
@property (weak, nonatomic) IBOutlet UIButton *verifyButton;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIView *segmentView;

@property (strong, nonatomic) XSSegmentControl *segmentControl;
@property (strong, nonatomic) IBOutlet UIView *bindMemberCardView;
@property (strong, nonatomic) IBOutlet UIView *registerMemberCardView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *infoArr;

@end

@implementation XSBindMemberCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.navigationItem.title = @"绑定会员卡";
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _verifyButton.layer.borderColor = [[UIColor colorWithRed:240 / 255.0 green:56 / 255.0 blue:56 / 255.0 alpha:1.0] CGColor];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"会员说明" style:UIBarButtonItemStylePlain target:self action:@selector(memberDetail)];
    [rightButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    NSArray *segmentTitles = @[@"绑定会员卡", @"申请会员卡"];
    _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    _segmentControl.titles = segmentTitles;
    _segmentControl.delegate = self;
    _segmentControl.hasLine = YES;
    _segmentControl.selectedIndex = 0;
    _segmentControl.backgroundColor = [UIColor whiteColor];
    _segmentControl.layer.borderColor = [BACKGROUND_COLOR CGColor];
    _segmentControl.layer.borderWidth = 1.0f;
    [self.segmentView addSubview:_segmentControl];
    
    _bindMemberCardView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 225);
    _registerMemberCardView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 435);
    
    _scrollView.contentSize = _bindMemberCardView.frame.size;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView addSubview:_bindMemberCardView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.backgroundColor = BACKGROUND_COLOR;
    
    _infoArr = [@[
                  @{@"title": @"姓名", @"subTitle": @"孙悟空"},
                  @{@"title": @"姓别", @"subTitle": @"男"},
                  @{@"title": @"生日", @"subTitle": @"1990-01-01"},
                  @{@"title": @"手机号", @"subTitle": @"15757821451"},
                  @{@"title": @"卡费", @"subTitle": @"30元"},
                  @{@"title": @"有效期至", @"subTitle": @"2016-10-01"},
                  @{@"title": @"支付方式", @"subTitle": @"支付宝"}
                  ] mutableCopy];
}

#pragma mark - 按钮事件

- (void)memberDetail {
    
}

- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    if (item.tag == 0) {
        [_registerMemberCardView removeFromSuperview];
        _scrollView.contentSize = _bindMemberCardView.frame.size;
        [_scrollView addSubview:_bindMemberCardView];
    } else if (item.tag == 1) {
        [_bindMemberCardView removeFromSuperview];
        _scrollView.contentSize = _registerMemberCardView.frame.size;
        [_scrollView addSubview:_registerMemberCardView];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_phoneNumberTextField resignFirstResponder];
    [_memberCardNumberTextField resignFirstResponder];
    [_verifyTextField resignFirstResponder];
}

#pragma mark - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = _infoArr[indexPath.row];
    cell.textLabel.text = info[@"title"];
    cell.detailTextLabel.text = info[@"subTitle"];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

@end
