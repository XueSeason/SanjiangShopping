//
//  ThemeColor.h
//  SanjiangShopping
//
//  Created by 薛纪杰 on 15/9/22.
//  Copyright © 2015年 Sanjiang Shopping Club Co., Ltd. All rights reserved.
//

#ifndef ThemeColor_h
#define ThemeColor_h

#import "UtilsMacro.h"

// 灰色系文字与数字颜色
#define BARCODE_NUMBER_COLOR UIColorFromRGB(0x000000, 1.0)
#define MAIN_TITLE_COLOR UIColorFromRGB(0x333333, 1.0)
#define SUB_TITLE_COLOR UIColorFromRGB(0x666666, 1.0)

// 彩色系颜色
#define THEME_RED UIColorFromRGB(0xf03838, 1.0)
#define THEME_ORANGE UIColorFromRGB(0xfb9236, 1.0)
#define THEME_BLUE UIColorFromRGB(0x56b0f5, 1.0)
#define THEME_GREEN UIColorFromRGB(0x45b115, 1.0)

// 分割线，按钮变灰
#define COUPON_GRAY UIColorFromRGB(0xaaaaaa, 1.0)
#define TITLE_UNDERLINE_COLOR UIColorFromRGB(0xbbbbbb, 1.0)
#define SEARCH_FIELD_BORDER_COLOR UIColorFromRGB(0xbbbbbb, 1.0)
#define BUTTON_GRAY UIColorFromRGB(0xcccccc, 1.0)
#define OTHER_SEPARATOR_COLOR UIColorFromRGB(0xdddddd, 1.0)
#define COMMODITY_BORDER_COLOR UIColorFromRGB(0xdddddd, 1.0)
#define BACKGROUND_COLOR UIColorFromRGB(0xf6f6f6, 1.0)
#define HOME_SEARCH_FIELD_BACKGROUND_COLOR UIColorFromRGB(0xf8f8f8, 0.9)

// 透明度
#define POP_ALERT_VIEW_BACKGROUND_COLOR UIColorFromRGB(0x000000, 0.3)
#define ACCOUNT_CENTER_BACKGROUND_COLOR UIColorFromRGB(0x000000, 0.2)
#define AVATAR_BORDER_COLOR UIColorFromRGB(0xffffff, 0.6)

// 自定义
#define THEME_TRANSPARENT [UIColor colorWithRed:((float)((0xFFFFFF & 0xFF0000) >> 16))/255.0 green:((float)((0xFFFFFF & 0xFF00) >> 8))/255.0 blue:((float)(0xFFFFFF & 0xFF))/255.0 alpha:0.0]
#define THEME_RED_FADE(value) [UIColor colorWithRed:((float)((0xF03838 & 0xFF0000) >> 16))/255.0 green:((float)((0xF03838 & 0xFF00) >> 8))/255.0 blue:((float)(0xF03838 & 0xFF))/255.0 alpha:value]
#define THEME_WHITE_FADE(value) [UIColor colorWithRed:((float)((0xFFFFFF & 0xFF0000) >> 16))/255.0 green:((float)((0xFFFFFF & 0xFF00) >> 8))/255.0 blue:((float)(0xFFFFFF & 0xFF))/255.0 alpha:value]
#define THEME_BLACK_FADE(value) [UIColor colorWithRed:((float)((0x000000 & 0xFF0000) >> 16))/255.0 green:((float)((0x000000 & 0xFF00) >> 8))/255.0 blue:((float)(0x000000 & 0xFF))/255.0 alpha:value]

#endif /* ThemeColor_h */
