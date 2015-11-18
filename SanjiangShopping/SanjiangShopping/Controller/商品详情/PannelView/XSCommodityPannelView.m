//
//  XSCommodityPannelView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityPannelView.h"

#import "ThemeColor.h"

@interface XSCommodityPannelView ()
@property (weak, nonatomic) IBOutlet UIView *favoriteContentView;
@property (weak, nonatomic) IBOutlet UIView *shoppingCartContentView;
@end

@implementation XSCommodityPannelView

- (void)awakeFromNib {
    self.layer.borderWidth  = 0.5f;
    self.layer.borderColor  = [OTHER_SEPARATOR_COLOR CGColor];
    CALayer *line = [[CALayer alloc] init];
    line.frame = CGRectMake(65, 0, 0.5, 50);
    line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
    [self.layer addSublayer:line];
}

@end
