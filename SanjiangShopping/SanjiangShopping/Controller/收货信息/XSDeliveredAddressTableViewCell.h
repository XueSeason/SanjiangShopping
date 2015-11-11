//
//  XSDeliveredAddressTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/19.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSDeliveredAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *defaultAddressLabel;

@property (assign, nonatomic) BOOL hasSelected;
@end
