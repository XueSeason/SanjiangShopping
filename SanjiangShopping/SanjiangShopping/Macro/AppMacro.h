//
//  AppMacro.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/24.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#ifndef SanjiangShop_AppMacro_h
#define SanjiangShop_AppMacro_h

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define THEME_BACKGROUND [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1.0]

//#define THEME_RED [UIColor colorWithRed:((float)((0xF03838 & 0xFF0000) >> 16))/255.0 green:((float)((0xF03838 & 0xFF00) >> 8))/255.0 blue:((float)(0xF03838 & 0xFF))/255.0 alpha:1.0]
//#define THEME_RED [UIColor colorWithRed:((float)((0xF15555 & 0xFF0000) >> 16))/255.0 green:((float)((0xF15555 & 0xFF00) >> 8))/255.0 blue:((float)(0xF15555 & 0xFF))/255.0 alpha:1.0]
#define THEME_RED_TRANSPARENT [UIColor colorWithRed:((float)((0xF03838 & 0xFF0000) >> 16))/255.0 green:((float)((0xF03838 & 0xFF00) >> 8))/255.0 blue:((float)(0xF03838 & 0xFF))/255.0 alpha:0.0]
#define THEME_RED_FADE(value) [UIColor colorWithRed:((float)((0xF03838 & 0xFF0000) >> 16))/255.0 green:((float)((0xF03838 & 0xFF00) >> 8))/255.0 blue:((float)(0xF03838 & 0xFF))/255.0 alpha:value]

#define MENU_COLOR [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0]
#define MENU_SEPARATOR_COLOR [UIColor colorWithRed:223 / 255.0 green:223 / 255.0 blue:223 / 255.0 alpha:1.0]

#define SEARCH_TABLE_THEME_COLOR [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1.0]
#define SEARCH_RESULT_BACKGROUND [UIColor colorWithRed:249 / 255.0 green:249 / 255.0 blue:249 / 255.0 alpha:1.0]

#define SEGMENT_LINE_COLOR [UIColor colorWithRed:223 / 255.0 green:223 / 255.0 blue:223 / 255.0 alpha:1.0]

#endif
