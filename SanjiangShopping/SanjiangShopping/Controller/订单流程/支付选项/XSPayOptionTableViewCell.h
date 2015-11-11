//
//  XSPayOptionTableViewCell.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/9.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSPayOptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *onlineButton;
@property (weak, nonatomic) IBOutlet UIButton *offlineButton;

@property (assign, nonatomic) NSInteger option;

@end
