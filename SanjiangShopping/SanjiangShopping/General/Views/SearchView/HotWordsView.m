//
//  HotWordsView.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/31.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "HotWordsView.h"

#import "ThemeColor.h"

#import "HotWordsModel.h"

@interface HotWordsView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation HotWordsView

#pragma mark - private methods

- (void)resetViews {
    
    if (self.subviews.count != 0) {
        [self.subviews[0] removeFromSuperview];
    }
    
    _scrollView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleLabel];
    
    CGFloat x = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + 8;
    for (int i = 0; i < self.dataModel.list.count; i++) {
        
        UIButton *hotButton = [self generateHotButton];
        
        [hotButton setTitle:self.dataModel.list[i] forState:UIControlStateNormal];
        
        CGSize buttonSize = [hotButton sizeThatFits:self.frame.size];
        hotButton.frame   = CGRectMake(x, 8, buttonSize.width + 8, 28);
        
        [self.scrollView addSubview:hotButton];
        
        x = hotButton.frame.origin.x + hotButton.frame.size.width + 8;
    }
    self.scrollView.contentSize = CGSizeMake(x, 28);
}

- (UIButton *)generateHotButton {
    UIButton *hotButton = [[UIButton alloc] init];
    
    [hotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    hotButton.titleLabel.font          = [hotButton.titleLabel.font fontWithSize:12.0];
    hotButton.backgroundColor          = [UIColor whiteColor];
    hotButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    hotButton.layer.cornerRadius = 5.0;
    hotButton.clipsToBounds      = YES;
    
    [hotButton addTarget:self action:@selector(hotWordsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return hotButton;
}

- (void)hotWordsClick:(UIButton *)sender {
    self.hotButtonClickBlock(sender);
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor                = OTHER_SEPARATOR_COLOR;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
    }
    return _scrollView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, 44, 28)];
        _titleLabel.text          = @"热搜";
        _titleLabel.textColor     = THEME_RED;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setDataModel:(HotWordsDataModel *)dataModel {
    _dataModel = dataModel;
    [self resetViews];
}

@end
