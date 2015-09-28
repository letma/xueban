//
//  CourseListView.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/6.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

// 7 : 17 : 10*4
#import <UIKit/UIKit.h>

@interface CourseListView : UIView

/*
 *加载课表
 */
-(void)initCourseListView;

/*
 *调整weekDayBay的位置
 */
-(void)adjustWeekDayBarAndSectionView;

/*
 *加载7个scrollView；
 */
-(void)initViews;

/*
 *加载节次的view
 */
-(void)initVerticalViews;

/*
 *添加课程
 */
-(void)insertLessonsWithCourse:(NSString *)course Local:(NSString *)local ColorIndex:(NSInteger)index weekDay:(NSInteger)weekDay lesson:(NSInteger)lesson number:(NSInteger)num ifCover:(BOOL)ifCover;

/*
 *根据内容 及周次添加课程
 */
-(void)loadCourseWithContent:(NSArray *)contentArr WithWeekIndex:(NSInteger)weekIndex;

@end
