//
//  XSSelectCommodityViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/19/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSSelectCommodityViewController.h"
#import "ThemeColor.h"

#import "XSSelectCommodityRadioTableViewCell.h"
#import "XSSelectCommodityCountTableViewCell.h"

static NSString * const RadioID = @"radio";
static NSString * const countID = @"count";

@interface XSSelectCommodityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation XSSelectCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[XSSelectCommodityRadioTableViewCell class] forCellReuseIdentifier:RadioID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XSSelectCommodityRadioTableViewCell" bundle:nil] forCellReuseIdentifier:RadioID];
    [self.tableView registerClass:[XSSelectCommodityCountTableViewCell class] forCellReuseIdentifier:countID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XSSelectCommodityCountTableViewCell" bundle:nil] forCellReuseIdentifier:countID];
    self.tableView.tableFooterView = [UIView new];
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, 149.5, [UIScreen mainScreen].bounds.size.width - 50, 0.5);
    line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
    [self.titleView.layer addSublayer:line];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        XSSelectCommodityRadioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RadioID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        XSSelectCommodityCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:countID forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"click");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 200.0;
    } else {
        return 50.0;
    }
}

@end
