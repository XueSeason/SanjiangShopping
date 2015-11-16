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
        CALayer *line = [[CALayer alloc] init];
        line.frame = CGRectMake(10, _orderView.frame.origin.y + _orderView.frame.size.height - 0.5, frame.size.width, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        
        _contentHeight  += _orderView.frame.size.height;

        _tradeView = [self generateTradeView];
        [self addSubview:_tradeView];
        _contentHeight  += _tradeView.frame.size.height + step;
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - step, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];

        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - 0.5, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        _memberCardView = [self generateCellView];
        [self addSubview:_memberCardView];
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(10, _memberCardView.frame.origin.y + _memberCardView.frame.size.height - 0.5, frame.size.width, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        _contentHeight  += _memberCardView.frame.size.height;
        _favoriteView   = [self generateCellView];
        [self addSubview:_favoriteView];
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(10, _favoriteView.frame.origin.y + _favoriteView.frame.size.height - 0.5, frame.size.width, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        _contentHeight  += _favoriteView.frame.size.height;
        _addressView    = [self generateCellView];
        [self addSubview:_addressView];
        _contentHeight  += _addressView.frame.size.height + step;
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - step, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];

        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - 0.5, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        _couponView     = [self generateCellView];
        [self addSubview:_couponView];
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(10, _couponView.frame.origin.y + _couponView.frame.size.height - 0.5, frame.size.width, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        _contentHeight  += _couponView.frame.size.height;
        _scoreView      = [self generateCellView];
        [self addSubview:_scoreView];
        _contentHeight  += _scoreView.frame.size.height + step;
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - step, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];


        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - 0.5, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];
        _helpView       = [self generateCellView];
        [self addSubview:_helpView];
        _contentHeight  += _helpView.frame.size.height + step;
        line = [[CALayer alloc] init];
        line.frame = CGRectMake(0, _contentHeight - step, _contentWidth, 0.5);
        line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
        [self.layer addSublayer:line];

        
        _orderView.titleLabel.text          = @"我的订单";
        _orderView.logoImageView.image      = [UIImage imageNamed:@"order"];
        _orderView.arrow.image              = [UIImage imageNamed:@"arrow"];
        _orderView.arrow.contentMode        = UIViewContentModeScaleAspectFit;

        _memberCardView.titleLabel.text     = @"我的会员卡";
        _memberCardView.logoImageView.image = [UIImage imageNamed:@"memberCard"];
        _memberCardView.arrow.image         = [UIImage imageNamed:@"arrow"];
        _memberCardView.arrow.contentMode   = UIViewContentModeScaleAspectFit;

        _favoriteView.titleLabel.text       = @"我的收藏";
        _favoriteView.logoImageView.image   = [UIImage imageNamed:@"favorite"];
        _favoriteView.arrow.image           = [UIImage imageNamed:@"arrow"];
        _favoriteView.arrow.contentMode     = UIViewContentModeScaleAspectFit;
        
        _addressView.titleLabel.text        = @"我的收货地址";
        _addressView.logoImageView.image   = [UIImage imageNamed:@"address"];
        _addressView.arrow.image           = [UIImage imageNamed:@"arrow"];
        _addressView.arrow.contentMode     = UIViewContentModeScaleAspectFit;

        _couponView.titleLabel.text         = @"我的优惠券";
        _couponView.logoImageView.image     = [UIImage imageNamed:@"coupon"];
        _couponView.arrow.image             = [UIImage imageNamed:@"arrow"];
        _couponView.arrow.contentMode       = UIViewContentModeScaleAspectFit;

        _scoreView.titleLabel.text          = @"我的积分";
        _scoreView.logoImageView.image      = [UIImage imageNamed:@"score"];
        _scoreView.arrow.image              = [UIImage imageNamed:@"arrow"];
        _scoreView.arrow.contentMode        = UIViewContentModeScaleAspectFit;

        _helpView.titleLabel.text           = @"帮助中心";
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
    
    [view addSubview:self.avatar];
    [view addSubview:self.nameLabel];
    [view addSubview:self.memberLabel];
    [view addSubview:self.updateMemberButton];
    [view addSubview:self.memberImageView];
    
    NSDictionary *map = @{
                          @"lb": self.loginButton,
                          @"ll": self.loginLabel,
                          @"sb": self.settingButton
                          };
    
    CGFloat space = (view.frame.size.width - 75) / 2.0;
    CGFloat step  = (view.frame.size.height - 75) / 2.0;
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[sb(==27)]-8-|" options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-28-[sb(==27)]" options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[lb]-%f-|", space, space] options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[lb]-%f-|", step, step] options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[ll]-%f-|", space, space] options:0 metrics:nil views:map]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[lb]-0-[ll(==21)]" options:0 metrics:nil views:map]];
    
    NSDictionary *userMap = @{
                              @"img0": self.avatar,
                              @"name": self.nameLabel,
                              @"member": self.memberLabel,
                              @"btn": self.updateMemberButton,
                              @"img1": self.memberImageView
                              };
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[img0(==80)]-[name]" options:0 metrics:nil views:userMap]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[img0(==80)]-[member(==45)]-[btn]" options:0 metrics:nil views:userMap]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[img1(==44)]-30-|" options:0 metrics:nil views:userMap]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[img0(==80)]" options:0 metrics:nil views:userMap]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[name]-[member(==23)]" options:0 metrics:nil views:userMap]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[name]-[btn(==member)]" options:0 metrics:nil views:userMap]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[img1(==35)]" options:0 metrics:nil views:userMap]];
    // 临时数据
    self.avatar.image = [UIImage imageNamed:@""];
    self.nameLabel.text = @"XueSeason";
    self.memberLabel.text = @"惠用户";
    
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
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[logo(==28)]-8-[title(==100)]-8-[subTitle]-8-[arrow(==12)]-10-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[logo]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[title]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[subTitle]-8-|" options:0 metrics:nil views:map]];
    [cellView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[arrow]-8-|" options:0 metrics:nil views:map]];
    
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
            picture.contentMode = UIViewContentModeCenter;
        } else if (control == control1) {
            titleLabel.text     = @"待收货";
            picture.image       = [UIImage imageNamed:@"trade_rec"];
            picture.contentMode = UIViewContentModeCenter;
        } else {
            titleLabel.text     = @"待评论";
            picture.image       = [UIImage imageNamed:@"trade_feedback"];
            picture.contentMode = UIViewContentModeCenter;
        }
    }
    
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

- (UIImageView *)avatar {
    if (_avatar == nil) {
        _avatar = [[UIImageView alloc] init];
        _avatar.translatesAutoresizingMaskIntoConstraints = NO;
        
        _avatar.layer.cornerRadius = 40.0f;
        _avatar.clipsToBounds = YES;
        
        _avatar.backgroundColor = [UIColor whiteColor];
    }
    return _avatar;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor     = [UIColor whiteColor];
        _nameLabel.font = [_nameLabel.font fontWithSize:16.0];
        _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameLabel;
}

- (UILabel *)memberLabel {
    if (_memberLabel == nil) {
        _memberLabel = [[UILabel alloc] init];
        _memberLabel.textAlignment = NSTextAlignmentCenter;
        _memberLabel.textColor     = [UIColor whiteColor];
        _memberLabel.font = [_nameLabel.font fontWithSize:13.0];
        _memberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        _memberLabel.backgroundColor = THEME_BLACK_FADE(0.5);
        _memberLabel.layer.cornerRadius = 5.0f;
        _memberLabel.clipsToBounds = YES;
    }
    return _memberLabel;
}

- (UIButton *)updateMemberButton {
    if (_updateMemberButton == nil) {
        _updateMemberButton = [[UIButton alloc] init];
        [_updateMemberButton setTitle:@"升级为会员 >" forState:UIControlStateNormal];
        _updateMemberButton.tintColor = [UIColor whiteColor];
        _updateMemberButton.titleLabel.font = [_updateMemberButton.titleLabel.font fontWithSize:12.0];
        _updateMemberButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _updateMemberButton;
}

- (UIImageView *)memberImageView {
    if (_memberImageView == nil) {
        _memberImageView = [[UIImageView alloc] init];
        _memberImageView.backgroundColor = [UIColor whiteColor];
//        _memberImageView.image = [UIImage imageNamed:@""];
        _memberImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _memberImageView;
}


@end
