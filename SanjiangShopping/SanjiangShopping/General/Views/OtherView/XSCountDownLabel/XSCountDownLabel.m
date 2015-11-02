//
//  XSCountDownLabel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/28.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCountDownLabel.h"

@interface XSCountDownLabel ()
@property (strong, nonatomic) UILabel *label0;
@property (strong, nonatomic) UILabel *label1;

@end

@implementation XSCountDownLabel

- (void)countDown:(int)totalTime {
    __block int timeout = totalTime;

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"计时结束");
                _hourLabel.text   = @"00";
                _minuteLabel.text = @"00";
                _secondLabel.text = @"00";
            });
        } else {
            int hours   = timeout / 3600;
            int minutes = (timeout - hours * 3600) / 60;
            int seconds = timeout - hours * 3600 - minutes * 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _hourLabel.text   = [NSString stringWithFormat:@"%.2d", hours];
                _minuteLabel.text = [NSString stringWithFormat:@"%.2d", minutes];
                _secondLabel.text = [NSString stringWithFormat:@"%.2d", seconds];
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width   = 24.0;
    CGFloat height  = 18.0;
    CGFloat space   = (self.frame.size.height - height) / 2.0;
    self.hourLabel.frame   = CGRectMake(0, space, width, height);
    self.label0.frame      = CGRectMake(self.hourLabel.frame.size.width + self.hourLabel.frame.origin.x, space, 8, height);
    self.minuteLabel.frame = CGRectMake(self.label0.frame.origin.x + self.label0.frame.size.width, space, width, height);
    self.label1.frame      = CGRectMake(self.minuteLabel.frame.origin.x + self.minuteLabel.frame.size.width, space, 8, height);
    self.secondLabel.frame = CGRectMake(self.label1.frame.origin.x + self.label1.frame.size.width, space, width, height);
    
    [self addSubview:self.hourLabel];
    [self addSubview:self.label0];
    [self addSubview:self.minuteLabel];
    [self addSubview:self.label1];
    [self addSubview:self.secondLabel];
}

#pragma mark - getters and setters
- (UILabel *)hourLabel {
    if (_hourLabel == nil) {
        _hourLabel = [[UILabel alloc] init];
        _hourLabel.textColor          = [UIColor whiteColor];
        _hourLabel.font               = [_hourLabel.font fontWithSize:14.0];
        _hourLabel.textAlignment      = NSTextAlignmentCenter;
        _hourLabel.backgroundColor    = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
        _hourLabel.layer.cornerRadius = 2.0f;
        _hourLabel.clipsToBounds      = YES;
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel {
    if (_minuteLabel == nil) {
        _minuteLabel = [[UILabel alloc] init];
        _minuteLabel.textColor          = [UIColor whiteColor];
        _minuteLabel.font               = [_hourLabel.font fontWithSize:14.0];
        _minuteLabel.textAlignment      = NSTextAlignmentCenter;
        _minuteLabel.backgroundColor    = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
        _minuteLabel.layer.cornerRadius = 2.0f;
        _minuteLabel.clipsToBounds      = YES;
    }
    return _minuteLabel;
}

- (UILabel *)secondLabel {
    if (_secondLabel == nil) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.textColor          = [UIColor whiteColor];
        _secondLabel.font               = [_hourLabel.font fontWithSize:14.0];
        _secondLabel.textAlignment      = NSTextAlignmentCenter;
        _secondLabel.backgroundColor    = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
        _secondLabel.layer.cornerRadius = 2.0f;
        _secondLabel.clipsToBounds      = YES;
    }
    return _secondLabel;
}

- (UILabel *)label0 {
    if (_label0 == nil) {
        _label0 = [[UILabel alloc] init];
        _label0.text = @":";
        _label0.textAlignment = NSTextAlignmentCenter;
    }
    return _label0;
}

- (UILabel *)label1 {
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] init];
        _label1.text = @":";
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}

@end
