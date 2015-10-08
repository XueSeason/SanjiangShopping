//
//  XSHomeDynamicViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSHomeDynamicViewController.h"

#import "HomeModel.h"
#import "HomeMoreModel.h"

#import "XS4211View.h"
#import "XS1111GrayView.h"
#import "XS1111WhiteView.h"
#import "XSScrollView.h"
#import "XSBuyNowView.h"
#import "XSBannerView.h"
#import "XSThemeView.h"
#import "XSMoreView.h"

static const CGFloat step = 9.0f;

@interface XSHomeDynamicViewController ()

@end

@implementation XSHomeDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setData:(HomeDataModel *)data {
    // 清空所有子视图
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _data = data;
    NSArray *floors = data.floors;
    
    CGFloat height = 0.0f;
    CGFloat width  = [UIScreen mainScreen].bounds.size.width;
    
    for (FloorModel *floor in floors) {
        if (floor.vt == 1) {
            height += step;
            CGRect frame         = CGRectMake(0, height, width, width / 75 * 38 );
            XS4211View *tempView = [[XS4211View alloc] initWithFrame:frame];
            tempView.floorModel  = floor;
            [self.view addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 2) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, (width - 2) / 2 + 2 + 40 );
            XS1111GrayView *tempView = [[XS1111GrayView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.view addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 3) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, (width - 2) / 2 + 2 + 40 );
            XS1111WhiteView *tempView = [[XS1111WhiteView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.view addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 4) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, 160 + 40 );
            XSScrollView *tempView = [[XSScrollView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.view addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 5) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, width / 75.0 * 24.0 + 40);
            XSBuyNowView *tempView = [[XSBuyNowView alloc] initWithFrame:frame];
            tempView.floorModel = floor;
            [self.view addSubview:tempView];
            height += frame.size.height;
        } else if (floor.vt == 6) {
            height += step;
            CGRect frame = CGRectMake(0, height, width, width / 15.0 * 4.0 );
            XSBannerView *tempView = [[XSBannerView alloc] initWithFrame:frame];
            tempView.dataModels = floor.data;
            [self.view addSubview:tempView];
            height += frame.size.height;
        }
    }
    
    height += step;
    
    // 加载主题区
    CGRect themeFrame = CGRectMake(0, height, width, width / 75.0 * 84.0 + 40);
    XSThemeView *themeView = [[XSThemeView alloc] initWithFrame:themeFrame];
    themeView.subject      = data.subject;
    [self.view addSubview:themeView];
    height += themeView.frame.size.height;
    
    // 加载推荐视图
    CGRect recommendFrame = CGRectMake(0, themeFrame.size.height + themeFrame.origin.y, width, 44);
    UIView *recommend = [[UIView alloc] initWithFrame:recommendFrame];
    [self.view addSubview:recommend];
    height += recommendFrame.size.height;
    recommend.backgroundColor = [UIColor clearColor];
    UIView *temp = [[[NSBundle mainBundle] loadNibNamed:@"RecommendView" owner:self options:nil] objectAtIndex:0];
    temp.frame = recommend.bounds;
    [recommend addSubview:temp];
    
    _dynamicSize = CGSizeMake(width, height);
}

- (void)generateMoreView:(NSArray *)list {
    _moreView = [[UIView alloc] init];
    
    CGFloat width = (self.view.frame.size.width - 30) / 2.0;
    CGFloat height = width * 100 / 69.0;
    CGFloat dynamicHeight = 0.0f;
    
    for (int i = 0; i < list.count; i++) {
        CGRect frame = CGRectMake((i % 2) * (width + 10) + 10, dynamicHeight, width, height);
        
        XSMoreView *tempView = [[XSMoreView alloc] initWithFrame:frame];
        tempView.item        = list[i];
        [_moreView addSubview:tempView];
        [_moreViewArr addObject:tempView];
        if (i % 2 == 1) {
            dynamicHeight += frame.size.height + 10;
        }
    }

    [self.view addSubview:_moreView];
    
    CGFloat tempWidth = _dynamicSize.width;
    CGFloat tempHeight = _dynamicSize.height;
    
    _moreView.frame = CGRectMake(0, tempHeight, self.view.frame.size.width, dynamicHeight);
    _dynamicSize = CGSizeMake(tempWidth, tempHeight + _moreView.frame.size.height);
}

@end
