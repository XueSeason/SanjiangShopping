//
//  XSCommodityOptionTableViewCell.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 11/18/15.
//  Copyright © 2015 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSCommodityOptionTableViewCell.h"

#import "ThemeColor.h"

@interface XSCommodityOptionTableViewCell () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UIView *promotionView;
@property (weak, nonatomic) IBOutlet UIView *addressView;

@property (strong, nonatomic) UIView *inputView;
@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation XSCommodityOptionTableViewCell
{
    NSInteger _row0, _row1, _row2;
}

- (void)awakeFromNib {
    self.backgroundColor = BACKGROUND_COLOR;

    self.mainView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    self.mainView.layer.borderWidth = 0.5f;
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(10, 45, [UIScreen mainScreen].bounds.size.width, 0.5);
    line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
    [self.mainView.layer addSublayer:line];
    
    line = [CALayer layer];
    line.frame = CGRectMake(10, 90, [UIScreen mainScreen].bounds.size.width, 0.5);
    line.backgroundColor = [OTHER_SEPARATOR_COLOR CGColor];
    [self.mainView.layer addSublayer:line];
    
    self.selectAddressTextField.inputView = self.inputView;
    self.selectAddressTextField.tintColor = [UIColor clearColor];
    
    self.selectView.userInteractionEnabled = YES;
    [self.selectView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectViewTap)]];
}

#pragma mark - events response
- (void)selectAddressComplete {
    self.selectAddressTextField.text = [NSString stringWithFormat:@"海曙区%ld 海曙区%ld 海曙区%ld", _row0, _row1, _row2];
    [self.selectAddressTextField endEditing:YES];
}

- (void)selectAddressClose {
    [self.selectAddressTextField endEditing:YES];
}

- (void)selectViewTap {
    if (self.selectBlock) {
        self.selectBlock();
    }
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"海曙区";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        _row0 = row;
    } else if (component == 1) {
        _row1 = row;
    } else if (component == 2) {
        _row2 = row;
    }
}

#pragma mark - getters and setters
- (UIView *)inputView {
    if (_inputView == nil) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 244)];
        _inputView.backgroundColor = [UIColor whiteColor];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_inputView.bounds), 44)];
        toolbar.backgroundColor = [UIColor whiteColor];
        toolbar.tintColor = [UIColor redColor];
        [_inputView addSubview:toolbar];
        
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(selectAddressClose)];
        UIBarButtonItem *completeItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectAddressComplete)];
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        toolbar.items = @[closeItem, spaceItem, completeItem];
        
        self.pickerView.frame = CGRectMake(0, 44, CGRectGetWidth(_inputView.bounds), 200);
        _row0 = 0;
        _row1 = 0;
        _row2 = 0;
        [_inputView addSubview:self.pickerView];
    }
    return _inputView;
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate   = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
