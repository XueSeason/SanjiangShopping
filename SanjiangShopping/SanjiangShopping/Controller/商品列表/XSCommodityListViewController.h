//
//  XSCommodityListViewController.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/9.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSSegmentControl.h"

@interface XSCommodityListViewController : UIViewController

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) XSSegmentControl   *segmentControl;
@property (copy, nonatomic) NSString *searchWords;

- (void)reloadData;

@end
