//
//  XSSegmentControl.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/8.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XSSegmentControlItem;

@protocol XSSegmentControlDelegate <NSObject>
@required
- (void)segmentItemSelected:(XSSegmentControlItem *)item;
@end

@interface XSSegmentControlItem : UIControl
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *line;
@end

@interface XSSegmentControl : UIView
@property (copy, nonatomic)   NSArray *items;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (copy, nonatomic)   NSArray *titles;
@property (weak, nonatomic) id<XSSegmentControlDelegate> delegate;
@property (assign, nonatomic) BOOL hasLine;
@end
