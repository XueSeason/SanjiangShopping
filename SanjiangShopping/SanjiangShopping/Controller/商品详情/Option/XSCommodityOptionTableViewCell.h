//
//  XSCommodityOptionTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCommodityOptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *selectView;
@property (weak, nonatomic) IBOutlet UITextField *selectAddressTextField;

@property (copy, nonatomic) void (^selectBlock)();

@end
