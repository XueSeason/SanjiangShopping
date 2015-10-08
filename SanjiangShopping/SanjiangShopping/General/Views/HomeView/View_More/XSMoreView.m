//
//  XSMoreView.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/28.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSMoreView.h"
#import <UIImageView+WebCache.h>
#import "XSHomeViewController.h"
#import "HomeMoreModel.h"

@interface XSMoreView ()

@property (strong, nonatomic) UIImageView *picture;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UILabel *priceNowLabel;
@property (strong, nonatomic) UILabel *priceOldLabel;

@end

@implementation XSMoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _mainControl = [[UIControl alloc] init];
        _mainControl.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_mainControl];
        NSDictionary *map = @{@"view": _mainControl};
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:map]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:map]];
        [_mainControl layoutIfNeeded];
        
        _picture       = [[UIImageView alloc] init];
        _nameLabel     = [[UILabel alloc] init];
        _subTitleLabel = [[UILabel alloc] init];
        _priceNowLabel = [[UILabel alloc] init];
        _priceOldLabel = [[UILabel alloc] init];
        _shoppingCart  = [[UIButton alloc] init];
        
        _picture.translatesAutoresizingMaskIntoConstraints       = NO;
        _nameLabel.translatesAutoresizingMaskIntoConstraints     = NO;
        _subTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceNowLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _priceOldLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _shoppingCart.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self.mainControl addSubview:_picture];
        [self.mainControl addSubview:_nameLabel];
        [self.mainControl addSubview:_subTitleLabel];
        [self.mainControl addSubview:_priceNowLabel];
        [self.mainControl addSubview:_priceOldLabel];
        [self.mainControl addSubview:_shoppingCart];
        
        NSDictionary *nameMap = @{
                                  @"img": _picture,
                                  @"name": _nameLabel,
                                  @"subTitle": _subTitleLabel,
                                  @"pn": _priceNowLabel,
                                  @"po": _priceOldLabel,
                                  @"shop": _shoppingCart
                                  };
        NSString *horFormat0 = @"H:|-0-[img]-0-|";
        NSString *horFormat1 = @"H:|-8-[name]-8-|";
        NSString *horFormat2 = @"H:|-8-[subTitle]-8-[shop(==44)]-0-|";
        NSString *horFormat3 = @"H:|-8-[pn(==po)]-8-[po(==pn)]-8-[shop(==44)]-0-|";
        
        NSString *verFormat0 = @"V:|-0-[img]-0-[name(==44)]-0-[subTitle(==22)]-0-[pn(==22)]-0-|";
        NSString *verFormat1 = @"V:|-0-[img]-0-[name(==44)]-0-[shop(==44)]-0-|";
        NSString *verFormat2 = @"V:[subTitle]-0-[po]-0-|";
        
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horFormat0 options:0 metrics:nil views:nameMap]];
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horFormat1 options:0 metrics:nil views:nameMap]];
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horFormat2 options:0 metrics:nil views:nameMap]];
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:horFormat3 options:0 metrics:nil views:nameMap]];
        
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verFormat0 options:0 metrics:nil views:nameMap]];
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verFormat1 options:0 metrics:nil views:nameMap]];
        [self.mainControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verFormat2 options:0 metrics:nil views:nameMap]];
        
        [self.mainControl layoutIfNeeded];
        
        // 设置视图属性
        _mainControl.backgroundColor = [UIColor whiteColor];
        CALayer *layer = [_mainControl layer];
        layer.cornerRadius = 5;
        _mainControl.clipsToBounds = YES;
        
        _nameLabel.font = [_nameLabel.font fontWithSize:14.0];
        _nameLabel.numberOfLines = 2;
        
        _subTitleLabel.font = [_subTitleLabel.font fontWithSize:12.0];
        _subTitleLabel.textColor = [UIColor grayColor];
        
        _priceNowLabel.textColor = [UIColor redColor];
        
        _priceOldLabel.textColor = [UIColor grayColor];
        _priceOldLabel.font = [_priceOldLabel.font fontWithSize:12.0];
        
        [_shoppingCart setImage:[UIImage imageNamed:@"ShoppingCart"] forState:UIControlStateNormal];
        _shoppingCart.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

//- (void)setTarget:(id)target {
//    _target = (XSHomeViewController *)target;
////    [_shoppingCart addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:_target action:@selector(addToShoppingCart:)]];
//    [_shoppingCart addTarget:_target action:@selector(addToShoppingCart:) forControlEvents:UIControlEventTouchUpInside];
//}

- (void)setItem:(ListItemModel *)item {
    [_picture sd_setImageWithURL:[NSURL URLWithString:item.img]];
    _nameLabel.text = item.name;
    _subTitleLabel.text = item.subtitle;
    _priceNowLabel.text = [NSString stringWithFormat:@"￥%@", item.pn];
    _priceOldLabel.text = [NSString stringWithFormat:@"￥%@", item.po];
}

@end
