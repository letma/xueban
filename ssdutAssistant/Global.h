//
//  Global.h
//  ssdutAssistant
//
//  Created by OurEDA on 4/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#ifndef ssdutAssistant_Global_h
#define ssdutAssistant_Global_h

#define version @"2.0.0"

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

//UserDefaultsKey
//#define Setting_SwitchKey @"Setting_SwitchKey"


#define DLUT_IP @"http://210.30.100.93:8089/api/dlut/"
#define TEST_IP @"http://210.30.100.93:8089/"
//是否登陆
#define IF_Login @"IF_Login"
//Token
#define Token_Str @"Token_Str"

#define LoginToken_Str @"LoginToken_Str"
//用户的信息
#define UserContent_Key @"UserContent_Key"
//用户的名字
#define MyName_Key @"MyName_Key"
//用户的学号
#define MyStudentId_Key @"MyStudentId_Key"
//用户的全部课程信息
#define MyCourse_Key @"MyCourse_Key"
//纪录课程表信息是否存在
#define IF_CourseHave @"IF_CourseHave"







#endif
