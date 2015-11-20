//
//  XSCommodityDetailView.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityDetailView.h"

#import "XSSegmentControl.h"

#import "ThemeColor.h"

static NSString * const cellID = @"detail";

@interface XSCommodityDetailView () <UITableViewDataSource, UITableViewDelegate, XSSegmentControlDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) XSSegmentControl *segmentControl;
@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) CommodityDetailViewBackBlock backBlock;

@end

@implementation XSCommodityDetailView
{
    BOOL _canInspect;
}

#pragma mark - init
- (instancetype)initWithBackBlock:(CommodityDetailViewBackBlock)block {
    self = [super init];
    if (self) {
        self.backBlock = block;
        [self addSubview:self.tableView];
        [self addSubview:self.segmentControl];
        _canInspect = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - UIScorllViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat estimate = -80;
    CGFloat limit = -64 * 2 + estimate;
    if (scrollView.contentOffset.y < limit && _canInspect) {
        NSLog(@"上边界超出");
        _canInspect = NO;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.backBlock(weakSelf);
        } completion:^(BOOL finished) {
            _canInspect = YES;
        }];
    }
}


#pragma mark - XSSegmentControlDelegate
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - getters and setters
- (XSSegmentControl *)segmentControl {
    if (_segmentControl == nil) {
        NSArray *segmentTitles = @[@"商品介绍", @"规格参数", @"包装售后"];
        _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 50)];
        _segmentControl.titles = segmentTitles;
        _segmentControl.delegate = self;
        _segmentControl.hasLine = YES;
        _segmentControl.selectedIndex = 0;
        _segmentControl.backgroundColor = [UIColor whiteColor];
    }
    return _segmentControl;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];

        _tableView.delegate   = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = BACKGROUND_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator   = NO;
        
        _tableView.rowHeight = [UIScreen mainScreen].bounds.size.height - 64 - 50;
        
        _tableView.contentInset = UIEdgeInsetsMake(64 + 50, 0, 50, 0);
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

@end
