//
//  XSFreshFoodViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/29.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSFreshFoodViewController.h"
#import "ThemeColor.h"
#import "XSNavigationBarHelper.h"

#import "XSRecomendScrollView.h"
#import "XSSegmentControl.h"
#import "XSCommodityListTableViewCell.h"

static NSString * const cellID = @"freshFoodList";

@interface XSFreshFoodViewController () <UIScrollViewDelegate, XSSegmentControlDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *headerImageView;

@property (nonatomic, strong) XSRecomendScrollView *recommendView;
@property (nonatomic, strong) UIView               *freshFoodView;

@property (strong, nonatomic) UIScrollView     *segmentScrollView;
@property (strong, nonatomic) XSSegmentControl *segmentControl;
@property (strong, nonatomic) UITableView      *freshFoodTableView;

@property (strong, nonatomic) XSNavigationBarHelper *navHelper;

@end

@implementation XSFreshFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"生鲜超市";
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    rightButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.navHelper._UINavigationBarBackground.backgroundColor = THEME_WHITE_TRANSPARENT;
    self.navHelper._UIBackdropEffectView.hidden = YES;
    self.navHelper.UIImageView.hidden = YES; // 去除UIImageView带来的线框
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.delegate                       = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.backgroundColor                = BACKGROUND_COLOR;
    _scrollView.bounces                        = NO;
    
    CGFloat scrollWidth  = _scrollView.frame.size.width;
    CGFloat contentHight = 0.0f;
    
    // 加载头
    CGRect headerFrame = CGRectMake(0, 0, scrollWidth, scrollWidth / 75.0 * 41.0);
    _headerImageView   = [[UIImageView alloc] initWithFrame:headerFrame];
    _headerImageView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_headerImageView];
    contentHight += headerFrame.size.height;
    
    // 加载推荐视图
    CGRect recommendFrame = CGRectMake(0, headerFrame.size.height + headerFrame.origin.y, scrollWidth, 44);
    UIView *temp = [[[NSBundle mainBundle] loadNibNamed:@"FreshFoodRecommendView" owner:self options:nil] objectAtIndex:0];
    temp.frame = recommendFrame;
    [_scrollView addSubview:temp];
    contentHight += recommendFrame.size.height;
    
    CGRect recommendViewFrame = CGRectMake(0, recommendFrame.size.height + recommendFrame.origin.y, scrollWidth, scrollWidth / 75.0 * 34.0 );
    _recommendView = [[XSRecomendScrollView alloc] initWithFrame:recommendViewFrame];
//    tempView.floorModel = floor;
    [_scrollView addSubview:_recommendView];
    contentHight += recommendViewFrame.size.height;
    
    // 精品生鲜
    CGRect goodFrame = CGRectMake(0, recommendViewFrame.size.height + recommendViewFrame.origin.y, scrollWidth, 44);
    UIView *goodTemp = [[[NSBundle mainBundle] loadNibNamed:@"FreshFoodGoodView" owner:self options:nil] objectAtIndex:0];
    goodTemp.frame = goodFrame;
    [_scrollView addSubview:goodTemp];
    contentHight += goodFrame.size.height;
    
    CGRect freshFoodViewFrame = CGRectMake(0, goodFrame.size.height + goodFrame.origin.y, scrollWidth, [UIScreen mainScreen].bounds.size.height - 64);
    _freshFoodView = [[UIView alloc] initWithFrame:freshFoodViewFrame];
    _freshFoodView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_freshFoodView];
    contentHight += freshFoodViewFrame.size.height;
    
    NSArray *segmentTitles = @[@"优选水果", @"新鲜蔬菜", @"海鲜鱼肉", @"禽蛋干货", @"超级好吃", @"山珍海味", @"泪流满面", @"再来一桶", @"无与伦比"];
    if (segmentTitles.count > 4) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width / 4.0 * segmentTitles.count;
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    } else {
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    }
    _segmentControl.titles   = segmentTitles;
    _segmentControl.delegate = self;
    _segmentControl.hasLine  = YES;
    _segmentControl.selectedIndex     = 0;
    _segmentControl.backgroundColor   = [UIColor whiteColor];
    _segmentControl.layer.borderColor = [BACKGROUND_COLOR CGColor];
    _segmentControl.layer.borderWidth = 1.0f;
    
    _segmentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    _segmentScrollView.showsVerticalScrollIndicator   = NO;
    _segmentScrollView.showsHorizontalScrollIndicator = NO;
    _segmentScrollView.bounces                        = NO;
    _segmentScrollView.contentSize                    = _segmentControl.bounds.size;
    
    [_freshFoodView addSubview:_segmentScrollView];
    [_segmentScrollView addSubview:_segmentControl];
    
    // 生鲜列表
    CGRect tableViewFrame = CGRectMake(0, _segmentScrollView.frame.origin.y + _segmentScrollView.frame.size.height, _freshFoodView.frame.size.width, _freshFoodView.frame.size.height - _segmentScrollView.frame.origin.y - _segmentScrollView.frame.size.height);
    _freshFoodTableView = [[UITableView alloc] initWithFrame:tableViewFrame];
    _freshFoodTableView.bounces       = NO;
    _freshFoodTableView.delegate      = self;
    _freshFoodTableView.dataSource    = self;
    _freshFoodTableView.scrollEnabled = NO;
    _freshFoodTableView.showsHorizontalScrollIndicator = NO;
    _freshFoodTableView.showsVerticalScrollIndicator   = NO;
    [_freshFoodTableView registerClass:[XSCommodityListTableViewCell class] forCellReuseIdentifier:cellID];
    [_freshFoodTableView registerNib:[UINib nibWithNibName:@"XSCommodityListTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    [_freshFoodView addSubview:_freshFoodTableView];
    
    _scrollView.contentSize = CGSizeMake(scrollWidth, contentHight);
    [self.view addSubview:_scrollView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    // 取消滚动视图相对导航栏自动调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 隐藏TabBar
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (XSNavigationBarHelper *)navHelper {
    if (_navHelper == nil) {
        _navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
        [_navHelper peek];
    }
    return _navHelper;
}

#pragma mark - Button Click
- (void)share {
    NSLog(@"share");
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSCommodityListTableViewCell *cell = (XSCommodityListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BACKGROUND_COLOR;
    return cell;
}

#pragma mark - Table View Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    XSCommodityViewController *viewController = [[XSCommodityViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat offset = _scrollView.contentOffset.y;
    CGFloat tail = _scrollView.contentSize.height - _freshFoodView.frame.size.height - 64;
    if (offset < tail) {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_WHITE_FADE(offset / tail);
        _freshFoodTableView.scrollEnabled = NO;
    } else {
        self.navHelper._UINavigationBarBackground.backgroundColor = THEME_WHITE_FADE(1.0);
        _freshFoodTableView.scrollEnabled = YES;
    }
}

#pragma mark - SegmentControl Delegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    if (item.frame.origin.x < _segmentControl.frame.size.width -  3 * item.frame.size.width && item.frame.origin.x >= 3 * item.frame.size.width) {
        CGPoint point = CGPointMake(item.frame.origin.x - 2 * item.frame.size.width, item.frame.origin.y);
        [_segmentScrollView setContentOffset:point animated:YES];
    } else if (item.frame.origin.x == _segmentControl.frame.size.width -  3 * item.frame.size.width) {
        CGPoint point = CGPointMake(item.frame.origin.x - item.frame.size.width, item.frame.origin.y);
        [_segmentScrollView setContentOffset:point animated:YES];
    } else if (item.frame.origin.x < 3 * item.frame.size.width) {
        [_segmentScrollView setContentOffset:_segmentScrollView.frame.origin animated:YES];
    }
}

@end
