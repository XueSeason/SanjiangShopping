//
//  XSCodeGenerator.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSCodeGenerator : NSObject

+ (NSString *)formatCode:(NSString *)code;

+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size;
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size;

@end
