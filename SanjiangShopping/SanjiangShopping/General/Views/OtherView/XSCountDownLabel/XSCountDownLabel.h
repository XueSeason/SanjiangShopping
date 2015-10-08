//
//  XSCountDownLabel.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/28.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCountDownLabel : UIView

@property (strong, nonatomic) UILabel *hourLabel;
@property (strong, nonatomic) UILabel *minuteLabel;
@property (strong, nonatomic) UILabel *secondLabel;

- (void)countDown:(int)totalTime;
@end
