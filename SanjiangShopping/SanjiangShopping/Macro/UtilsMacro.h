//
//  UtilsMacro.h
//  SanjiangShop
//
//  Created by 薛纪杰 on 15/8/24.
//  Copyright (c) 2015年 薛纪杰. All rights reserved.
//

#ifndef SanjiangShop_UtilsMacro_h
#define SanjiangShop_UtilsMacro_h

#define UIColorFromRGB(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#endif
