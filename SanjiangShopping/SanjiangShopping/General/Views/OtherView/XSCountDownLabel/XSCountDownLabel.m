//
//  XSCountDownLabel.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/28.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCountDownLabel.h"

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
    _hourLabel      = [[UILabel alloc] initWithFrame:CGRectMake(0, space, width, height)];
    UILabel *label0 = [[UILabel alloc] initWithFrame:CGRectMake(_hourLabel.frame.size.width + _hourLabel.frame.origin.x, space, 8, height)];
    _minuteLabel    = [[UILabel alloc] initWithFrame:CGRectMake(label0.frame.origin.x + label0.frame.size.width, space, width, height)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(_minuteLabel.frame.origin.x + _minuteLabel.frame.size.width, space, 8, height)];
    _secondLabel    = [[UILabel alloc] initWithFrame:CGRectMake(label1.frame.origin.x + label1.frame.size.width, space, width, height)];
    
    label0.text = @":";
    label1.text = @":";
    label0.textAlignment = NSTextAlignmentCenter;
    label1.textAlignment = NSTextAlignmentCenter;
    
    _hourLabel.textColor       = [UIColor whiteColor];
    _hourLabel.font            = [_hourLabel.font fontWithSize:14.0];
    _hourLabel.textAlignment   = NSTextAlignmentCenter;
    _minuteLabel.textColor     = [UIColor whiteColor];
    _minuteLabel.font          = [_hourLabel.font fontWithSize:14.0];
    _minuteLabel.textAlignment = NSTextAlignmentCenter;
    _secondLabel.textColor     = [UIColor whiteColor];
    _secondLabel.font          = [_hourLabel.font fontWithSize:14.0];
    _secondLabel.textAlignment = NSTextAlignmentCenter;
    
    _hourLabel.backgroundColor   = [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
    _minuteLabel.backgroundColor = _hourLabel.backgroundColor;
    _secondLabel.backgroundColor = _hourLabel.backgroundColor;
    
    _hourLabel.layer.cornerRadius   = 2.0f;
    _minuteLabel.layer.cornerRadius = 2.0f;
    _secondLabel.layer.cornerRadius = 2.0f;
    
    _hourLabel.clipsToBounds   = YES;
    _minuteLabel.clipsToBounds = YES;
    _secondLabel.clipsToBounds = YES;
    
    [self addSubview:_hourLabel];
    [self addSubview:label0];
    [self addSubview:_minuteLabel];
    [self addSubview: label1];
    [self addSubview:_secondLabel];
}
@end
