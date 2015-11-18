//
//  XSSegmentControl.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/8.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSegmentControl.h"
#import "ThemeColor.h"

@implementation XSSegmentControlItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.label];
        [self addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame  = CGRectInset(self.bounds, 10, 8);
    self.line.frame   = CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y + self.label.frame.size.height + 6, self.label.frame.size.width, 1);
}

#pragma mark - getters and setters
- (UILabel *)label {
    if (_label == nil) {
        _label               = [[UILabel alloc] init];
        _label.font          = [_label.font fontWithSize:15.0];
        _label.minimumScaleFactor = 12.0 / _label.font.pointSize;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor     = [UIColor darkGrayColor];
    }
    return _label;
}

- (UILabel *)line {
    if (_line == nil) {
        _line = [[UILabel alloc] init];
    }
    return _line;
}
@end

@interface XSSegmentControl ()
@property (strong, nonatomic) UILabel *scrolLine;
@end
@implementation XSSegmentControl
- (void)layoutSubviews {
    [super layoutSubviews];
    XSSegmentControlItem *item = self.items[self.selectedIndex];
    CGRect location = [item.line convertRect:item.line.bounds toView:self];
    self.scrolLine.frame = location;
}

#pragma mark - private methods
- (void)segmentSelected:(XSSegmentControlItem *)sender {
    
    self.selectedIndex = sender.tag;
    [_delegate segmentItemSelected:sender];
}

#pragma mark - getters and setters
- (UILabel *)scrolLine {
    if (_scrolLine == nil) {
        _scrolLine = [[UILabel alloc] init];
        _scrolLine.backgroundColor = THEME_RED;
    }
    return _scrolLine;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    if (self.hasLine && ![self.subviews containsObject:self.scrolLine]) {
        [self addSubview:self.scrolLine];
    }
    
    for (int i = 0; i < self.titles.count; i++) {
        XSSegmentControlItem *item = self.items[i];
        if (selectedIndex != i) {
            item.label.textColor = [UIColor darkGrayColor];
        } else {
            item.label.textColor = THEME_RED;
            
            if (self.hasLine) {
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect location = [item.line convertRect:item.line.bounds toView:self];
                    self.scrolLine.frame = location;
                }];
            }
        }
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = [titles copy];
    
    NSMutableArray *segmentArr = [[NSMutableArray alloc] init];
    NSInteger count = titles.count;
    CGFloat width = self.frame.size.width / count;
    self.backgroundColor = BACKGROUND_COLOR;
    for (int i = 0; i < count; i++) {
        XSSegmentControlItem *segmentItem = [[XSSegmentControlItem alloc] init];
        segmentItem.frame        = CGRectMake(i * width, 0, width, self.frame.size.height);
        segmentItem.tag          = i;
        segmentItem.label.text   = _titles[i];
        
        [self addSubview:segmentItem];
        [segmentArr addObject:segmentItem];
        [segmentItem addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _items = [segmentArr copy];
}

@end
