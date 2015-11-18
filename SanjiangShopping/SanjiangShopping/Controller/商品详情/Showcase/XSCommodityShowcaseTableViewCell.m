//
//  XSCommodityShowcaseTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityShowcaseTableViewCell.h"

#import "ThemeColor.h"

#import "XSBannerView.h"

@interface XSCommodityShowcaseTableViewCell () <XSBannerViewDelegate>

@property (strong, nonatomic) XSBannerView *bannerView;

@end

@implementation XSCommodityShowcaseTableViewCell

- (void)awakeFromNib {
    self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.layer.borderWidth = 0.5f;
    
    [self addSubview:self.bannerView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bannerView.frame = self.bounds;
}

#pragma mark - XSBannerViewDelegate
- (void)bannerViewDidSelected:(NSInteger)index {
    
}

#pragma mark - getters and setters
- (XSBannerView *)bannerView {
    if (_bannerView == nil) {
        _bannerView = [[XSBannerView alloc] init];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

@end
