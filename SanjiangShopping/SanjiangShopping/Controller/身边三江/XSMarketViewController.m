//
//  XSMarketViewController.m
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/10/10.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import "XSMarketViewController.h"
#import "ThemeColor.h"
#import "XSNavigationBarHelper.h"
#import "XSSegmentControl.h"
#import <SDWebImage/SDWebImageDownloader.h>

@interface XSMarketViewController () <UIScrollViewDelegate, XSSegmentControlDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIView *titleView;
@property (strong, nonatomic) XSSegmentControl *segmentControl;

@property (strong, nonatomic) UIView *popular;
@property (strong, nonatomic) UIView *service;

@end

@implementation XSMarketViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 状态栏样式
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"三江门店";
    [XSNavigationBarHelper hackStandardNavigationBar:self.navigationController.navigationBar];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left"] style:UIBarButtonItemStylePlain target:self action:@selector(comeBack)];
    leftButtonItem.tintColor = [UIColor darkGrayColor];
    
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator   = NO;
    _scrollView.backgroundColor = BACKGROUND_COLOR;
    _scrollView.delegate        = self;
    [self.view addSubview:_scrollView];
    
    // title View
    CGFloat height = 0.0f;
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 125.0 + 50)];
    _titleView.backgroundColor   = [UIColor whiteColor];
    _titleView.layer.borderColor = [OTHER_SEPARATOR_COLOR CGColor];
    _titleView.layer.borderWidth = 0.5f;
    [_scrollView addSubview:_titleView];
    height += _titleView.frame.size.height;
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 125.0)];
    NSURL *imageURL = [NSURL URLWithString:@"http://img.sanjiang.com/act/20150817/176.slide.jpg"];
    
    __weak UIImageView *weakBgImageView = bgImageView;
    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
         // progression tracking code
     } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
         if (image && finished) {
             // do something with image
             weakBgImageView.image = [self blurryImage:image withBlurLevel:5.0];
         }
     }];
    [_titleView addSubview:bgImageView];
    
    // segmentControl
    NSArray *segTitles = @[@"热门活动", @"服务信息"];
    _segmentControl = [[XSSegmentControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(bgImageView.bounds), [UIScreen mainScreen].bounds.size.width, 50)];
    _segmentControl.titles   = segTitles;
    _segmentControl.delegate = self;
    _segmentControl.hasLine  = YES;
    _segmentControl.selectedIndex     = 0;
    _segmentControl.backgroundColor   = [UIColor whiteColor];
    _segmentControl.layer.borderColor = [BACKGROUND_COLOR CGColor];
    _segmentControl.layer.borderWidth = 1.0f;
    [_titleView addSubview:_segmentControl];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), height);
    
    _popular = [[[NSBundle mainBundle] loadNibNamed:@"Market" owner:self options:nil] objectAtIndex:0];
    _popular.frame = CGRectMake(0, CGRectGetHeight(_titleView.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 200);
    [_scrollView addSubview:_popular];
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_titleView.frame) + 200);
}

- (void)comeBack {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SegementControl Delegate 
- (void)segmentItemSelected:(XSSegmentControlItem *)item {
    if (_segmentControl.selectedIndex == 0) {
        NSLog(@"热门活动");
        [_service removeFromSuperview];
        
        [_scrollView addSubview:_popular];
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_titleView.frame) + 200);
    } else {
        NSLog(@"服务信息");
        [_popular removeFromSuperview];
        
        if (_service == nil) {
            _service = [[[NSBundle mainBundle] loadNibNamed:@"Market" owner:self options:nil] objectAtIndex:1];
            _service.frame = CGRectMake(0, CGRectGetHeight(_titleView.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 200);
        }
        
        [_scrollView addSubview:_service];
        
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight(_titleView.frame) + 200);
    }
}

// 高斯模糊处理
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {

    CIContext *context  = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:image.CGImage];
    
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform     = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //create a UIImage for this function to "return" so that ARC can manage the memory of the blur...
    //ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}

@end
