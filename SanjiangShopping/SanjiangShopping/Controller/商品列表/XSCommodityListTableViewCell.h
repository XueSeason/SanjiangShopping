//
//  XSCommodityListTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/17.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCommodityListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *pn;
@property (weak, nonatomic) IBOutlet UILabel *rate;

@end
