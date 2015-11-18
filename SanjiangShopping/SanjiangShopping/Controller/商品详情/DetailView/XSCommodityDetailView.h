//
//  XSCommodityDetailView.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CommodityDetailViewBackBlock)(UIView *detailView);

@interface XSCommodityDetailView : UIView
- (instancetype)initWithBackBlock:(CommodityDetailViewBackBlock)block;
@end
