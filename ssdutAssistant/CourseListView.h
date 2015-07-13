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
-(void)adjustWeekDayBar;

/*
 *加载许多tableViews；
 */
-(void)initTableViews;
@end
