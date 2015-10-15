//
//  XS1111View.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/24.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XS1111WhiteView.h"
#import "ThemeColor.h"
#import "UtilsMacro.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>

@interface XS1111WhiteView ()

@property (strong, nonatomic) UIView *mainView;

@property (strong, nonatomic) UILabel     *tagLabel;
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *moreLabel;
@property (strong, nonatomic) UIImageView *moreImageView;

@property (strong, nonatomic) UIImageView *imageView0;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;

@end

@implementation XS1111WhiteView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.mainView addSubview:self.control0];
        [self.mainView addSubview:self.control1];
        [self.mainView addSubview:self.control2];
        [self.mainView addSubview:self.control3];
        
        [self addSubview:self.moreControl];
        [self addSubview:self.mainView];
        
        [self.control0 addSubview:self.imageView0];
        [self.control1 addSubview:self.imageView1];
        [self.control2 addSubview:self.imageView2];
        [self.control3 addSubview:self.imageView3];
        
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        self.layer.borderWidth = 0.5f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 自动布局
    NSDictionary *mainMap = @{
                              @"title": self.moreControl,
                              @"main": self.mainView
                              };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[title]-0-|" options:0 metrics:nil views:mainMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title(==40)]-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
    
    NSDictionary *titleMap = @{
                               @"tag": self.tagLabel,
                               @"title": self.titleLabel,
                               @"more": self.moreLabel,
                               @"moreImage": self.moreImageView
                               };
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tag(==5)]-10-[title(==100)]" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[more(==50)]-0-[moreImage(==20)]-15-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tag]-10-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title]-0-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[more]-0-|" options:0 metrics:nil views:titleMap]];
    [self.moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moreImage]-0-|" options:0 metrics:nil views:titleMap]];
    
    NSDictionary *nameMap = @{
                              @"v0": self.control0,
                              @"v1": self.control1,
                              @"v2": self.control2,
                              @"v3": self.control3
                              };
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v0(==v1)]-2-[v1(==v0)]-0-|" options:0 metrics:nil views:nameMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[v2(==v3)]-2-[v3(==v2)]-0-|" options:0 metrics:nil views:nameMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v0(==v2)]-2-[v2(==v0)]-0-|" options:0 metrics:nil views:nameMap]];
    [self.mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[v1(==v3)]-2-[v3(==v1)]-0-|" options:0 metrics:nil views:nameMap]];
    
    [self layoutIfNeeded];
    
    self.imageView0.frame = self.control0.bounds;
    self.imageView1.frame = self.control1.bounds;
    self.imageView2.frame = self.control2.bounds;
    self.imageView3.frame = self.control3.bounds;
}

#pragma mark - getters and setters
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

- (UIView *)mainView {
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        _mainView.translatesAutoresizingMaskIntoConstraints  = NO;
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

- (UIControl *)moreControl {
    if (_moreControl == nil) {
        _moreControl = [[UIControl alloc] init];
        _moreControl.translatesAutoresizingMaskIntoConstraints  = NO;
        [_moreControl addSubview:self.tagLabel];
        [_moreControl addSubview:self.titleLabel];
        [_moreControl addSubview:self.moreLabel];
        [_moreControl addSubview:self.moreImageView];
    }
    return _moreControl;
}

- (UIControl *)control0 {
    if (_control0 == nil) {
        _control0 = [[UIControl alloc] init];
        _control0.backgroundColor  = [UIColor whiteColor];
        _control0.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _control0;
}

- (UIControl *)control1 {
    if (_control1 == nil) {
        _control1 = [[UIControl alloc] init];
        _control1.backgroundColor  = [UIColor whiteColor];
        _control1.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _control1;
}

- (UIControl *)control2 {
    if (_control2 == nil) {
        _control2 = [[UIControl alloc] init];
        _control2.backgroundColor  = [UIColor whiteColor];
        _control2.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _control2;
}

- (UIControl *)control3 {
    if (_control3 == nil) {
        _control3 = [[UIControl alloc] init];
        _control3.backgroundColor  = [UIColor whiteColor];
        _control3.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _control3;
}

- (UIImageView *)imageView0 {
    if (_imageView0 == nil) {
        _imageView0 = [[UIImageView alloc] init];
    }
    return _imageView0;
}

- (UIImageView *)imageView1 {
    if (_imageView1 == nil) {
        _imageView1 = [[UIImageView alloc] init];
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (_imageView2 == nil) {
        _imageView2 = [[UIImageView alloc] init];
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (_imageView3 == nil) {
        _imageView3 = [[UIImageView alloc] init];
    }
    return _imageView3;
}

@end
