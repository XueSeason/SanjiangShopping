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
    navHelper.UIImageView.hidden = NO;
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

- (void)recursion:(UIView *)currentView
{
    if (__UINavigationBarBackground && __UIBackdropEffectView && __UIBackdropView) {
        return;
    }
    
    if([currentView isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
        __UINavigationBarBackground = currentView;
        for (UIImageView *imageView in currentView.subviews) {
            if ([imageView isKindOfClass:[UIImageView class]]) {
                _UIImageView = imageView;
            }
        }
    } else if ([currentView isKindOfClass:NSClassFromString(@"_UIBackdropView")]) {
        __UIBackdropView = currentView;
    } else if ([currentView isKindOfClass:NSClassFromString(@"_UIBackdropEffectView")]) {
        __UIBackdropEffectView = currentView;
    } else if ([currentView isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
        _UINavigationItemButtonView = currentView;
    } else if ([currentView isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]) {
        __UINavigationBarBackIndicatorView = (UIImageView *)currentView;
    }
    
    for (UIView *view in currentView.subviews) {
        [self recursion:view];
    }
}

@end
