//
//  XSNameView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/25.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSNameView.h"

#import "ThemeColor.h"

@implementation XSNameView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, self.frame.size.width - 16, self.frame.size.height / 9.0 * 4.0)];
        _moreInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, _nameLabel.frame.origin.y + _nameLabel.frame.size.height, self.frame.size.width - 16, self.frame.size.width / 15.0)];
        
        UILabel *oldLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, _moreInfoLabel.frame.origin.y + _moreInfoLabel.frame.size.height, 50, self.frame.size.width / 25.0)];
        _priceOldLabel = [[UILabel alloc] initWithFrame:CGRectMake(oldLabel.frame.size.width + oldLabel.frame.origin.x, _moreInfoLabel.frame.origin.y + _moreInfoLabel.frame.size.height, self.frame.size.width - (oldLabel.frame.size.width + oldLabel.frame.origin.x), self.frame.size.width / 25.0)];
        
        UILabel *nowLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, _priceOldLabel.frame.origin.y + _priceOldLabel.frame.size.height, 60, self.frame.size.width / 25.0 * 2.0)];
        _priceNowLabel = [[UILabel alloc] initWithFrame:CGRectMake(nowLabel.frame.origin.x + nowLabel.frame.size.width, _priceOldLabel.frame.origin.y + _priceOldLabel.frame.size.height, self.frame.size.width - (nowLabel.frame.origin.x + nowLabel.frame.size.width), self.frame.size.width / 25.0 * 2.0)];
        
        [self addSubview:_nameLabel];
        [self addSubview:_moreInfoLabel];
        [self addSubview:oldLabel];
        [self addSubview:_priceOldLabel];
        [self addSubview:nowLabel];
        [self addSubview:_priceNowLabel];
        
        _nameLabel.numberOfLines = 2;
        _nameLabel.textColor     = MAIN_TITLE_COLOR;
        _moreInfoLabel.font      = [_moreInfoLabel.font fontWithSize:14.0];
        _moreInfoLabel.textColor = THEME_RED;
        oldLabel.text            = @"零售价：";
        oldLabel.font            = [oldLabel.font fontWithSize:12.0];
        oldLabel.textColor       = SUB_TITLE_COLOR;
        _priceOldLabel.font      = [_priceOldLabel.font fontWithSize:12.0];
        _priceOldLabel.textColor = SUB_TITLE_COLOR;
        nowLabel.text            = @"会员价：";
        nowLabel.font            = [nowLabel.font fontWithSize:14.0];
        _priceNowLabel.font      = [_priceNowLabel.font fontWithSize:16.0];
        _priceNowLabel.textColor = THEME_RED;
        
        self.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
        self.layer.borderWidth = 0.5f;
        
        // 临时数据
        _nameLabel.text = @"好奇 Huggies 金装 婴儿纸尿裤 新生儿NB70+10片（0-5kg）";
        _moreInfoLabel.text = @"买点什么神马都是浮云的什么都是浮云";
        _priceNowLabel.text = @"￥95.60";
        _priceOldLabel.text = @"￥95.60";
    }
    return self;
}

- (void)layoutSubviews {
    
}
//@property (strong, nonatomic) UILabel *nameLabel;
//@property (strong, nonatomic) UILabel *moreInfoLabel;
//@property (strong, nonatomic) UILabel *priceNowLabel;
//@property (strong, nonatomic) UILabel *priceOldLabel;
//@property (strong, nonatomic) UILabel *discountLabel;

#pragma mark - getters and setters
//- (UILabel *)nameLabel {
//    if (_nameLabel == nil) {
//        
//    }
//    return _nameLabel;
//}
//
//- (UILabel *)moreInfoLabel {
//    if (_moreInfoLabel =) {
//        <#statements#>
//    }
//}

@end
