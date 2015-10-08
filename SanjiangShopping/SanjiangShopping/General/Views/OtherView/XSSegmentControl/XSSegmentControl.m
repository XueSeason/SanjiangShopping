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
@end

@interface XSSegmentControl ()
@property (strong, nonatomic) UILabel *scrolLine;
@end

@implementation XSSegmentControl

- (void)setTitles:(NSArray *)titles {
    _titles = [titles copy];
    
    NSMutableArray *segmentArr = [[NSMutableArray alloc] init];
    NSInteger count = _titles.count;
    CGFloat width = self.frame.size.width / count;
    self.backgroundColor = BACKGROUND_COLOR;
    for (int i = 0; i < count; i++) {
        XSSegmentControlItem *segmentItem = [[XSSegmentControlItem alloc] init];
        segmentItem.frame               = CGRectMake(i * width, 0, width, self.frame.size.height);
        segmentItem.tag                 = i;
        
        UILabel *label      = [[UILabel alloc] init];
        label.text          = _titles[i];
        label.font          = [label.font fontWithSize:14.0];
        label.frame         = CGRectInset(segmentItem.bounds, 10, 8);
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = [UIColor darkGrayColor];
        
        UILabel *line       = [[UILabel alloc] init];
        line.frame          = CGRectMake(label.frame.origin.x, label.frame.origin.y + label.frame.size.height + 6, label.frame.size.width, 2);
        
        segmentItem.label = label;
        [segmentItem addSubview:label];
        
        segmentItem.line = line;
        [segmentItem addSubview:line];
        
        [self addSubview:segmentItem];
        [segmentArr addObject:segmentItem];
        [segmentItem addTarget:self action:@selector(segmentSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _items = [segmentArr copy];
}

- (void)segmentSelected:(XSSegmentControlItem *)sender {
    
    self.selectedIndex = sender.tag;
    [_delegate segmentItemSelected:sender];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_scrolLine == nil && _hasLine) {
        XSSegmentControlItem *item = _items[selectedIndex];
        
        CGRect location = [item.line convertRect:item.line.bounds toView:self];
        _scrolLine = [[UILabel alloc] initWithFrame:location];
        _scrolLine.backgroundColor = THEME_RED;
        [self addSubview:_scrolLine];
    }
    
    for (int i = 0; i < _titles.count; i++) {
        XSSegmentControlItem *item = _items[i];
        if (selectedIndex != i) {
            item.label.textColor = [UIColor darkGrayColor];
        } else {
            item.label.textColor = THEME_RED;
            
            if (_hasLine) {
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect location = [item.line convertRect:item.line.bounds toView:self];
                    _scrolLine.frame = location;
                }];
            }
        }
    }
}

@end
