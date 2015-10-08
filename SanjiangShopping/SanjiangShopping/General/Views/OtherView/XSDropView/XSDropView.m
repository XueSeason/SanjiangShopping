//
//  XSDropView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/21.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSDropView.h"

@interface XSDropView ()
@property (assign, nonatomic) CGRect originalFrame;

@end

@implementation XSDropView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _originalFrame       = frame;
        _dropControl         = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_dropControl addTarget:self action:@selector(drop) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_dropControl];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    UILabel *titleLabel  = [[UILabel alloc] init];
    titleLabel.text      = _title;
    titleLabel.font      = [titleLabel.font fontWithSize:14.0];
    titleLabel.textColor = [UIColor darkGrayColor];
    CGSize titleSize     = [titleLabel sizeThatFits:_dropControl.frame.size];
    CGFloat step         = (_dropControl.frame.size.height - titleSize.height) / 2.0;
    titleLabel.frame     = CGRectMake(8, step, titleSize.width, titleSize.height);
    [_dropControl addSubview:titleLabel];
    
    _indicativeView       = [[UIImageView alloc] init];
    _indicativeView.image = [UIImage imageNamed:@"arrow_down"];
    CGFloat x             = _dropControl.frame.size.width - 8 - titleSize.height;
    _indicativeView.frame = CGRectMake(x, step, titleSize.height, titleSize.height);
    [_dropControl addSubview:_indicativeView];
}

- (void)drop {
    if (_dropContentView) {
        [UIView animateWithDuration:0.2 animations:^{
            if (CGAffineTransformEqualToTransform(_indicativeView.transform, CGAffineTransformMakeRotation(0))) {
                _indicativeView.transform = CGAffineTransformMakeRotation(M_PI);
                
                _dropContentView.frame = CGRectMake(0, _dropControl.frame.size.height + _dropControl.frame.origin.y, self.frame.size.width, _contentHeight);
                
                self.frame = CGRectMake(_originalFrame.origin.x, _originalFrame.origin.y, _originalFrame.size.width, _originalFrame.size.height + _contentHeight);
                
            } else {
                _indicativeView.transform = CGAffineTransformMakeRotation(0);
                
                _dropContentView.frame = CGRectMake(0, _dropControl.frame.size.height + _dropControl.frame.origin.y, self.frame.size.width, 0);
                
                self.frame = _originalFrame;
            }
        }];
    }
    
    [_delegate dropDown:_dropContentView];
}

- (void)setDropContentView:(UIView *)dropContentView {
    _dropContentView = dropContentView;
    _dropContentView.frame = CGRectMake(0, _dropControl.frame.size.height + _dropControl.frame.origin.y, self.frame.size.width, 0);
    [self addSubview:_dropContentView];
}

@end
