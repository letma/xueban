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


#define DLUT_IP @"http://210.30.100.93/xueban/api/dlut/"
#define TEST_IP @"http://210.30.100.93:8089/"

/*
 0 学生周知
 1 校园新闻
 2 活动公告
 */
#define DLUT_NEWS_IP @"http://210.30.100.93/ssdutNews/"
#define DLUT_SOCIAL_IP @"http://210.30.100.93:8089/common/"

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
//用户的本学期成绩信息
#define MyScore_Key @"MyScore_Key"
//用户的所有成绩信息
#define AllMyScore_Key @"AllMyScore_Key"
//用户的全部课程信息
#define MyCourse_Key @"MyCourse_Key"
//已经排序的课程信息
#define MyCourseSorted_Key @"MyCourseSorted_Key"
//纪录课程表信息是否存在
#define IF_CourseHave @"IF_CourseHave"
//纪录课表色块的颜色使用情况
#define MyCourseColor_Key @"MyCourseColor_Key"
//用户的借阅信息
#define MyBorrowMessage_Key @"MyBorrowMessage_Key"
//用户的考场安排
#define MyExamMessage_Key @"MyExamMessage_Key"


//课程临时颜色
#define TempCourseColor @"TempCourseColor"
//课程的序号
#define TempCourseID @"TempCourseID"
//课程是否覆盖
#define TempIFCover @"TempIFCover"
//当前的周次
#define TempNowWeek @"TempNowWeek"


//判断视图是进入课程详情
#define IFPresentToCourseContent @"IFPresentToCourseContent"






#endif
