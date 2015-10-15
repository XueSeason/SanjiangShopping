//
//  XS4211View.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/23.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XS4211View.h"
#import "ThemeColor.h"

#import "HomeModel.h"

#import <UIImageView+WebCache.h>

@interface XS4211View ()
@property (strong, nonatomic) UIImageView *imageView0;
@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;
@end

@implementation XS4211View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.control0];
        [self addSubview:self.control1];
        [self addSubview:self.control2];
        [self addSubview:self.control3];
        
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
    
    CGFloat scale = self.frame.size.width / 75;
    
    self.control0.frame = CGRectMake(0, 0, 31 * scale, 38 * scale);
    self.control1.frame = CGRectMake(31 * scale, 0, 44 * scale, 16 * scale);
    self.control2.frame = CGRectMake(31 * scale, 16 * scale, 22 * scale, 22 * scale);
    self.control3.frame = CGRectMake(53 * scale, 16 * scale, 22 * scale, 22 * scale);
    
    self.imageView0.frame = self.control0.bounds;
    self.imageView1.frame = self.control1.bounds;
    self.imageView2.frame = self.control2.bounds;
    self.imageView3.frame = self.control3.bounds;
}

#pragma mark - getters and setters
- (void)setFloorModel:(FloorModel *)floorModel {
    _floorModel = floorModel;
    
    [self.imageView0 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[0] img]]];
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[1] img]]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[2] img]]];
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[3] img]]];
}

- (UIControl *)control0 {
    if (_control0 == nil) {
        _control0 = [[UIControl alloc] init];
    }
    return _control0;
}

- (UIControl *)control1 {
    if (_control1 == nil) {
        _control1 = [[UIControl alloc] init];
    }
    return _control1;
}

- (UIControl *)control2 {
    if (_control2 == nil) {
        _control2 = [[UIControl alloc] init];
    }
    return _control2;
}

- (UIControl *)control3 {
    if (_control3 == nil) {
        _control3 = [[UIControl alloc] init];
    }
    return _control3;
}

- (UIImageView *)imageView0 {
    if (_imageView0 == nil) {
        _imageView0 = [[UIImageView alloc] init];
        _imageView0.layer.borderColor = [BACKGROUND_COLOR CGColor];
        _imageView0.layer.borderWidth = 0.5;
    }
    return _imageView0;
}

- (UIImageView *)imageView1 {
    if (_imageView1 == nil) {
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.layer.borderColor = [BACKGROUND_COLOR CGColor];
        _imageView1.layer.borderWidth = 0.5;
    }
    return _imageView1;
}

- (UIImageView *)imageView2 {
    if (_imageView2 == nil) {
        _imageView2 = [[UIImageView alloc] init];
        _imageView2.layer.borderColor = [BACKGROUND_COLOR CGColor];
        _imageView2.layer.borderWidth = 0.5;
    }
    return _imageView2;
}

- (UIImageView *)imageView3 {
    if (_imageView3 == nil) {
        _imageView3 = [[UIImageView alloc] init];
        _imageView3.layer.borderColor = [BACKGROUND_COLOR CGColor];
        _imageView3.layer.borderWidth = 0.5;
    }
    return _imageView3;
}

@end
