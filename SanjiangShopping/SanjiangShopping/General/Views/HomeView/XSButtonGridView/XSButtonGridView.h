//
//  XSButtonGridView.h
//  XSButtonGridView
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSButtonGridView : UIView

@property (strong, nonatomic) UIButton *button0;
@property (strong, nonatomic) UIButton *button1;
@property (strong, nonatomic) UIButton *button2;
@property (strong, nonatomic) UIButton *button3;
@property (strong, nonatomic) UIButton *button4;
@property (strong, nonatomic) UIButton *button5;
@property (strong, nonatomic) UIButton *button6;
@property (strong, nonatomic) UIButton *button7;

@property (copy, nonatomic) NSArray  *imageURLStrings;

- (instancetype)init;

@end
