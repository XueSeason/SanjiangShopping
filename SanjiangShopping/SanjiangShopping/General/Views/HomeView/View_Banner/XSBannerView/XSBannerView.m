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
    // 连续滚动的3个视图
    UIImageView *leftImageView;
    UIImageView *centerImageView;
    UIImageView *rightImageView;
    // 连续滚动的索引
    NSUInteger leftIndex;
    NSUInteger centerIndex;
    NSUInteger rightIndex;
}
@end

@implementation XSBannerView

- (void)layoutSubviews {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate        = self;
    _scrollView.bounces         = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled   = YES;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    
    _scrollView.contentOffset = CGPointMake(SCROLL_VIEW_WIDTH, 0);
    _scrollView.contentSize   = CGSizeMake(SCROLL_VIEW_WIDTH * 3, SCROLL_VIEW_HEIGHT);
    
    leftImageView   = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT)];
    centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLL_VIEW_WIDTH, 0, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT)];
    rightImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCROLL_VIEW_WIDTH * 2, 0, SCROLL_VIEW_WIDTH, SCROLL_VIEW_HEIGHT)];
    
    [_scrollView addSubview:leftImageView];
    [_scrollView addSubview:centerImageView];
    [_scrollView addSubview:rightImageView];
    
    _pageControl        = [[UIPageControl alloc] init];
    _pageControl.frame  = CGRectMake(0, 0, 10 * _pageControl.numberOfPages, 10);
    _pageControl.center = CGPointMake(SCROLL_VIEW_WIDTH / 2.0, SCROLL_VIEW_HEIGHT - 10);
    _pageControl.pageIndicatorTintColor = UIColorFromRGB(0xAAAAAA, 0.5);
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
    
    centerImageView.userInteractionEnabled = YES;
    [centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
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
    
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[leftIndex] img]] placeholderImage:nil];
    [centerImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[centerIndex] img]] placeholderImage:nil];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[rightIndex] img]] placeholderImage:nil];
    
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
    
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[leftIndex] img]] placeholderImage:nil];
    [centerImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[centerIndex] img]] placeholderImage:nil];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[rightIndex] img]] placeholderImage:nil];
    
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
    
    [leftImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[leftIndex] img]] placeholderImage:nil];
    [centerImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[centerIndex] img]] placeholderImage:nil];
    [rightImageView sd_setImageWithURL:[NSURL URLWithString:[_dataModels[rightIndex] img]] placeholderImage:nil];
    
}

@end
