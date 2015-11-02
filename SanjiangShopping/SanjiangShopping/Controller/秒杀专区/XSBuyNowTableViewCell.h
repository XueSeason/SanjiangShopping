//
//  XSBuyNowTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/2/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBuyNowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNowLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOldLabel;
@property (weak, nonatomic) IBOutlet UIButton *buyNowButton;

@end
