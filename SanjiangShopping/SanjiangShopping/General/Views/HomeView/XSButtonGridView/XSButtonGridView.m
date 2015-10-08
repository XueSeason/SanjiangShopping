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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _button0 = [[UIButton alloc] init];
        _button1 = [[UIButton alloc] init];
        _button2 = [[UIButton alloc] init];
        _button3 = [[UIButton alloc] init];
        _button4 = [[UIButton alloc] init];
        _button5 = [[UIButton alloc] init];
        _button6 = [[UIButton alloc] init];
        _button7 = [[UIButton alloc] init];
        _buttons = @[_button0, _button1, _button2, _button3, _button4, _button5, _button6, _button7];

        for (int i = 0; i < _buttons.count; i++) {
            UIButton *button = _buttons[i];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            button.translatesAutoresizingMaskIntoConstraints = NO;
            button.imageView.translatesAutoresizingMaskIntoConstraints = NO;
            
            NSDictionary *map = @{
                                  @"imageView": button.imageView
                                  };
            
            [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:map]];
            [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:map]];
        }
        
        _buttonLabel0 = [[UILabel alloc] init];
        _buttonLabel1 = [[UILabel alloc] init];
        _buttonLabel2 = [[UILabel alloc] init];
        _buttonLabel3 = [[UILabel alloc] init];
        _buttonLabel4 = [[UILabel alloc] init];
        _buttonLabel5 = [[UILabel alloc] init];
        _buttonLabel6 = [[UILabel alloc] init];
        _buttonLabel7 = [[UILabel alloc] init];
        _buttonLabel0.text = @"新品专区";
        _buttonLabel1.text = @"生鲜超市";
        _buttonLabel2.text = @"三江优选";
        _buttonLabel3.text = @"惠商品";
        _buttonLabel4.text = @"我的收藏";
        _buttonLabel5.text = @"订单查询";
        _buttonLabel6.text = @"我的会员卡";
        _buttonLabel7.text = @"身边三江";
        _buttonLabels = @[_buttonLabel0, _buttonLabel1, _buttonLabel2, _buttonLabel3, _buttonLabel4, _buttonLabel5, _buttonLabel6, _buttonLabel7];
        for (int i = 0; i < _buttonLabels.count; i++) {
            UILabel *label = _buttonLabels[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.font=[label.font fontWithSize:12];
            label.textColor = UIColorFromRGB(0x666666, 1.0);
            label.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        _buttonView0 = [[UIView alloc] init];
        _buttonView1 = [[UIView alloc] init];
        _buttonView2 = [[UIView alloc] init];
        _buttonView3 = [[UIView alloc] init];
        _buttonView4 = [[UIView alloc] init];
        _buttonView5 = [[UIView alloc] init];
        _buttonView6 = [[UIView alloc] init];
        _buttonView7 = [[UIView alloc] init];
        _buttonViews = @[_buttonView0, _buttonView1, _buttonView2, _buttonView3, _buttonView4, _buttonView5, _buttonView6, _buttonView7];
        for (int i = 0; i < _buttonViews.count; i++) {
            UIView *view = _buttonViews[i];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            
            [view addSubview:_buttons[i]];
            [view addSubview:_buttonLabels[i]];
            [self addSubview:view];
        }

        // 自动布局 button 和 label
        NSDictionary *buttonAndLabelNameMap = @{
                                                @"button_0_0": _button0,
                                                @"button_0_1": _button1,
                                                @"button_0_2": _button2,
                                                @"button_0_3": _button3,
                                                @"button_1_0": _button4,
                                                @"button_1_1": _button5,
                                                @"button_1_2": _button6,
                                                @"button_1_3": _button7,
                                                @"label_0_0": _buttonLabel0,
                                                @"label_0_1": _buttonLabel1,
                                                @"label_0_2": _buttonLabel2,
                                                @"label_0_3": _buttonLabel3,
                                                @"label_1_0": _buttonLabel4,
                                                @"label_1_1": _buttonLabel5,
                                                @"label_1_2": _buttonLabel6,
                                                @"label_1_3": _buttonLabel7
                                             };
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                
                NSString *subHorizontalFormat0 = [NSString stringWithFormat:@"H:|-8-[button_%d_%d]-8-|", i, j];
                NSString *subHorizontalFormat1 = [NSString stringWithFormat:@"H:|-0-[label_%d_%d]-0-|", i, j];
                NSString *subVerticalFormat    = [NSString stringWithFormat:@"V:|-4-[button_%d_%d]-4-[label_%d_%d(==15)]-4-|", i, j, i, j];
                NSArray  *subHorizontalConstraints0 = [NSLayoutConstraint constraintsWithVisualFormat:subHorizontalFormat0 options:0 metrics:nil views:buttonAndLabelNameMap];
                NSArray  *subHorizontalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:subHorizontalFormat1 options:0 metrics:nil views:buttonAndLabelNameMap];
                NSArray  *subVerticalContraints     = [NSLayoutConstraint constraintsWithVisualFormat:subVerticalFormat options:0 metrics:nil views:buttonAndLabelNameMap];
                [_buttonViews[i*4+j] addConstraints:subHorizontalConstraints0];
                [_buttonViews[i*4+j] addConstraints:subHorizontalConstraints1];
                [_buttonViews[i*4+j] addConstraints:subVerticalContraints];
            }
        }
        
        // 自动布局 button view
        NSDictionary *buttonViewNameMap = @{
                                  @"buttonView_0_0": _buttonView0,
                                  @"buttonView_0_1": _buttonView1,
                                  @"buttonView_0_2": _buttonView2,
                                  @"buttonView_0_3": _buttonView3,
                                  @"buttonView_1_0": _buttonView4,
                                  @"buttonView_1_1": _buttonView5,
                                  @"buttonView_1_2": _buttonView6,
                                  @"buttonView_1_3": _buttonView7
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
    return self;
}

- (void)setImageURLStrings:(NSArray *)imageURLStrings {
    _imageURLStrings = [imageURLStrings copy];
    
    NSUInteger count = _imageURLStrings.count < _buttons.count ? _imageURLStrings.count : _buttons.count;
    
    for (int i = 0; i < count; i++) {
        [_buttons[i] sd_setImageWithURL:[NSURL URLWithString:_imageURLStrings[i]] forState:UIControlStateNormal];
    }
}

@end
