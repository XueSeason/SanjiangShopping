//
//  XSButtonGridView.m
//  XSButtonGridView
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSButtonGridView.h"
#import "UtilsMacro.h"
#import <UIButton+WebCache.h>

@interface XSButtonGridView ()

@property (copy, nonatomic)   NSArray *buttons;

@property (copy, nonatomic)   NSArray *buttonViews;
@property (strong, nonatomic) UIView  *buttonView0;
@property (strong, nonatomic) UIView  *buttonView1;
@property (strong, nonatomic) UIView  *buttonView2;
@property (strong, nonatomic) UIView  *buttonView3;
@property (strong, nonatomic) UIView  *buttonView4;
@property (strong, nonatomic) UIView  *buttonView5;
@property (strong, nonatomic) UIView  *buttonView6;
@property (strong, nonatomic) UIView  *buttonView7;

@property (copy, nonatomic)   NSArray *buttonLabels;
@property (strong, nonatomic) UILabel *buttonLabel0;
@property (strong, nonatomic) UILabel *buttonLabel1;
@property (strong, nonatomic) UILabel *buttonLabel2;
@property (strong, nonatomic) UILabel *buttonLabel3;
@property (strong, nonatomic) UILabel *buttonLabel4;
@property (strong, nonatomic) UILabel *buttonLabel5;
@property (strong, nonatomic) UILabel *buttonLabel6;
@property (strong, nonatomic) UILabel *buttonLabel7;

@end

@implementation XSButtonGridView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.buttons      = @[self.button0, self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7];
        self.buttonLabels = @[self.buttonLabel0, self.buttonLabel1, self.buttonLabel2, self.buttonLabel3, self.buttonLabel4, self.buttonLabel5, self.buttonLabel6, self.buttonLabel7];
        self.buttonViews  = @[self.buttonView0, self.buttonView1, self.buttonView2, self.buttonView3, self.buttonView4, self.buttonView5, self.buttonView6, self.buttonView7];
        
        for (int i = 0; i < self.buttonViews.count; i++) {
            UIView *view = self.buttonViews[i];
            [view addSubview:self.buttons[i]];
            [view addSubview:self.buttonLabels[i]];
            [self addSubview:view];
        }
        
        self.buttonLabel0.text = @"新品专区";
        self.buttonLabel1.text = @"生鲜超市";
        self.buttonLabel2.text = @"三江优选";
        self.buttonLabel3.text = @"惠商品";
        self.buttonLabel4.text = @"我的收藏";
        self.buttonLabel5.text = @"订单查询";
        self.buttonLabel6.text = @"我的会员卡";
        self.buttonLabel7.text = @"身边三江";
    }
    return self;
}

- (void)layoutSubviews {
    
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *button = self.buttons[i];
        
        NSDictionary *map = @{
                              @"imageView": button.imageView
                              };
        
        [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:map]];
        [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:map]];
    }
    
    // 自动布局 button 和 label
    NSDictionary *buttonAndLabelNameMap = @{
                                            @"button_0_0": self.button0,
                                            @"button_0_1": self.button1,
                                            @"button_0_2": self.button2,
                                            @"button_0_3": self.button3,
                                            @"button_1_0": self.button4,
                                            @"button_1_1": self.button5,
                                            @"button_1_2": self.button6,
                                            @"button_1_3": self.button7,
                                            @"label_0_0": self.buttonLabel0,
                                            @"label_0_1": self.buttonLabel1,
                                            @"label_0_2": self.buttonLabel2,
                                            @"label_0_3": self.buttonLabel3,
                                            @"label_1_0": self.buttonLabel4,
                                            @"label_1_1": self.buttonLabel5,
                                            @"label_1_2": self.buttonLabel6,
                                            @"label_1_3": self.buttonLabel7
                                            };
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 4; j++) {
            
            NSString *subHorizontalFormat0 = [NSString stringWithFormat:@"H:|-8-[button_%d_%d]-8-|", i, j];
            NSString *subHorizontalFormat1 = [NSString stringWithFormat:@"H:|-0-[label_%d_%d]-0-|", i, j];
            NSString *subVerticalFormat    = [NSString stringWithFormat:@"V:|-4-[button_%d_%d]-4-[label_%d_%d(==15)]-4-|", i, j, i, j];
            NSArray  *subHorizontalConstraints0 = [NSLayoutConstraint constraintsWithVisualFormat:subHorizontalFormat0 options:0 metrics:nil views:buttonAndLabelNameMap];
            NSArray  *subHorizontalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:subHorizontalFormat1 options:0 metrics:nil views:buttonAndLabelNameMap];
            NSArray  *subVerticalContraints     = [NSLayoutConstraint constraintsWithVisualFormat:subVerticalFormat options:0 metrics:nil views:buttonAndLabelNameMap];
            [self.buttonViews[i*4+j] addConstraints:subHorizontalConstraints0];
            [self.buttonViews[i*4+j] addConstraints:subHorizontalConstraints1];
            [self.buttonViews[i*4+j] addConstraints:subVerticalContraints];
        }
    }
    
    // 自动布局 button view
    NSDictionary *buttonViewNameMap = @{
                                        @"buttonView_0_0": self.buttonView0,
                                        @"buttonView_0_1": self.buttonView1,
                                        @"buttonView_0_2": self.buttonView2,
                                        @"buttonView_0_3": self.buttonView3,
                                        @"buttonView_1_0": self.buttonView4,
                                        @"buttonView_1_1": self.buttonView5,
                                        @"buttonView_1_2": self.buttonView6,
                                        @"buttonView_1_3": self.buttonView7
                                        };
    
    NSString *horizontalFormat0 = @"H:|-8-[buttonView_0_0(==buttonView_0_1)]-8-[buttonView_0_1(==buttonView_0_2)]-8-[buttonView_0_2(==buttonView_0_3)]-8-[buttonView_0_3(==buttonView_0_0)]-8-|";
    NSString *horizontalFormat1 = @"H:|-8-[buttonView_1_0(==buttonView_1_1)]-8-[buttonView_1_1(==buttonView_1_2)]-8-[buttonView_1_2(==buttonView_1_3)]-8-[buttonView_1_3(==buttonView_1_0)]-8-|";
    
    NSArray *horizontalConstraints0 = [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat0 options:0 metrics:nil views:buttonViewNameMap];
    NSArray *horizontalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:horizontalFormat1 options:0 metrics:nil views:buttonViewNameMap];
    
    NSString *verticalFormat0 = @"V:|-8-[buttonView_0_0(==buttonView_1_0)]-8-[buttonView_1_0(==buttonView_0_0)]-8-|";
    NSString *verticalFormat1 = @"V:|-8-[buttonView_0_1(==buttonView_1_1)]-8-[buttonView_1_1(==buttonView_0_1)]-8-|";
    NSString *verticalFormat2 = @"V:|-8-[buttonView_0_2(==buttonView_1_2)]-8-[buttonView_1_2(==buttonView_0_2)]-8-|";
    NSString *verticalFormat3 = @"V:|-8-[buttonView_0_3(==buttonView_1_3)]-8-[buttonView_1_3(==buttonView_0_3)]-8-|";
    
    NSArray *verticalConstranints0 = [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat0 options:0 metrics:nil views:buttonViewNameMap];
    NSArray *verticalConstranints1 = [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat1 options:0 metrics:nil views:buttonViewNameMap];
    NSArray *verticalConstranints2 = [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat2 options:0 metrics:nil views:buttonViewNameMap];
    NSArray *verticalConstranints3 = [NSLayoutConstraint constraintsWithVisualFormat:verticalFormat3 options:0 metrics:nil views:buttonViewNameMap];
    
    [self addConstraints:horizontalConstraints0];
    [self addConstraints:horizontalConstraints1];
    [self addConstraints:verticalConstranints0];
    [self addConstraints:verticalConstranints1];
    [self addConstraints:verticalConstranints2];
    [self addConstraints:verticalConstranints3];
}

#pragma mark - private methods 
- (UIButton *)createButton {
    UIButton *button = [[UIButton alloc] init];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}

- (UILabel *)createLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font=[label.font fontWithSize:12];
    label.textColor = UIColorFromRGB(0x666666, 1.0);
    label.translatesAutoresizingMaskIntoConstraints = NO;
    return label;
}

#pragma mark - getters and setters
- (void)setImageURLStrings:(NSArray *)imageURLStrings {
    _imageURLStrings = [imageURLStrings copy];
    
    NSUInteger count = _imageURLStrings.count < _buttons.count ? _imageURLStrings.count : _buttons.count;
    
    for (int i = 0; i < count; i++) {
        [_buttons[i] sd_setImageWithURL:[NSURL URLWithString:_imageURLStrings[i]] forState:UIControlStateNormal];
    }
}

- (UIButton *)button0 {
    if (_button0 == nil) {
        _button0 = [self createButton];
    }
    return _button0;
}

- (UIButton *)button1 {
    if (_button1 == nil) {
        _button1 = [self createButton];
    }
    return _button1;
}

- (UIButton *)button2 {
    if (_button2 == nil) {
        _button2 = [self createButton];
    }
    return _button2;
}

- (UIButton *)button3 {
    if (_button3 == nil) {
        _button3 = [self createButton];
    }
    return _button3;
}

- (UIButton *)button4 {
    if (_button4 == nil) {
        _button4 = [self createButton];
    }
    return _button4;
}

- (UIButton *)button5 {
    if (_button5 == nil) {
        _button5 = [self createButton];
    }
    return _button5;
}

- (UIButton *)button6 {
    if (_button6 == nil) {
        _button6 = [self createButton];
    }
    return _button6;
}

- (UIButton *)button7 {
    if (_button7 == nil) {
        _button7 = [self createButton];
    }
    return _button7;
}

- (UILabel *)buttonLabel0 {
    if (_buttonLabel0 == nil) {
        _buttonLabel0 = [self createLabel];
    }
    return _buttonLabel0;
}

- (UILabel *)buttonLabel1 {
    if (_buttonLabel1 == nil) {
        _buttonLabel1 = [self createLabel];
    }
    return _buttonLabel1;
}

- (UILabel *)buttonLabel2 {
    if (_buttonLabel2 == nil) {
        _buttonLabel2 = [self createLabel];
    }
    return _buttonLabel2;
}

- (UILabel *)buttonLabel3 {
    if (_buttonLabel3 == nil) {
        _buttonLabel3 = [self createLabel];
    }
    return _buttonLabel3;
}

- (UILabel *)buttonLabel4 {
    if (_buttonLabel4 == nil) {
        _buttonLabel4 = [self createLabel];
    }
    return _buttonLabel4;
}

- (UILabel *)buttonLabel5 {
    if (_buttonLabel5 == nil) {
        _buttonLabel5 = [self createLabel];
    }
    return _buttonLabel5;
}

- (UILabel *)buttonLabel6 {
    if (_buttonLabel6 == nil) {
        _buttonLabel6 = [self createLabel];
    }
    return _buttonLabel6;
}

- (UILabel *)buttonLabel7 {
    if (_buttonLabel7 == nil) {
        _buttonLabel7 = [self createLabel];
    }
    return _buttonLabel7;
}

- (UIView *)buttonView0 {
    if (_buttonView0 == nil) {
        _buttonView0 = [[UIView alloc] init];
        _buttonView0.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView0;
}

- (UIView *)buttonView1 {
    if (_buttonView1 == nil) {
        _buttonView1 = [[UIView alloc] init];
        _buttonView1.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView1;
}

- (UIView *)buttonView2 {
    if (_buttonView2 == nil) {
        _buttonView2 = [[UIView alloc] init];
        _buttonView2.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView2;
}

- (UIView *)buttonView3 {
    if (_buttonView3 == nil) {
        _buttonView3 = [[UIView alloc] init];
        _buttonView3.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView3;
}

- (UIView *)buttonView4 {
    if (_buttonView4 == nil) {
        _buttonView4 = [[UIView alloc] init];
        _buttonView4.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView4;
}

- (UIView *)buttonView5 {
    if (_buttonView5 == nil) {
        _buttonView5 = [[UIView alloc] init];
        _buttonView5.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView5;
}

- (UIView *)buttonView6 {
    if (_buttonView6 == nil) {
        _buttonView6 = [[UIView alloc] init];
        _buttonView6.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView6;
}

- (UIView *)buttonView7 {
    if (_buttonView7 == nil) {
        _buttonView7 = [[UIView alloc] init];
        _buttonView7.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _buttonView7;
}

@end
