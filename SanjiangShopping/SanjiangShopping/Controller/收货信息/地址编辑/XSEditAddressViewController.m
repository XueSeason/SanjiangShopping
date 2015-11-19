//
//  XSEditAddressViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/19.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSEditAddressViewController.h"
#import "XSNavigationBarHelper.h"
#import "ThemeColor.h"

@interface XSEditAddressViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextField;

@property (strong, nonatomic) UIView *inputView;
@property (strong, nonatomic) UIPickerView *pickerView;

@end

@implementation XSEditAddressViewController
{
    NSInteger _row0, _row1;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self customNavigationBar];
    self.addressTextField.inputView = self.inputView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"HelloWorld";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (component == 0) {
        _row0 = row;
    }
    
    if (component == 1) {
        _row1 = row;
    }
}

#pragma mark - private methods
- (void)customNavigationBar {
    self.navigationItem.title = @"编辑地址";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = MAIN_TITLE_COLOR;
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selectAddressComplete {
    self.addressTextField.text = [NSString stringWithFormat:@"%ld %ld", _row0, _row1];
    [self.addressTextField endEditing:YES];
}

- (void)selectAddressClose {
    [self.addressTextField endEditing:YES];
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
