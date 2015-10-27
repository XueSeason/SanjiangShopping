//
//  XSMyFavoriteTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/20.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSMyFavoriteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceNowLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceOldLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
