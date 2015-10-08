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
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        self.layer.borderWidth = 0.5f;
        
        _mainView                 = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        _tagLabel      = [[UILabel alloc] init];
        _titleLabel    = [[UILabel alloc] init];
        _moreLabel     = [[UILabel alloc] init];
        _moreImageView = [[UIImageView alloc] init];
        
        _titleLabel.font          = [_moreLabel.font fontWithSize:16.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _moreLabel.text          = @"更多";
        _moreLabel.font          = [_moreLabel.font fontWithSize:13.0];
        _moreLabel.textColor     = [UIColor grayColor];
        _moreLabel.textAlignment = NSTextAlignmentRight;
        
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"arrow"];
        _moreImageView.contentMode = UIViewContentModeCenter;
        
        _tagLabel.translatesAutoresizingMaskIntoConstraints      = NO;
        _titleLabel.translatesAutoresizingMaskIntoConstraints    = NO;
        _moreLabel.translatesAutoresizingMaskIntoConstraints     = NO;
        _moreImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _moreControl = [[UIControl alloc] init];
        _moreControl.translatesAutoresizingMaskIntoConstraints  = NO;
        [_moreControl addSubview:_tagLabel];
        [_moreControl addSubview:_titleLabel];
        [_moreControl addSubview:_moreLabel];
        [_moreControl addSubview:_moreImageView];
        [self addSubview:_moreControl];
        [self addSubview:_mainView];
        
        // 自动布局
        NSDictionary *mainMap = @{
                                  @"title": _moreControl,
                                  @"main": _mainView
                                  };
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[title]-0-|" options:0 metrics:nil views:mainMap]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title(==40)]-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
        
        NSDictionary *titleMap = @{
                                   @"tag": _tagLabel,
                                   @"title": _titleLabel,
                                   @"more": _moreLabel,
                                   @"moreImage": _moreImageView
                                   };
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tag(==5)]-10-[title(==100)]" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[more(==50)]-0-[moreImage(==20)]-15-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tag]-10-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title]-0-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[more]-0-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moreImage]-0-|" options:0 metrics:nil views:titleMap]];
        
        // main view
        _nameLabel     = [[UILabel alloc] init];
        _priceNowLabel = [[UILabel alloc] init];
        _priceOldLabel = [[UILabel alloc] init];
        _picture       = [[UIImageView alloc] init];
        _countDownView = [[UIView alloc] init];
        
        _nameLabel.font          = [_nameLabel.font fontWithSize:14.0];
        _nameLabel.numberOfLines = 2;
        _priceNowLabel.font      = [_priceNowLabel.font fontWithSize:19.0];
        _priceOldLabel.font      = [_priceOldLabel.font fontWithSize:12.0];
        _priceNowLabel.textAlignment = NSTextAlignmentLeft;
        _priceOldLabel.textAlignment = NSTextAlignmentLeft;
        _priceNowLabel.adjustsFontSizeToFitWidth = YES;
        _priceOldLabel.adjustsFontSizeToFitWidth = YES;
        _picture.contentMode = UIViewContentModeScaleAspectFit;
        
        _nameLabel.textColor = UIColorFromRGB(0x333333, 1.0);
        _priceNowLabel.textColor = UIColorFromRGB(0xf03838, 1.0);
        _priceOldLabel.textColor = UIColorFromRGB(0xaaaaaa, 1.0);
        
        _nameLabel.translatesAutoresizingMaskIntoConstraints     = NO;
        _priceOldLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceNowLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _picture.translatesAutoresizingMaskIntoConstraints       = NO;
        _countDownView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_mainView addSubview:_nameLabel];
        [_mainView addSubview:_priceNowLabel];
        [_mainView addSubview:_priceOldLabel];
        [_mainView addSubview:_picture];
        [_mainView addSubview:_countDownView];
        
        NSDictionary *buyNowMap = @{
                                    @"name": _nameLabel,
                                    @"now": _priceNowLabel,
                                    @"old": _priceOldLabel,
                                    @"img": _picture,
                                    @"count": _countDownView
                                    };
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[name]-25-[img(==90)]-15-|" options:0 metrics:nil views:buyNowMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[now(==60)]-0-[old]-25-[img(==90)]-15-|" options:0 metrics:nil views:buyNowMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[count]-25-[img(==90)]-15-|" options:0 metrics:nil views:buyNowMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[name(==21)]-[now(==count)]-0-[count]-15-|" options:0 metrics:nil views:buyNowMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[name(==21)]-[old(==count)]-0-[count]-15-|" options:0 metrics:nil views:buyNowMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[img]-15-|" options:0 metrics:nil views:buyNowMap]];
        
        UIImageView *countDownImageView  = [[UIImageView alloc] init];
        UILabel *countDownDescLabel      = [[UILabel alloc] init];
        _countDownLabel = [[XSCountDownLabel alloc] init];
        
        countDownImageView.translatesAutoresizingMaskIntoConstraints = NO;
        countDownDescLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _countDownLabel.translatesAutoresizingMaskIntoConstraints    = NO;
        
        [_countDownView addSubview:countDownImageView];
        [_countDownView addSubview:countDownDescLabel];
        [_countDownView addSubview:_countDownLabel];
        
        NSDictionary *countDownMap = @{
                                       @"img": countDownImageView,
                                       @"desc": countDownDescLabel,
                                       @"label": _countDownLabel
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
    return self;
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
