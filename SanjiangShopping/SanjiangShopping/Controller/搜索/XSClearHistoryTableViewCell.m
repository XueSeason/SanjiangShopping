//
//  XSClearHistoryTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/7.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSClearHistoryTableViewCell.h"

@implementation XSClearHistoryTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle  = UITableViewCellSelectionStyleNone;
    self.selected        = NO;
}

@end
