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

@interface XSFreshFoodViewController () <UIScrollViewDelegate, XSSegmentControlDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *headerImageView;

@property (nonatomic, strong) XSRecomendScrollView *recommendView;
@property (nonatomic, strong) UIView               *freshFoodView;

@property (strong, nonatomic) UIScrollView     *segmentScrollView;
@property (strong, nonatomic) XSSegmentControl *segmentControl;

@end

@implementation XSFreshFoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"生鲜超市";
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    rightButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
    [navHelper peek];
    navHelper._UINavigationBarBackground.backgroundColor = THEME_RED_TRANSPARENT;
    navHelper._UIBackdropEffectView.hidden = YES;
    navHelper.UIImageView.hidden = YES; // 去除UIImageView带来的线框
    
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
    
    CGRect freshFoodViewFrame = CGRectMake(0, goodFrame.size.height + goodFrame.origin.y, scrollWidth, 800);
    _freshFoodView = [[UIView alloc] initWithFrame:freshFoodViewFrame];
    _freshFoodView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_freshFoodView];
    contentHight += freshFoodViewFrame.size.height;
    
    NSArray *segmentTitles = @[@"优选水果", @"新鲜蔬菜", @"海鲜鱼肉", @"禽蛋干货", @"超级好吃", @"山珍海味", @"泪流满面"];
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

#pragma mark - Button Click
- (void)share {
    NSLog(@"share");
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat offset = _scrollView.contentOffset.y;
    
    if (offset < 255.0) {
        XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:self.navigationController.navigationBar];
        [navHelper peek];
        navHelper._UINavigationBarBackground.backgroundColor = THEME_WHITE_FADE(offset / 255.0);
    }
}

#pragma mark - SegmentControl Delegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    if (item.frame.origin.x < _segmentControl.frame.size.width - _segmentScrollView.frame.size.width) {
        [_segmentScrollView setContentOffset:item.frame.origin animated:YES];
    }
}

@end
