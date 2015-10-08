//
//  XSHomeDynamicViewController.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeDataModel;
@interface XSHomeDynamicViewController : UIViewController
@property (assign, nonatomic) CGSize dynamicSize;
// 数据
@property (strong, nonatomic) HomeDataModel *data;
// 视图
@property (strong, nonatomic) NSMutableArray *moreViewArr;
@property (strong, nonatomic) UIView *moreView;
- (void)generateMoreView:(NSArray *)list;

@end
