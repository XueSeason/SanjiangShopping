//
//  XSAccountCenterView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/9.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSAccountCenterView.h"
#import "ThemeColor.h"

static const CGFloat bannerHeight = 160.0f;
static const CGFloat rowHeightStandard = 44.0f;
static const CGFloat rowHeightHeigh = 75.0f;
static const CGFloat step = 8.0f;

@implementation TradeView
@end

@implementation CellView
@end

@interface XSAccountCenterView ()

@end

@implementation XSAccountCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentWidth  = frame.size.width;
        _contentHeight = 0.0f;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator   = NO;
        self.backgroundColor = BACKGROUND_COLOR;
        
        _bannerView     = [self bannerView];
        [self addSubview:_bannerView];
        _contentHeight  += _bannerView.frame.size.height;

        _orderView      = [self generateCellView];
        [self addSubview:_orderView];
        _contentHeight  += _orderView.frame.size.height;

        _tradeView = [self generateTradeView];
        [self addSubview:_tradeView];
        _contentHeight  += _tradeView.frame.size.height + step;

        _memberCardView = [self generateCellView];
        [self addSubview:_memberCardView];
        _contentHeight  += _memberCardView.frame.size.height;
        _favoriteView   = [self generateCellView];
        [self addSubview:_favoriteView];
        _contentHeight  += _favoriteView.frame.size.height;
        _addressView    = [self generateCellView];
        [self addSubview:_addressView];
        _contentHeight  += _addressView.frame.size.height + step;

        _couponView     = [self generateCellView];
        [self addSubview:_couponView];
        _contentHeight  += _couponView.frame.size.height;
        _scoreView      = [self generateCellView];
        [self addSubview:_scoreView];
        _contentHeight  += _scoreView.frame.size.height + step;

        _helpView       = [self generateCellView];
        [self addSubview:_helpView];
        _contentHeight  += _helpView.frame.size.height + step;
        
        _orderView.titleLabel.text          = @"我的订单";
        _orderView.subTitleLabel.text       = @"查看全部订单";
        _orderView.logoImageView.image      = [UIImage imageNamed:@"order"];
        _orderView.arrow.image              = [UIImage imageNamed:@"arrow"];
        _orderView.arrow.contentMode        = UIViewContentModeScaleAspectFit;

        _memberCardView.titleLabel.text     = @"我的会员卡";
        _memberCardView.subTitleLabel.text  = @"申请、绑定会员卡，续交会员费";
        _memberCardView.logoImageView.image = [UIImage imageNamed:@"memberCard"];
        _memberCardView.arrow.image         = [UIImage imageNamed:@"arrow"];
        _memberCardView.arrow.contentMode   = UIViewContentModeScaleAspectFit;

        _favoriteView.titleLabel.text       = @"我的收藏";
        _favoriteView.subTitleLabel.text    = @"查看全部订单";
        _favoriteView.logoImageView.image   = [UIImage imageNamed:@"favorite"];
        _favoriteView.arrow.image           = [UIImage imageNamed:@"arrow"];
        _favoriteView.arrow.contentMode     = UIViewContentModeScaleAspectFit;
        
        _addressView.titleLabel.text        = @"我的收货地址";
        _addressView.subTitleLabel.text     = @"管理收获地址";
        _addressView.logoImageView.image   = [UIImage imageNamed:@"address"];
        _addressView.arrow.image           = [UIImage imageNamed:@"arrow"];
        _addressView.arrow.contentMode     = UIViewContentModeScaleAspectFit;

        _couponView.titleLabel.text         = @"我的优惠券";
        _couponView.subTitleLabel.text      = @"您有3张优惠券";
        _couponView.logoImageView.image     = [UIImage imageNamed:@"coupon"];
        _couponView.arrow.image             = [UIImage imageNamed:@"arrow"];
        _couponView.arrow.contentMode       = UIViewContentModeScaleAspectFit;

        _scoreView.titleLabel.text          = @"我的积分";
        _scoreView.subTitleLabel.text       = @"查询积分、兑换优惠券";
        _scoreView.logoImageView.image      = [UIImage imageNamed:@"score"];
        _scoreView.arrow.image              = [UIImage imageNamed:@"arrow"];
        _scoreView.arrow.contentMode        = UIViewContentModeScaleAspectFit;

        _helpView.titleLabel.text           = @"帮助中心";
        _helpView.subTitleLabel.text        = @"常见问题、在线留言";
        _helpView.logoImageView.image       = [UIImage imageNamed:@"help"];
        _helpView.arrow.image               = [UIImage imageNamed:@"arrow"];
        _helpView.arrow.contentMode         = UIViewContentModeScaleAspectFit;
        
        self.contentSize  = CGSizeMake(_contentWidth, _contentHeight);
        self.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    }
    return self;
}

- (UIImageView *)bannerView {
    UIImageView *view           = [[UIImageView alloc] initWithFrame:CGRectMake(0, _contentHeight, _contentWidth, bannerHeight)];
    view.userInteractionEnabled = YES;
    view.image                  = [UIImage imageNamed:@"bannerBackground"];
    
    [view addSubview:self.loginButton];
    [view addSubview:self.loginLabel];
    [view addSubview:self.settingButton];
    
    NSDictionary *map = @{
                          @"lb": self.loginButton,
                          @"ll": self.loginLabel,
                          @"sb": self.settingButton
                          };
    
    CGFloat space = (view.frame.size.width - 75) / 2.0;
    CGFloat step  = (view.frame.size.height - 75) / 2.0;
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[sb(==21)]-8-|" options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-28-[sb(==21)]" options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[lb]-%f-|", space, space] options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[lb]-%f-|", step, step] options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[ll]-%f-|", space, space] options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb]-0-[ll(==21)]" options:0 metrics:nil views:map]];
    
    return view;
}

- (CellView *)generateCellView {
    CellView *cellView       = [[CellView alloc] initWithFrame:CGRectMake(0, _contentHeight, _contentWidth, rowHeightStandard)];
    cellView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logo  = [[UIImageView alloc] init];
    UILabel *title     = [[UILabel alloc] init];
    UILabel *subTitle  = [[UILabel alloc] init];
    UIImageView *arrow = [[UIImageView alloc] init];
    
    if (self.frame.size.width > 320) {
        title.font    = [title.font fontWithSize:14.0];
        subTitle.font = [subTitle.font fontWithSize:12.0];
    } else {
        title.font    = [title.font fontWithSize:12.0];
        subTitle.font = [subTitle.font fontWithSize:10.0];
    }
    
    title.textAlignment    = NSTextAlignmentLeft;
    subTitle.textAlignment = NSTextAlignmentRight;
    subTitle.textColor     = [UIColor darkGrayColor];
    
    cellView.logoImageView = logo;
    cellView.titleLabel    = title;
    cellView.subTitleLabel = subTitle;
    cellView.arrow         = arrow;
    
    [cellView addSubview:logo];
    [cellView addSubview:title];
    [cellView addSubview:subTitle];
    [cellView addSubview:arrow];
    logo.translatesAutoresizingMaskIntoConstraints     = NO;
    title.translatesAutoresizingMaskIntoConstraints    = NO;
    subTitle.translatesAutoresizingMaskIntoConstraints = NO;
    arrow.translatesAutoresizingMaskIntoConstraints    = NO;
    
    NSDictionary *map = @{
                          @"logo": logo,
                          @"title": title,
                          @"subTitle": subTitle,
                          @"arrow": arrow
                          };
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[logo(==28)]-8-[title(==100)]-8-[subTitle]-8-[arrow(==12)]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[logo]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[title]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[subTitle]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[arrow]-8-|" options:0 metrics:nil views:map]];
    
    cellView.layer.borderWidth = 0.3f;
    cellView.layer.borderColor = [BACKGROUND_COLOR CGColor];
    
    return cellView;
}

- (TradeView *)generateTradeView {
    TradeView *tradeView             = [[TradeView alloc] initWithFrame:CGRectMake(0, _contentHeight, _contentWidth, rowHeightHeigh)];
    tradeView.backgroundColor        = [UIColor whiteColor];

    UIControl *control0 = [[UIControl alloc] init];
    UIControl *control1 = [[UIControl alloc] init];
    UIControl *control2 = [[UIControl alloc] init];

    tradeView.waitPayControl      = control0;
    tradeView.waitReceiptControl  = control1;
    tradeView.waitFeedbackControl = control2;
    
    [tradeView addSubview:control0];
    [tradeView addSubview:control1];
    [tradeView addSubview:control2];
    
    control0.translatesAutoresizingMaskIntoConstraints = NO;
    control1.translatesAutoresizingMaskIntoConstraints = NO;
    control2.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *map = @{
                          @"left": control0,
                          @"center": control1,
                          @"right": control2
                          };
    [tradeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[left(==center)]-0-[center(==right)]-0-[right(==left)]-0-|" options:0 metrics:nil views:map]];
    [tradeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[left]-0-|" options:0 metrics:nil views:map]];
    [tradeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[center]-0-|" options:0 metrics:nil views:map]];
    [tradeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[right]-0-|" options:0 metrics:nil views:map]];
    
    NSArray *itemArr = @[control0, control1, control2];
    for (UIControl *control in itemArr) {
        UIImageView *picture              = [[UIImageView alloc] init];
        UILabel *titleLabel               = [[UILabel alloc] init];
        titleLabel.textAlignment          = NSTextAlignmentCenter;
        titleLabel.font                   = [titleLabel.font fontWithSize:14.0];
        
        [control addSubview:picture];
        [control addSubview:titleLabel];
        
        picture.translatesAutoresizingMaskIntoConstraints    = NO;
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *nameMap = @{
                                  @"img": picture,
                                  @"title": titleLabel
                                  };
        
        [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[img]-8-|" options:0 metrics:nil views:nameMap]];
        [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[title]-8-|" options:0 metrics:nil views:nameMap]];
        [control addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[img]-0-[title(==21)]-8-|" options:0 metrics:nil views:nameMap]];
        
        if (control == control0) {
            titleLabel.text     = @"待支付";
            picture.image       = [UIImage imageNamed:@"trade_pay"];
            picture.contentMode = UIViewContentModeScaleAspectFit;
        } else if (control == control1) {
            titleLabel.text     = @"待收货";
            picture.image       = [UIImage imageNamed:@"trade_rec"];
            picture.contentMode = UIViewContentModeScaleAspectFit;
        } else {
            titleLabel.text     = @"待评论";
            picture.image       = [UIImage imageNamed:@"trade_feedback"];
            picture.contentMode = UIViewContentModeScaleAspectFit;
        }
    }

    tradeView.layer.borderWidth = 0.3f;
    tradeView.layer.borderColor = [BACKGROUND_COLOR CGColor];
    
    return tradeView;
}

#pragma mark - getters and setters
- (UILabel *)loginLabel {
    if (_loginLabel == nil) {
        _loginLabel = [[UILabel alloc] init];
        _loginLabel.text          = @"登录/注册";
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        _loginLabel.textColor     = [UIColor whiteColor];
        _loginLabel.font          = [_loginLabel.font fontWithSize:14.0];
        _loginLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _loginLabel;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] init];
        _loginButton.layer.cornerRadius = 37.5f;
        _loginButton.backgroundColor    = [UIColor whiteColor];
        [_loginButton setImage:[UIImage imageNamed:@"unlogin"] forState:UIControlStateNormal];
        _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _loginButton;
}

- (UIButton *)settingButton {
    if (_settingButton == nil) {
        _settingButton = [[UIButton alloc] init];
        [_settingButton setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        _settingButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _settingButton;
}

@end
