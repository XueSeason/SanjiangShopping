//
//  XSReusltTableViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/8.
//  Copyright (c) 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSResultTableViewController.h"
#import "XSSegmentControl.h"

@interface XSResultTableViewController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation XSResultTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

@end




