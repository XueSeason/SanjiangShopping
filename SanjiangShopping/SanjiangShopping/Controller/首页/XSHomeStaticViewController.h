//
//  XSHomeStaticViewController.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XSBannerView.h"
#import "XSButtonGridView.h"

@class HomeModel;

@interface XSHomeStaticViewController : UIViewController

@property (weak, nonatomic)   UIViewController *contextViewController;
@property (strong, nonatomic) XSBannerView *bannerView;
@property (strong, nonatomic) XSButtonGridView *buttonGridView;

@end
