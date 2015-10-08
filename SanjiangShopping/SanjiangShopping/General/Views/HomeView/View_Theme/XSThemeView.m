//
//  XSThemeView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/25.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSThemeView.h"

#import "ThemeColor.h"
#import "UtilsMacro.h"
#import "HomeModel.h"
#import <UIImageView+WebCache.h>

@implementation XSThemeViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat y = frame.size.height / 60;
        _titleLabel    = [[UILabel alloc] initWithFrame:CGRectMake(8, 3 * y, frame.size.width, 10.0 * y)];
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 13 * y, frame.size.width, 7 * y)];
        _picture       = [[UIImageView alloc] initWithFrame:CGRectMake(0, frame.size.height / 3.0, frame.size.width, frame.size.height / 3.0 * 2.0)];
        
        _titleLabel.font         = [_titleLabel.font fontWithSize:14.0];
        _subTitleLabel.font      = [_subTitleLabel.font fontWithSize:12.0];
        _titleLabel.textColor    = MAIN_TITLE_COLOR;
        _subTitleLabel.textColor = SUB_TITLE_COLOR;
        _picture.contentMode     = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_titleLabel];
        [self addSubview:_subTitleLabel];
        [self addSubview:_picture];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

@interface XSThemeView ()
@property (strong, nonatomic) UILabel     *tagLabel;
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *moreLabel;
@property (strong, nonatomic) UIImageView *moreImageView;

@property (strong, nonatomic) UIView      *mainView;
@property (strong, nonatomic) NSArray     *controlArr;
@end

@implementation XSThemeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        
        self.backgroundColor = [UIColor whiteColor];
        
        _mainView = [[UIView alloc] init];
        _mainView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        _tagLabel      = [[UILabel alloc] init];
        _titleLabel    = [[UILabel alloc] init];
        _moreLabel     = [[UILabel alloc] init];
        _moreImageView = [[UIImageView alloc] init];
        
        _titleLabel.font          = [_moreLabel.font fontWithSize:16.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        
        _moreLabel.text          = @"更多";
        _moreLabel.font          = [_moreLabel.font fontWithSize:13.0];
        _moreLabel.textColor     = [UIColor grayColor];
        _moreLabel.textAlignment = NSTextAlignmentRight;
        
        _moreImageView = [[UIImageView alloc] init];
        _moreImageView.image = [UIImage imageNamed:@"arrow"];
        _moreImageView.contentMode = UIViewContentModeCenter;
        
        _tagLabel.translatesAutoresizingMaskIntoConstraints      = NO;
        _titleLabel.translatesAutoresizingMaskIntoConstraints    = NO;
        _moreLabel.translatesAutoresizingMaskIntoConstraints     = NO;
        _moreImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _moreControl = [[UIControl alloc] init];
        _moreControl.translatesAutoresizingMaskIntoConstraints  = NO;
        [_moreControl addSubview:_tagLabel];
        [_moreControl addSubview:_titleLabel];
        [_moreControl addSubview:_moreLabel];
        [_moreControl addSubview:_moreImageView];
        [self addSubview:_moreControl];
        [self addSubview:_mainView];
        
        // 自动布局
        NSDictionary *mainMap = @{
                                  @"title": _moreControl,
                                  @"main": _mainView
                                  };
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[title]-0-|" options:0 metrics:nil views:mainMap]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title(==40)]-0-[main]-0-|" options:0 metrics:nil views:mainMap]];
        
        NSDictionary *titleMap = @{
                                   @"tag": _tagLabel,
                                   @"title": _titleLabel,
                                   @"more": _moreLabel,
                                   @"moreImage": _moreImageView
                                   };
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tag(==5)]-10-[title(==100)]" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[more(==50)]-0-[moreImage(==20)]-15-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tag]-10-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[title]-0-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[more]-0-|" options:0 metrics:nil views:titleMap]];
        [_moreControl addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[moreImage]-0-|" options:0 metrics:nil views:titleMap]];
        
        [self layoutIfNeeded];
        _mainView.backgroundColor = OTHER_SEPARATOR_COLOR;
        CGFloat y = _mainView.frame.size.height / 14.0;
        CGFloat x = _mainView.frame.size.width / 6.0;
        _control0 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(0, 0, 3 * x, 4 * y)];
        _control1 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(3 * x, 0, 3 * x, 4 * y)];
        _control2 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(0, 4 * y, 2 * x, 5 * y)];
        _control3 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(2 * x, 4 * y, 2 * x, 5 * y)];
        _control4 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(4 * x, 4 * y, 2 * x, 5 * y)];
        _control5 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(0, 9 * y, 2 * x, 5 * y)];
        _control6 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(2 * x, 9 * y, 2 * x, 5 * y)];
        _control7 = [[XSThemeViewCell alloc] initWithFrame:CGRectMake(4 * x, 9 * y, 2 * x, 5 * y)];
        
        _controlArr = @[_control0, _control1, _control2, _control3, _control4, _control5, _control6, _control7];
        for (XSThemeViewCell *control in _controlArr) {
            [_mainView addSubview:control];
        }
    }
    return self;
}

- (void)setSubject:(NSArray *)subject {
    _subject                  = [subject copy];
    _tagLabel.backgroundColor = THEME_RED;
    _titleLabel.textColor     = MAIN_TITLE_COLOR;
    _titleLabel.text          = @"主题区";
    
    for (int i = 0; i < _controlArr.count; i++) {
        XSThemeViewCell *control = _controlArr[i];
        SubjectModel    *subject = _subject[i];
        
        control.titleLabel.text = subject.name;
        control.subTitleLabel.text = subject.subtitle;
        [control.picture sd_setImageWithURL:[NSURL URLWithString:subject.img]];
        
        if (i == 0) {
            control.frame = CGRectMake(control.frame.origin.x, control.frame.origin.y, control.frame.size.width - 0.25, control.frame.size.height);
        } else if (i == 1) {
            control.frame = CGRectMake(control.frame.origin.x + 0.25, control.frame.origin.y, control.frame.size.width - 0.25, control.frame.size.height);
        } else {
            control.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
            control.layer.borderWidth = 0.5f;
        }
    }
}
@end
