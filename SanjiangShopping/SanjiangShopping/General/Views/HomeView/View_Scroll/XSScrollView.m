//
//  XSScrollView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/24.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSScrollView.h"

#import <UIImageView+WebCache.h>

#import "UtilsMacro.h"
#import "ThemeColor.h"

#import "HomeModel.h"

@interface XSScrollView ()

@property (strong, nonatomic) UILabel     *tagLabel;
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *moreLabel;
@property (strong, nonatomic) UIImageView *moreImageView;

@property (strong, nonatomic) UIScrollView *scrollView;
@end

@implementation XSScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _items = [[NSMutableArray alloc] init];
        
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
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_moreControl];
        [self addSubview:_scrollView];

        // 自动布局
        NSDictionary *mainMap = @{
                                  @"title": _moreControl,
                                  @"main": _scrollView
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
        
        [self layoutIfNeeded];
        
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        self.layer.borderWidth = 0.5f;
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
    
}


- (void)layoutSubviews {
    
    // 创建滚动项
    CGFloat side = 90;
    CGFloat x = 0;
    
    for (int i = 0; i < _floorModel.data.count; i++) {
        UIControl *itemView = [[UIControl alloc] initWithFrame:CGRectMake(x, 0, side + 10 + 10, side + 70)];
        [_items addObject:itemView];
        [_scrollView addSubview:itemView];
        x = x + side + 10 + 10;
        
        // 自动布局itemView
        UIImageView *imageView = [[UIImageView alloc] init];
        UILabel *nameLabel     = [[UILabel alloc] init];
        UILabel *priceNowLabel = [[UILabel alloc] init];
        UILabel *priceOldLabel = [[UILabel alloc] init];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[i] img]]];
        nameLabel.text          = [_floorModel.data[i] name];
        priceNowLabel.text = [NSString stringWithFormat:@"￥%.2f", [[_floorModel.data[i] pn] floatValue]];
        if (![_floorModel.data[i] po]) {
            priceOldLabel.hidden = YES;
        } else {
            priceOldLabel.text = [NSString stringWithFormat:@"￥%.2f", [[_floorModel.data[i] po] floatValue]];
            NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:priceOldLabel.text];
            [attribute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, priceOldLabel.text.length)];
            [priceOldLabel setAttributedText:attribute];
        }
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        nameLabel.font              = [nameLabel.font fontWithSize:13.0];
        nameLabel.numberOfLines     = 2;
        nameLabel.textAlignment     = NSTextAlignmentCenter;
        nameLabel.textColor         = UIColorFromRGB(0x333333, 1.0);
        priceNowLabel.textColor     = UIColorFromRGB(0xf03838, 1.0);
        priceNowLabel.textAlignment = NSTextAlignmentLeft;
        priceNowLabel.font          = [priceNowLabel.font fontWithSize:14.0];
        priceNowLabel.adjustsFontSizeToFitWidth = YES;
        priceOldLabel.textColor     = UIColorFromRGB(0xaaaaaa, 1.0);
        priceOldLabel.textAlignment = NSTextAlignmentLeft;
        priceOldLabel.font          = [priceOldLabel.font fontWithSize:10.0];
        priceOldLabel.adjustsFontSizeToFitWidth = YES;
        
        imageView.translatesAutoresizingMaskIntoConstraints     = NO;
        nameLabel.translatesAutoresizingMaskIntoConstraints     = NO;
        priceNowLabel.translatesAutoresizingMaskIntoConstraints = NO;
        priceOldLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [itemView addSubview:imageView];
        [itemView addSubview:nameLabel];
        [itemView addSubview:priceNowLabel];
        [itemView addSubview:priceOldLabel];
        
        NSDictionary *nameMap = @{
                                  @"image": imageView,
                                  @"name": nameLabel,
                                  @"now": priceNowLabel,
                                  @"old": priceOldLabel
                                  };
        
        [itemView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[image]-10-|" options:0 metrics:nil views:nameMap]];
        [itemView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[name]-10-|" options:0 metrics:nil views:nameMap]];
        [itemView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[now(==55)]-0-[old]-10-|" options:0 metrics:nil views:nameMap]];
        [itemView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[image(==90)]-0-[name(==40)]-0-[now]-20-|" options:0 metrics:nil views:nameMap]];
        [itemView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[image(==90)]-0-[name(==40)]-0-[old]-20-|" options:0 metrics:nil views:nameMap]];
        [itemView layoutIfNeeded];
        
        if (i != _floorModel.data.count - 1) {
            CALayer *rightBorder = [CALayer layer];
            rightBorder.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
            rightBorder.borderWidth = 1;
            rightBorder.frame = CGRectMake(CGRectGetWidth(itemView.frame) - 1, 0, 1, 160 - 20);
            [itemView.layer addSublayer:rightBorder];
        }
    }
    
    _scrollView.contentSize = CGSizeMake(x, side);
}

@end
