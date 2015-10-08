//
//  XSScrollView.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/24.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FloorModel;

@interface XSScrollView : UIView

@property (strong, nonatomic) UIControl *moreControl;

@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) FloorModel *floorModel;

@end
