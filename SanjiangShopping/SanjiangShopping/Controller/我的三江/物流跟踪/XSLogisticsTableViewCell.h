//
//  XSLogisticsTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSLogisticsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
