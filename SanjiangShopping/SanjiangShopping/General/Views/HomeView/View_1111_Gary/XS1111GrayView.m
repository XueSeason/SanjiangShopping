//
//  XS1111GrayView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/24.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XS1111GrayView.h"
#import "ThemeColor.h"
#import "UtilsMacro.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>

@interface XS1111GrayView ()

@property (strong, nonatomic) UILabel     *tagLabel;
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *moreLabel;
@property (strong, nonatomic) UIImageView *moreImageView;

@property (strong, nonatomic) UIView      *mainView;
@property (strong, nonatomic) UIImageView *imageView0;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;


@end

@implementation XS1111GrayView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _mainView                 = [[UIView alloc] init];
        _mainView.backgroundColor = BACKGROUND_COLOR;
        _mainView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        _control0 = [[UIControl alloc] init];
        _control1 = [[UIControl alloc] init];
        _control2 = [[UIControl alloc] init];
        _control3 = [[UIControl alloc] init];
        
        _control0.backgroundColor  = [UIColor whiteColor];
        _control1.backgroundColor  = [UIColor whiteColor];
        _control2.backgroundColor  = [UIColor whiteColor];
        _control3.backgroundColor  = [UIColor whiteColor];
        
        _control0.translatesAutoresizingMaskIntoConstraints = NO;
        _control1.translatesAutoresizingMaskIntoConstraints = NO;
        _control2.translatesAutoresizingMaskIntoConstraints = NO;
        _control3.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_mainView addSubview:_control0];
        [_mainView addSubview:_control1];
        [_mainView addSubview:_control2];
        [_mainView addSubview:_control3];
        
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
        
        NSDictionary *nameMap = @{
                                  @"v0": _control0,
                                  @"v1": _control1,
                                  @"v2": _control2,
                                  @"v3": _control3
                                  };
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v0(==v1)]-2-[v1(==v0)]-0-|" options:0 metrics:nil views:nameMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v2(==v3)]-2-[v3(==v2)]-0-|" options:0 metrics:nil views:nameMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v0(==v2)]-2-[v2(==v0)]-0-|" options:0 metrics:nil views:nameMap]];
        [_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v1(==v3)]-2-[v3(==v1)]-0-|" options:0 metrics:nil views:nameMap]];
        
        [self layoutIfNeeded];
        
        _imageView0 = [[UIImageView alloc] init];
        _imageView1 = [[UIImageView alloc] init];
        _imageView2 = [[UIImageView alloc] init];
        _imageView3 = [[UIImageView alloc] init];
        
        _imageView0.frame = _control0.bounds;
        _imageView1.frame = _control1.bounds;
        _imageView2.frame = _control2.bounds;
        _imageView3.frame = _control3.bounds;
        
        [_control0 addSubview:_imageView0];
        [_control1 addSubview:_imageView1];
        [_control2 addSubview:_imageView2];
        [_control3 addSubview:_imageView3];
        
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
    
    [_imageView0 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[0] img]]];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[1] img]]];
    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[2] img]]];
    [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[3] img]]];
}
@end
