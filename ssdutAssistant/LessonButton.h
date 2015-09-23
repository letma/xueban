//
//  LessonButton.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/16.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonButton : UIButton

    //课程名
@property(nonatomic) NSMutableArray * courseArray;
    //教师姓名
@property(nonatomic)    NSMutableArray * teacherArray;
    //学分信息
@property(nonatomic)    NSMutableArray * pointArray;
    //周数信息
@property(nonatomic)    NSMutableArray * weekArray;
    //节次信息
@property(nonatomic)    NSMutableArray * sectionArray;
    //地点信息
@property(nonatomic)    NSMutableArray * localArray;
    //颜色数值
@property(nonatomic)    NSInteger colorValue;

/*
 *设置cell的课程名 上课地点 背景颜色
 */
-(void)setCourse:(NSString *)courseStr Local:(NSString *)localStr BackgroundColor:(NSInteger)colorValue IfCover:(BOOL)ifCover CornerIndex:(NSInteger)cornerIndex;

-(void)setCourseFont:(CGFloat)courseSize LocalFont:(CGFloat)localSize;
@end
