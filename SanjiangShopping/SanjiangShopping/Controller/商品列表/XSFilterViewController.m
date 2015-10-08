//
//  XSFilterViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/18.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSFilterViewController.h"

#import "XSDropView.h"

@interface XSFilterViewController () <XSDropViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *brandView;
@property (strong, nonatomic) XSDropView *dropView;
@property (strong, nonatomic) UIButton *clearButton;

@end

@implementation XSFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dropView                   = [[XSDropView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    _dropView.title             = @"品牌";
    _dropView.contentHeight     = 180;
    _dropView.dropContentView   = [[UIView alloc] init];
    _dropView.delegate          = self;
    _dropView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _dropView.layer.borderWidth = 0.5f;
    [_brandView addSubview:_dropView];
    
    CGFloat space = (_dropView.frame.size.width - 200) / 2.0;
    _clearButton = [[UIButton alloc] initWithFrame:CGRectMake(space, _dropView.frame.origin.y + _dropView.frame.size.height + 8, 200, 30)];
    [_clearButton setTitle:@"清除筛选项" forState:UIControlStateNormal];
    [_clearButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _clearButton.titleLabel.font = [_clearButton.titleLabel.font fontWithSize:14.0];
    _clearButton.layer.borderWidth  = 1.0f;
    _clearButton.layer.cornerRadius = 5.0;
    _clearButton.layer.borderColor  = [[UIColor lightGrayColor] CGColor];
    [_brandView addSubview:_clearButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dropDown:(UIView *)dropContentView {
    [UIView animateWithDuration:0.2 animations:^{
        CGFloat space = (_dropView.frame.size.width - 200) / 2.0;
        _clearButton.frame = CGRectMake(space, _dropView.frame.origin.y + _dropView.frame.size.height + 8, 200, 30);
    }];
}

@end
