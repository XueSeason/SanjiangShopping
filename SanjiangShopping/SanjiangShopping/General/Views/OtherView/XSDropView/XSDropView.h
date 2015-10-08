//
//  XSDropView.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/21.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XSDropViewDelegate <NSObject>
- (void)dropDown:(UIView *)dropContentView;
@end

@interface XSDropView : UIView

@property (weak, nonatomic) id<XSDropViewDelegate> delegate;

@property (strong, nonatomic) UIControl *dropControl;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) UIImageView *indicativeView;

@property (strong, nonatomic) UIView *dropContentView;
@property (assign, nonatomic) CGFloat contentHeight;
@end
