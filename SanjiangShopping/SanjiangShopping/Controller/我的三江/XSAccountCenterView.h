//
//  XSAccountCenterView.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/9.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeView : UIView
@property (strong, nonatomic) UIControl *waitPayControl;
@property (strong, nonatomic) UIControl *waitReceiptControl;
@property (strong, nonatomic) UIControl *waitFeedbackControl;
@end

@interface CellView : UIControl
@property (strong, nonatomic) UIImageView *logoImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (strong, nonatomic) UIImageView *arrow;
@end

@interface XSAccountCenterView : UIScrollView
@property (assign, nonatomic) CGFloat contentWidth;
@property (assign, nonatomic) CGFloat contentHeight;

@property (strong, nonatomic) UIImageView *bannerView;
@property (strong, nonatomic) CellView *orderView;
@property (strong, nonatomic) TradeView *tradeView;

@property (strong, nonatomic) CellView *memberCardView;
@property (strong, nonatomic) CellView *favoriteView;
@property (strong, nonatomic) CellView *addressView;

@property (strong, nonatomic) CellView *couponView;
@property (strong, nonatomic) CellView *scoreView;

@property (strong, nonatomic) CellView *helpView;

@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) UILabel  *loginLabel;
@property (strong, nonatomic) UIButton *settingButton;

@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *memberLabel;
@property (strong, nonatomic) UIButton *updateMemberButton;
@property (strong, nonatomic) UIImageView *memberImageView;

- (instancetype)initWithFrame:(CGRect)frame;
@end
