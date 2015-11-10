//
//  UIView+State.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/10/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "UIView+State.h"
#import <objc/runtime.h>

#import "ThemeColor.h"

@interface UIView ()
@property (strong, nonatomic) UIView *noNetworkView;
@property (strong, nonatomic) UIView *emptyView;
@end

@implementation UIView (State)

- (void)xs_switchToLoadingState {

}

- (void)xs_switchToEmptyState {
    NSLog(@"内容为空");
    [self xs_presentEmptyView];
}

- (void)xs_switchToErrorStateWithErrorCode:(NSInteger)code {
    if (code == -1009) {
        NSLog(@"网络无连接");
        [self xs_presentNoNetworkView];
    } else {
        NSLog(@"无法识别的错误");
    }
}

- (void)xs_switchToContentState {
    [self.noNetworkView removeFromSuperview];
    [self.emptyView removeFromSuperview];
}

#pragma mark - private methods
- (void)xs_presentNoNetworkView {
    if (self.noNetworkView == nil) {
        self.noNetworkView = [[[NSBundle mainBundle] loadNibNamed:@"NoNetWorkView" owner:nil options:nil] objectAtIndex:0];
    }
    [self addSubview:self.noNetworkView];
    [self bringSubviewToFront:self.noNetworkView];
    self.noNetworkView.frame = self.bounds;
    
    self.noNetworkView.userInteractionEnabled = YES;
    [self.noNetworkView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xs_refreshView)]];
}

- (void)xs_presentEmptyView {
    if (self.emptyView == nil) {
        self.emptyView = [[[NSBundle mainBundle] loadNibNamed:@"NoCommodityView" owner:nil options:nil] objectAtIndex:0];
    }
    [self addSubview:self.emptyView];
    [self bringSubviewToFront:self.emptyView];
    self.emptyView.frame = self.bounds;
    
    self.emptyView.userInteractionEnabled = YES;
    [self.emptyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xs_refreshView)]];
}

#pragma mark - response methods
- (void)xs_refreshView {
    if ([self.delegate respondsToSelector:@selector(viewStateShouldChange)]) {
        [self.delegate viewStateShouldChange];
    }
}

#pragma mark - getters and setters
static char delegateKey;
- (id<UIViewStateDelegate>)delegate {
    return objc_getAssociatedObject(self, &delegateKey);
}

- (void)setDelegate:(id<UIViewStateDelegate>)delegate {
    objc_setAssociatedObject(self, &delegateKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

static char noNetWorkViewKey;
- (UIView *)noNetworkView {
    return objc_getAssociatedObject(self, &noNetWorkViewKey);
}

- (void)setNoNetworkView:(UIView *)noNetworkView {
    objc_setAssociatedObject(self, &noNetWorkViewKey, noNetworkView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char emptyViewKey;
- (UIView *)emptyView {
    return objc_getAssociatedObject(self, &emptyViewKey);
}

- (void)setEmptyView:(UIView *)emptyView {
    objc_setAssociatedObject(self, &emptyViewKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
