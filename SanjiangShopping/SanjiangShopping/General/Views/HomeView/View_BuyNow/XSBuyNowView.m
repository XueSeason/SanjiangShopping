//
//  XSBuyNowView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/24.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSBuyNowView.h"
#import "ThemeColor.h"
#import "UtilsMacro.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>
#import "XSCountDownLabel.h"

@interface XSBuyNowView ()
@property (strong, nonatomic) UILabel     *tagLabel;
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *moreLabel;
@property (strong, nonatomic) UIImageView *moreImageView;

@property (strong, nonatomic) UIView           *mainView;
@property (strong, nonatomic) UILabel          *nameLabel;
@property (strong, nonatomic) UILabel          *priceNowLabel;
@property (strong, nonatomic) UILabel          *priceOldLabel;
@property (strong, nonatomic) UIImageView      *picture;
@property (strong, nonatomic) UIView           *countDownView;
@property (strong, nonatomic) XSCountDownLabel *countDownLabel;

@end

@implementation XSBuyNowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor   = [UIColor whiteColor];
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        self.layer.borderWidth = 0.5f;
        
        [self.moreControl addSubview:self.tagLabel];
        [self.moreControl addSubview:self.titleLabel];
        [self.moreControl addSubview:self.moreLabel];
        [self.moreControl addSubview:self.moreImageView];
        [self.moreControl addSubview:self.countDownView];
        [self addSubview:self.moreControl];
        [self addSubview:self.mainView];
        
        [self.mainView addSubview:self.nameLabel];
        [self.mainView addSubview:self.priceNowLabel];
        [self.mainView addSubview:self.priceOldLabel];
        [self.mainView addSubview:self.picture];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSDictionary *mainMap = @{
                              @"title": self.moreControl,
                              @"main":  self.mainView
                              };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[title]-0-|" options:0 metrics:nil views:mainMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title(==40)]-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
    
    NSDictionary *titleMap = @{
                               @"tag":       self.tagLabel,
                               @"title":     self.titleLabel,
                               @"more":      self.moreLabel,
                               @"moreImage": self.moreImageView,
                               @"count":     self.countDownView
                               };
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tag(==5)]-10-[title]-10-[count(==180)]" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[more(==50)]-0-[moreImage(==20)]-15-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tag]-10-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title]-0-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[more]-0-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moreImage]-0-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[count]-0-|" options:0 metrics:nil views:titleMap]];
    
    NSDictionary *buyNowMap = @{
                                @"name": self.nameLabel,
                                @"pn":   self.priceNowLabel,
                                @"po":   self.priceOldLabel,
                                @"img":  self.picture
                                };
    [self.mainView addConstraint:[NSLayoutConstraint constraintWithItem:self.picture attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.picture attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[img]-[name]-15-|" options:0 metrics:nil views:buyNowMap]];
//    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[img]-[]" options:0 metrics:nil views:buyNowMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[img]-[pn]-[po]" options:0 metrics:nil views:buyNowMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[img]-|" options:0 metrics:nil views:buyNowMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[name]-[pn]-|" options:0 metrics:nil views:buyNowMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[name]-[po]-|" options:0 metrics:nil views:buyNowMap]];
    
    
}

#pragma mark - getters and setters
- (UIControl *)moreControl {
    if (_moreControl == nil) {
        _moreControl = [[UIControl alloc] init];
        _moreControl.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _moreControl;
}

- (UIView *)mainView {
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _mainView;
}

- (UILabel *)tagLabel {
    if (_tagLabel == nil) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _tagLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font          = [_moreLabel.font fontWithSize:16.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _titleLabel;
}

- (UILabel *)moreLabel {
    if (_moreLabel == nil) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.text          = @"更多";
        _moreLabel.font          = [_moreLabel.font fontWithSize:13.0];
        _moreLabel.textColor     = [UIColor grayColor];
        _moreLabel.textAlignment = NSTextAlignmentRight;
        
        _moreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _moreLabel;
}

- (UIImageView *)moreImageView {
    if (_moreImageView == nil) {
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"arrow"];
        _moreImageView.contentMode = UIViewContentModeCenter;
        
        _moreImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _moreImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [_nameLabel.font fontWithSize:14.0];
        _nameLabel.numberOfLines = 2;
        _nameLabel.textColor     = UIColorFromRGB(0x333333, 1.0);
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameLabel;
}

- (UILabel *)priceNowLabel {
    if (_priceNowLabel == nil) {
        _priceNowLabel = [[UILabel alloc] init];
        _priceNowLabel.font = [_priceNowLabel.font fontWithSize:19.0];
        _priceNowLabel.textAlignment = NSTextAlignmentLeft;
        _priceNowLabel.adjustsFontSizeToFitWidth = YES;
        _priceNowLabel.textColor = UIColorFromRGB(0xf03838, 1.0);
        _priceNowLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceNowLabel;
}

- (UILabel *)priceOldLabel {
    if (_priceOldLabel == nil) {
        _priceOldLabel = [[UILabel alloc] init];
        _priceOldLabel.font = [_priceOldLabel.font fontWithSize:12.0];
        _priceOldLabel.textAlignment = NSTextAlignmentLeft;
        _priceOldLabel.adjustsFontSizeToFitWidth = YES;
        _priceOldLabel.textColor = UIColorFromRGB(0xaaaaaa, 1.0);
        _priceOldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _priceOldLabel;
}

- (UIImageView *)picture {
    if (_picture == nil) {
        _picture = [[UIImageView alloc] init];
        _picture.contentMode = UIViewContentModeScaleAspectFit;
        _picture.translatesAutoresizingMaskIntoConstraints = NO;
        
        _picture.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _picture.layer.cornerRadius = 3;
        _picture.layer.borderWidth = 0.5f;
        _picture.clipsToBounds = YES;
    }
    return _picture;
}

- (UIView *)countDownView {
    if (_countDownView == nil) {
        _countDownView = [[UIView alloc] init];
        _countDownView.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIImageView *countDownImageView  = [[UIImageView alloc] init];
        UILabel *countDownDescLabel      = [[UILabel alloc] init];
        
        countDownImageView.translatesAutoresizingMaskIntoConstraints = NO;
        countDownDescLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_countDownView addSubview:countDownImageView];
        [_countDownView addSubview:countDownDescLabel];
        [_countDownView addSubview:self.countDownLabel];
        
        NSDictionary *countDownMap = @{
                                       @"img": countDownImageView,
                                       @"desc": countDownDescLabel,
                                       @"label": self.countDownLabel
                                       };
        [_countDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[img(==20)]-0-[desc(==65)]-0-[label]-0-|" options:0 metrics:nil views:countDownMap]];
        [_countDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[img]-0-|" options:0 metrics:nil views:countDownMap]];
        [_countDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[desc]-0-|" options:0 metrics:nil views:countDownMap]];
        [_countDownView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[label]-0-|" options:0 metrics:nil views:countDownMap]];
        
        countDownImageView.image = [UIImage imageNamed:@"clock"];
        countDownImageView.contentMode = UIViewContentModeLeft;
        countDownDescLabel.text  = @"距秒杀开始:";
        countDownDescLabel.font  = [countDownDescLabel.font fontWithSize:12.0];
    }
    return _countDownView;
}

- (XSCountDownLabel *)countDownLabel {
    if (_countDownLabel == nil) {
        _countDownLabel = [[XSCountDownLabel alloc] init];
        _countDownLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _countDownLabel;
}

- (void)setFloorModel:(FloorModel *)floorModel {
    _floorModel = floorModel;
    
    // 16位字符串转成整型数值
    unsigned colorInt = 0;
    [[NSScanner scannerWithString:[_floorModel.flag substringFromIndex:1]] scanHexInt:&colorInt];
    
    _tagLabel.backgroundColor = UIColorFromRGB(colorInt, 1.0);
    _titleLabel.textColor     = UIColorFromRGB(colorInt, 1.0);
    _titleLabel.text          = _floorModel.title;
    
    _nameLabel.text = [_floorModel.data[0] name];
    _priceNowLabel.text = [NSString stringWithFormat:@"￥%.2f", [[_floorModel.data[0] pn] floatValue]];
    _priceOldLabel.text = [NSString stringWithFormat:@"￥%.2f", [[_floorModel.data[0] po] floatValue]];
    [_picture sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[0] img]]];
    
    [_countDownLabel countDown:3609];
    
    if (_priceOldLabel.text.length != 0) {
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:_priceOldLabel.text];
        [attribute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, _priceOldLabel.text.length)];
        [_priceOldLabel setAttributedText:attribute];
    }
}

@end
