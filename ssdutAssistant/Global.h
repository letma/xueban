//
//  Global.h
//  ssdutAssistant
//
//  Created by OurEDA on 4/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#ifndef ssdutAssistant_Global_h
#define ssdutAssistant_Global_h

#define RGB(r, g, b) [UIColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]

#define UIIMGName(name) [UIImage imageNamed:name]

// UIColorFromRGB宏，从RGB值返回UIColor对象
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)( rgbValue & 0xFF))/255.0 \
alpha:1.0]


#define RECT(x, y, w, h) CGRectMake(x, y, w, h)

#define HEIGHT(view)  CGRectGetHeight(view.frame)
#define WIDTH(view)  CGRectGetWidth(view.frame)

// Screen height and weight
#define WINHEIGHT [UIScreen mainScreen].bounds.size.height
#define WINWIDTH  [UIScreen mainScreen].bounds.size.width


#endif
