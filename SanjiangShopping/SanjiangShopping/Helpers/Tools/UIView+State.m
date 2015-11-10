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
@end

@implementation UIView (State)

- (void)xs_switchToLoadingState {

}

- (void)xs_switchToEmptyState {
    
}

- (void)xs_switchToErrorStateWithErrorCode:(NSInteger)code {
    if (code == -1009) {
        NSLog(@"网络无连接");
        
        if (self.noNetworkView == nil) {
            self.noNetworkView = [[[NSBundle mainBundle] loadNibNamed:@"NoNetWorkView" owner:nil options:nil] objectAtIndex:0];
        }
        
        [self addSubview:self.noNetworkView];
        self.noNetworkView.frame = self.bounds;
    } else {
        NSLog(@"无法识别的错误");
    }
}

- (void)xs_switchToContentState {
    [self.noNetworkView removeFromSuperview];
}

#pragma mark - response methods
- (void)xs_refreshView {
    [self.delegate viewShouldRefresh];
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

@end
