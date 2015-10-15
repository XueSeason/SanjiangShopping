//
//  XSBannerView.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XSBannerViewDelegate <NSObject>
- (void)bannerViewDidSelected:(NSInteger)index;
@end

@interface XSBannerView : UIView

@property (weak, nonatomic)   id<XSBannerViewDelegate> delegate;

@property (strong, nonatomic) UIScrollView  *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (copy, nonatomic)   NSArray       *dataModels;
@property (assign, nonatomic) BOOL          animationSwitch;

@end
