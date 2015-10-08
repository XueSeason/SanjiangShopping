//
//  XSThemeView.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/25.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSThemeViewCell : UIControl
@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UILabel     *subTitleLabel;
@property (strong, nonatomic) UIImageView *picture;
@end

@interface XSThemeView : UIView
@property (strong, nonatomic) UIControl       *moreControl;
@property (strong, nonatomic) XSThemeViewCell *control0;
@property (strong, nonatomic) XSThemeViewCell *control1;
@property (strong, nonatomic) XSThemeViewCell *control2;
@property (strong, nonatomic) XSThemeViewCell *control3;
@property (strong, nonatomic) XSThemeViewCell *control4;
@property (strong, nonatomic) XSThemeViewCell *control5;
@property (strong, nonatomic) XSThemeViewCell *control6;
@property (strong, nonatomic) XSThemeViewCell *control7;
@property (copy, nonatomic)   NSArray         *subject;
@end
