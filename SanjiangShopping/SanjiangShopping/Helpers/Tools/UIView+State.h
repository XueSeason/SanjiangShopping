//
//  UIView+State.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/10/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewStateDelegate <NSObject>
@optional
- (void)viewStateShouldChange;
@end

@interface UIView (State)

@property (weak, nonatomic) id<UIViewStateDelegate> delegate;

- (void)xs_switchToLoadingState;
- (void)xs_switchToEmptyState;
- (void)xs_switchToErrorStateWithErrorCode:(NSInteger)code;
- (void)xs_switchToContentState;

@end
