//
//  LessonCardView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/16.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "LessonCardView.h"
@interface LessonCardView()
@property (nonatomic) IBOutlet UILabel * lessonLbl;
@property (nonatomic) IBOutlet UILabel * teacherLbl;
@property (nonatomic) IBOutlet UILabel * creditLbl;
@property (nonatomic) IBOutlet UILabel * weekLbl;
@property (nonatomic) IBOutlet UILabel * dayLbl;
@property (nonatomic) IBOutlet UILabel * classroomLbl;

@end

@implementation LessonCardView

- (void)setCardWithLesson :(NSString *)lesson Teacher:(NSString *)teacher Credit:(NSString *)credit Week:(NSString *)week Day:(NSString *)day Classroom:(NSString *)classroom Color:(NSInteger)colorValue
{
    self.lessonLbl.textColor = UIColorFromRGB(colorValue);
    
    self.lessonLbl.text = lesson;
    self.teacherLbl.text = teacher;
    self.creditLbl.text = credit;
    self.weekLbl.text = week;
    self.dayLbl.text = day;
    self.classroomLbl.text = classroom;
}

@end
