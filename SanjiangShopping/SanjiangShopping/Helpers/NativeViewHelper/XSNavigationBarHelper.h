//
//  XSNavigationBarHelper.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSNavigationBarHelper : NSObject

@property (strong, nonatomic) UINavigationBar *navigationBar;

@property (strong, nonatomic) UIView *_UINavigationBarBackground;
@property (strong, nonatomic) UIImageView *UIImageView;
@property (strong, nonatomic) UIView *_UIBackdropView;
@property (strong, nonatomic) UIView *_UIBackdropEffectView;
@property (strong, nonatomic) UIView *UINavigationItemButtonView;
@property (strong, nonatomic) UIImageView *_UINavigationBarBackIndicatorView;

+ (void)hackStandardNavigationBar:(UINavigationBar *)navigationBar; // 标准白色
+ (void)hackPlainNavigationBar:(UINavigationBar *)navigationBar; // 无线框

- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar;
- (void)peek;

@end
