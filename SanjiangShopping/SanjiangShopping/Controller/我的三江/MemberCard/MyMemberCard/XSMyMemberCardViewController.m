//
//  XSMyMemberCardViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMyMemberCardViewController.h"
#import "XSCodeGenerator.h"
#import "ThemeColor.h"

@interface XSMyMemberCardViewController ()
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *barCodeView;
@property (weak, nonatomic) IBOutlet UIImageView *barCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *barCodeLabel;

@property (weak, nonatomic) IBOutlet UIView *qrCodeView;
@property (weak, nonatomic) IBOutlet UIImageView *qrCodeImageView;

@property (copy, nonatomic) NSString *code;

@end

@implementation XSMyMemberCardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    
    [self loadCode];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;

    self.navigationItem.title = @"我的会员卡";
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"会员权益" style:UIBarButtonItemStylePlain target:self action:@selector(detailInfo)];
    [rightBarButton setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    _codeView.layer.cornerRadius = 5;
    _codeView.clipsToBounds = YES;
    
    _barCodeLabel.textColor = BARCODE_NUMBER_COLOR;
}

- (void)loadCode {
    _code = @"73951057996109076502";
    _barCodeLabel.text      = [XSCodeGenerator formatCode:_code];
    _barCodeImageView.image = [XSCodeGenerator generateBarCode:_code size:_barCodeImageView.frame.size];
    _qrCodeImageView.image  = [XSCodeGenerator generateQRCode:_code size:_qrCodeImageView.frame.size];
}

#pragma mark - button click
- (void)detailInfo {
    
}

@end
