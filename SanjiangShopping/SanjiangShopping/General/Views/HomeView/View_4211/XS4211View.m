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
        
        CGFloat scale = frame.size.width / 75;
        
        CGRect frame0 = CGRectMake(0, 0, 31 * scale, 38 * scale);
        CGRect frame1 = CGRectMake(31 * scale, 0, 44 * scale, 16 * scale);
        CGRect frame2 = CGRectMake(31 * scale, 16 * scale, 22 * scale, 22 * scale);
        CGRect frame3 = CGRectMake(53 * scale, 16 * scale, 22 * scale, 22 * scale);
        
        _control0 = [[UIControl alloc] initWithFrame:frame0];
        _control1 = [[UIControl alloc] initWithFrame:frame1];
        _control2 = [[UIControl alloc] initWithFrame:frame2];
        _control3 = [[UIControl alloc] initWithFrame:frame3];

        [self addSubview:_control0];
        [self addSubview:_control1];
        [self addSubview:_control2];
        [self addSubview:_control3];
        
        _imageView0 = [[UIImageView alloc] initWithFrame:_control0.bounds];
        _imageView1 = [[UIImageView alloc] initWithFrame:_control1.bounds];
        _imageView2 = [[UIImageView alloc] initWithFrame:_control2.bounds];
        _imageView3 = [[UIImageView alloc] initWithFrame:_control3.bounds];
        
        [_control0 addSubview:_imageView0];
        [_control1 addSubview:_imageView1];
        [_control2 addSubview:_imageView2];
        [_control3 addSubview:_imageView3];
        
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        self.layer.borderWidth = 0.5f;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)setFloorModel:(FloorModel *)floorModel {
    _floorModel = floorModel;
    
    [_imageView0 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[0] img]]];
    [_imageView1 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[1] img]]];
    [_imageView2 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[2] img]]];
    [_imageView3 sd_setImageWithURL:[NSURL URLWithString:[_floorModel.data[3] img]]];
    
    NSArray *arr = @[_imageView0, _imageView1, _imageView2, _imageView3];
    for (UIImageView *imageView in arr) {
        CALayer *layer = [imageView layer];
        layer.borderColor = [BACKGROUND_COLOR CGColor];
        layer.borderWidth = 0.5;
    }
}

@end
