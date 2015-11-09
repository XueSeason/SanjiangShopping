//
//  XSCommodityViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/9.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityViewController.h"
#import "ThemeColor.h"
#import "XSBannerView.h"
#import "XSNameView.h"
#import "XSFeedbackTableViewCell.h"
#import "XSSegmentControl.h"

#import "XSShoppingCartViewController.h"

static NSString * const commodityID = @"info";
static NSString * const feedbackID  = @"feedback";

@interface XSCommodityViewController () <XSBannerViewDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    NSArray *titleArr;
}

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIView   *pannelView;
@property (weak, nonatomic)   IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic)   IBOutlet UIButton *shopCartButton;
@property (weak, nonatomic)   IBOutlet UIButton *buyNowButton;
@property (weak, nonatomic)   IBOutlet UIButton *addToShopCartButton;
@property (weak, nonatomic)   IBOutlet UIView   *favoriteView;
@property (weak, nonatomic)   IBOutlet UIView   *shopCartView;

@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) XSBannerView *bannerView;
@property (strong, nonatomic) XSNameView   *nameView;
@property (strong, nonatomic) UITableView  *commodityInfoView;
@property (strong, nonatomic) UITableView  *feedbackTableView;
@property (strong, nonatomic) UIView       *showMoreDetailView;

@property (strong, nonatomic) UIScrollView *detailScrollView;
@property (strong, nonatomic) XSSegmentControl *segmentControl;

@end

@implementation XSCommodityViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.frame       = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 2);
    self.mainScrollView.frame   = [UIScreen mainScreen].bounds;
    self.detailScrollView.frame = CGRectMake(0, self.mainScrollView.frame.size.height + self.mainScrollView.frame.origin.y, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
    
    self.scrollView.contentSize   = CGSizeMake(self.detailScrollView.frame.size.width, self.detailScrollView.frame.origin.y + self.detailScrollView.frame.size.height);
    self.detailScrollView.contentSize = CGSizeMake(self.detailScrollView.frame.size.width, self.detailScrollView.frame.size.height + 1);
    
    self.pannelView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 50, self.view.frame.size.width, 50);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customNavigationBar];
    
    [self.scrollView addSubview:self.mainScrollView];
    [self.scrollView addSubview:self.detailScrollView];
    [self.view addSubview:self.scrollView];

    // 设置购物面板
    [self.view addSubview:self.pannelView];
    
    CGFloat step = 9.0f;
    CGFloat contentHeigth = 64.0f;
    // 展示图片视图
    _bannerView = [[XSBannerView alloc] initWithFrame:CGRectMake(0, contentHeigth, self.view.frame.size.width, self.view.frame.size.width / 75.0 * 62.0)];
    _bannerView.delegate = self;
    [_mainScrollView addSubview:_bannerView];
    contentHeigth += _bannerView.frame.size.height;
    
    // 标题视图
    _nameView = [[XSNameView alloc] initWithFrame:CGRectMake(0, contentHeigth, self.view.frame.size.width, self.view.frame.size.width / 25.0 * 9.0)];
    _nameView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:_nameView];
    contentHeigth += _nameView.frame.size.height + step;
    
    // 购买信息视图
    _commodityInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, contentHeigth, self.view.frame.size.width, 135.0)];
    _commodityInfoView.tag             = 0;
    _commodityInfoView.backgroundColor = [UIColor whiteColor];
    _commodityInfoView.delegate        = self;
    _commodityInfoView.dataSource      = self;
    titleArr = @[@"促销", @"送至", @"已选"];
    [_mainScrollView addSubview:_commodityInfoView];
    contentHeigth += _commodityInfoView.frame.size.height + step;
    _commodityInfoView.layer.borderWidth = 0.5f;
    _commodityInfoView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    
    // 评论视图
    _feedbackTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, contentHeigth, self.view.frame.size.width, 358)];
    _feedbackTableView.tag             = 1;
    _feedbackTableView.backgroundColor = [UIColor whiteColor];
    _feedbackTableView.delegate        = self;
    _feedbackTableView.dataSource      = self;
    [_feedbackTableView registerClass:[XSFeedbackTableViewCell class] forCellReuseIdentifier:feedbackID];
    [_feedbackTableView registerNib:[UINib nibWithNibName:@"XSFeedbackTableViewCell" bundle:nil] forCellReuseIdentifier:feedbackID];
    [_mainScrollView addSubview:_feedbackTableView];
    contentHeigth += _feedbackTableView.frame.size.height + step;
    _feedbackTableView.layer.borderWidth = 0.5f;
    _feedbackTableView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    
    // 商品推荐视图
    
    // 上拉显示图文详情
    _showMoreDetailView = [[UIView alloc] initWithFrame:CGRectMake(0, contentHeigth, self.view.frame.size.width, 45)];
    _showMoreDetailView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:_showMoreDetailView];
    contentHeigth += _showMoreDetailView.frame.size.height;
    UIView *tempMoreView = [[[NSBundle mainBundle] loadNibNamed:@"MoreDetailView" owner:self options:nil] objectAtIndex:0];
    tempMoreView.frame = _showMoreDetailView.bounds;
    [_showMoreDetailView addSubview:tempMoreView];
    
    contentHeigth += 50.0;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, contentHeigth);
    
    
    // 商品详情页
    NSArray *segmentTitles = @[@"商品介绍", @"规格参数", @"包装售后"];
    _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 44)];
    _segmentControl.titles = segmentTitles;
//    _segmentControl.delegate = self;
    _segmentControl.hasLine = YES;
    _segmentControl.selectedIndex = 0;
    _segmentControl.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    _segmentControl.layer.borderWidth = 1.0f;
    [_detailScrollView addSubview:_segmentControl];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
    }
    return _scrollView;
}

- (UIScrollView *)mainScrollView {
    if (_mainScrollView == nil) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (UIScrollView *)detailScrollView {
    if (_detailScrollView == nil) {
        _detailScrollView = [[UIScrollView alloc] init];
        _detailScrollView.showsHorizontalScrollIndicator = NO;
        _detailScrollView.showsVerticalScrollIndicator   = NO;
        _detailScrollView.delegate = self;
    }
    return _detailScrollView;
}

- (UIView *)pannelView {
    if (_pannelView == nil) {
        _pannelView = [[[NSBundle mainBundle] loadNibNamed:@"BuyPannel" owner:self options:nil] objectAtIndex:0];
        _pannelView.layer.borderWidth   = 0.5f;
        _pannelView.layer.borderColor   = [OTHER_SEPARATOR_COLOR CGColor];
        _favoriteView.layer.borderWidth = 0.5f;
        _favoriteView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        _shopCartView.layer.borderWidth = 0.5f;
        _shopCartView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    }
    return _pannelView;
}

//- (XSBannerView *)bannerView {
//    if (_bannerView == nil) {
//        _bannerView = [[XSBannerView alloc] init];
//        _bannerView.delegate = self;
//    }
//    return _bannerView;
//}
//
//- (XSNameView *)nameView {
//    if (_nameView == nil) {
//        _nameView = [[XSNameView alloc] init];
//        _nameView.backgroundColor = [UIColor whiteColor];
//    }
//    return _nameView;
//}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"商品详情";
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - button click
- (IBAction)addToFavorite:(UIButton *)sender {
}

- (IBAction)enterShoppingCart:(UIButton *)sender {
    XSShoppingCartViewController *shoppingCartViewController = [[XSShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCartViewController animated:YES];
}

- (IBAction)buyNow:(UIButton *)sender {
}

- (IBAction)addToShoppingCart:(UIButton *)sender {
}

#pragma mark - Banner View Delegate
- (void)bannerViewDidSelected:(NSInteger)index {
    NSLog(@"%ld is clicked", index);
}

#pragma mark - Table View Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        return titleArr.count;
    } else if (tableView.tag == 1) {
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commodityID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:commodityID];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        
        cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text            = titleArr[indexPath.row];
        cell.textLabel.textColor       = SUB_TITLE_COLOR;
        cell.textLabel.font            = [cell.textLabel.font fontWithSize:12.0];
        cell.detailTextLabel.text      = @"测试信息测试信息测试信息测试信息测试信息测试信息";
        cell.detailTextLabel.font      = [cell.detailTextLabel.font fontWithSize:14.0];
        cell.detailTextLabel.textColor = MAIN_TITLE_COLOR;
        
        return cell;
    } else if (tableView.tag == 1) {
        XSFeedbackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:feedbackID forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        return 45.0;
    } else if (tableView.tag == 1) {
        return 90.0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return 44.0;
    }
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return 44.0;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        UIView *header           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        UILabel *titleLabel      = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 135, 44)];
        titleLabel.text          = @"评论（24569评论）";
        titleLabel.font          = [titleLabel.font fontWithSize:12.0];
        titleLabel.textColor     = SUB_TITLE_COLOR;
        
        header.backgroundColor   = [UIColor whiteColor];
        [header addSubview:titleLabel];
        header.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        header.layer.borderWidth = 0.5f;
        return header;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        UIView *footer           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        UILabel *titleLabel      = [[UILabel alloc] initWithFrame:footer.bounds];
        titleLabel.text          = @"查看更多评论";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font          = [titleLabel.font fontWithSize:14.0];
        titleLabel.textColor     = SUB_TITLE_COLOR;
        
        footer.backgroundColor   = [UIColor whiteColor];
        [footer addSubview:titleLabel];
        footer.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        footer.layer.borderWidth = 0.5f;
        return footer;
    }
    return nil;
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (_mainScrollView.contentOffset.y > _mainScrollView.contentSize.height - [UIScreen mainScreen].bounds.size.height + 40) {
        [_scrollView setContentOffset:_detailScrollView.frame.origin animated:YES];
        self.navigationItem.title = @"图文详情";
    }

    if (_detailScrollView.contentOffset.y < 0.0) {
        [_scrollView setContentOffset:_mainScrollView.frame.origin animated:YES];
        self.navigationItem.title = @"商品详情";
    }
}

@end
