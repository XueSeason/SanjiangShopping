//
//  XSBannerView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSBannerView.h"
#import <UIImageView+WebCache.h>
#import "UtilsMacro.h"
#import "HomeModel.h"

#define SCROLL_VIEW_WIDTH  _scrollView.bounds.size.width
#define SCROLL_VIEW_HEIGHT _scrollView.bounds.size.height

// 动画过渡时间
static const CGFloat kAnimationTime = 2.0;

@interface XSBannerView () <UIScrollViewDelegate>
{
    NSTimer *timer;
    // 连续滚动的索引
    NSUInteger leftIndex;
    NSUInteger centerIndex;
    NSUInteger rightIndex;
}
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation XSBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews {
    self.scrollView.frame         = self.bounds;
    self.scrollView.contentOffset = CGPointMake(SCROLL_VIEW_WIDTH, 0);
    self.scrollView.contentSize   = CGSizeMake(SCROLL_VIEW_WIDTH * 3, SCROLL_VIEW_HEIGHT);
    
    self.leftImageView.frame   = CGRectMake(0, 0, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT);
    self.centerImageView.frame = CGRectMake(SCROLL_VIEW_WIDTH, 0, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT);
    self.rightImageView.frame  = CGRectMake(SCROLL_VIEW_WIDTH * 2, 0, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT);
    
    self.pageControl.frame  = CGRectMake(0, 0, 10 * self.pageControl.numberOfPages, 10);
    self.pageControl.center = CGPointMake(SCROLL_VIEW_WIDTH / 2.0, SCROLL_VIEW_HEIGHT - 10);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_animationSwitch) {
        [timer invalidate];
        timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (_animationSwitch) {
        [timer invalidate];
        timer = nil;
        timer = [NSTimer scheduledTimerWithTimeInterval: kAnimationTime
                                                 target: self
                                               selector: @selector(autoScroll)
                                               userInfo: nil
                                                repeats: YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat posX = _scrollView.contentOffset.x;
    
    if (posX == 0) {
        // 左移
        [self moveLeft];
    } else if (posX == SCROLL_VIEW_WIDTH * 2) {
        // 右移
        [self moveRight];
    }
}

#pragma mark - private methods
- (void)moveLeft {
    if (!_dataModels.count) {
        return;
    }
    
    NSUInteger sum = _dataModels.count;
    centerIndex    = (centerIndex + sum - 1) % sum;
    leftIndex      = (leftIndex   + sum - 1) % sum;
    rightIndex     = (rightIndex  + sum - 1) % sum;
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[leftIndex] img]] placeholderImage:nil];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[centerIndex] img]] placeholderImage:nil];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[rightIndex] img]] placeholderImage:nil];
    
    _scrollView.contentOffset = CGPointMake(SCROLL_VIEW_WIDTH, 0);
    _pageControl.currentPage  = centerIndex;
}

- (void)moveRight {
    if (!_dataModels.count) {
        return;
    }
    
    NSUInteger sum = _dataModels.count;
    centerIndex    = (centerIndex + sum + 1) % sum;
    leftIndex      = (leftIndex   + sum + 1) % sum;
    rightIndex     = (rightIndex  + sum + 1) % sum;
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[leftIndex] img]] placeholderImage:nil];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[centerIndex] img]] placeholderImage:nil];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[rightIndex] img]] placeholderImage:nil];
    
    _scrollView.contentOffset = CGPointMake(SCROLL_VIEW_WIDTH, 0);
    _pageControl.currentPage  = centerIndex;
}

- (void)autoScroll {
    [UIView animateWithDuration:0.5 animations:^{
        [_scrollView setContentOffset:CGPointMake(SCROLL_VIEW_WIDTH * 2, 0) animated:NO];
    } completion:^(BOOL finished) {
        [self moveRight];
    }];
}

- (void)click {
    [_delegate bannerViewDidSelected:centerIndex];
    NSLog(@"click %ld", centerIndex);
}

#pragma mark - setters and getters
- (void)setAnimationSwitch:(BOOL)animationSwitch {
    _animationSwitch = animationSwitch;
    if (_animationSwitch) {
        timer = [NSTimer scheduledTimerWithTimeInterval: kAnimationTime
                                                 target: self
                                               selector: @selector(autoScroll)
                                               userInfo: nil
                                                repeats: YES];
    } else {
        [timer invalidate];
        timer = nil;
    }
}

- (void)setDataModels:(NSArray *)dataModels {
    _dataModels = [dataModels copy];
    
    if (_dataModels.count > 1) {
        leftIndex    = _dataModels.count - 1;
        centerIndex  = 0;
        rightIndex   = 1;
    } else {
        leftIndex    = 0;
        centerIndex  = 0;
        rightIndex   = 0;
        self.animationSwitch = NO;
        self.scrollView.scrollEnabled = NO;
        _pageControl.hidden = YES;
    }
    
    _pageControl.numberOfPages = _dataModels.count;
    _pageControl.currentPage   = centerIndex;
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[leftIndex] img]] placeholderImage:nil];
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[centerIndex] img]] placeholderImage:nil];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[rightIndex] img]] placeholderImage:nil];
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate        = self;
        _scrollView.bounces         = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled   = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        
        [_scrollView addSubview:self.leftImageView];
        [_scrollView addSubview:self.centerImageView];
        [_scrollView addSubview:self.rightImageView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = UIColorFromRGB(0xAAAAAA, 0.5);
    }
    return _pageControl;
}

- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView   = [[UIImageView alloc] init];
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView {
    if (_centerImageView == nil) {
        _centerImageView = [[UIImageView alloc] init];
        _centerImageView.userInteractionEnabled = YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];

    }
    return _centerImageView;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView  = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

@end
