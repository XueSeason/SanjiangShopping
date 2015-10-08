//
//  XSNavigationBarHelper.m
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/25.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#import "XSNavigationBarHelper.h"

@implementation XSNavigationBarHelper

+ (void)hackStandardNavigationBar:(UINavigationBar *)navigationBar {
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:navigationBar];
    [navHelper peek];
    navHelper._UINavigationBarBackground.backgroundColor = [UIColor whiteColor];
    navHelper._UIBackdropEffectView.hidden = YES;
}

+ (void)hackPlainNavigationBar:(UINavigationBar *)navigationBar {
    XSNavigationBarHelper *navHelper = [[XSNavigationBarHelper alloc] initWithNavigationBar:navigationBar];
    [navHelper peek];
    navHelper._UINavigationBarBackground.backgroundColor = [UIColor whiteColor];
    navHelper._UIBackdropEffectView.hidden = YES;
    navHelper.UIImageView.hidden = YES; // 去除UIImageView带来的线框
}

- (instancetype)initWithNavigationBar:(UINavigationBar *)navigationBar
{
    self = [super init];
    if (self) {
        _navigationBar = navigationBar;   
    }
    return self;
}

- (void)peek {
    [self recursion:_navigationBar];
}

- (void)recursion:(UIView *)superView
{
    if (__UINavigationBarBackground && __UIBackdropEffectView && __UIBackdropView) {
        return;
    }
    
    if([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
        __UINavigationBarBackground = superView;
        for (UIImageView *imageView in superView.subviews) {
            if ([imageView isKindOfClass:[UIImageView class]]) {
                _UIImageView = imageView;
            }
        }
    } else if ([superView isKindOfClass:NSClassFromString(@"_UIBackdropView")]) {
        __UIBackdropEffectView = superView;
    } else if ([superView isKindOfClass:NSClassFromString(@"_UIBackdropEffectView")]) {
        __UIBackdropEffectView = superView;
    } else if ([superView isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
        _UINavigationItemButtonView = superView;
    } else if ([superView isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
        __UINavigationBarBackIndicatorView = (UIImageView *)superView;
    }
    
    for (UIView *view in superView.subviews) {
        [self recursion:view];
    }
}

@end
