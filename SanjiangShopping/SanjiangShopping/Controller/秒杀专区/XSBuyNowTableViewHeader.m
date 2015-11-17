//
//  XSBuyNowTableViewHeader.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/17/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSBuyNowTableViewHeader.h"
#import "ThemeColor.h"

@implementation XSBuyNowTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.logo];
        [self addSubview:self.timeLabel];
        [self addSubview:self.descLabel];
        self.backgroundColor = BACKGROUND_COLOR;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSDictionary *nameMap = @{
                              @"img": self.logo,
                              @"time": self.timeLabel,
                              @"desc": self.descLabel
                              };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[img]-[time]" options:0 metrics:nil views:nameMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[desc]-10-|" options:0 metrics:nil views:nameMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[img]-|" options:0 metrics:nil views:nameMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[time]-|" options:0 metrics:nil views:nameMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[desc]-|" options:0 metrics:nil views:nameMap]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.logo attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
}

#pragma mark - getters and setters
- (UIImageView *)logo {
    if (_logo == nil) {
        _logo = [[UIImageView alloc] init];
        _logo.image = [UIImage imageNamed:@"clock"];
        _logo.contentMode = UIViewContentModeCenter;
        _logo.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _logo;
}

- (UILabel *)timeLabel {
    if (_timeLabel == nil) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [_timeLabel.font fontWithSize:14.0];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timeLabel;
}

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[UILabel alloc] init];
        _descLabel = [[UILabel alloc] init];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = [_descLabel.font fontWithSize:14.0];
        _descLabel.textColor = THEME_RED;
        _descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _descLabel;
}

@end
