//
//  XSHomeViewController.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;
@class HomeDataModel;
@class HomeMoreModel;

@interface XSHomeViewController : UIViewController
@property (strong, nonatomic) HomeModel     *homeModel;
@property (strong, nonatomic) HomeDataModel *homeDataModel;
@property (strong, nonatomic) HomeMoreModel *homeMoreMedel;
@end
