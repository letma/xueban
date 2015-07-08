//
//  CourseListView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/6.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//



#import "CourseListView.h"
#import "SectionView.h"
#import "WeekDayButton.h"

@interface CourseListView()
@property (nonatomic) IBOutlet UIView * horizonView;
@property (nonatomic) IBOutlet UIView * verticalView;
@property (nonatomic) IBOutlet UIScrollView * horizonScrollView;
@property (nonatomic) IBOutlet UIScrollView * verticalScrollView;
@end

@implementation CourseListView

// 7 : 17 : 10*4
-(void)initCourseListView
{

    [self insetSectionViews];
    
    [self insertWeekDayViews];
    
}

//添加左边栏的课节views
- (void)insetSectionViews
{
    CGFloat sectionHeight ;
    CGFloat sectionWidth = WINWIDTH/64.0*7;
    if (WINHEIGHT == 480) {
        sectionHeight = (WINHEIGHT - 64)/9.0;
    }else{
        sectionHeight = (WINHEIGHT - 64)/11.0;
    }
    for (NSInteger i = 0 ; i < 12; i ++) {
        NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"SectionView" owner:self options:nil];
        SectionView * sectionView = [nibArray objectAtIndex:0];
        [sectionView initSectionView:i];
        sectionView.frame = CGRectMake(0, 0 + sectionHeight * i, sectionWidth, sectionHeight);
        NSLog(@"%f",sectionHeight);
        [self.verticalView addSubview:sectionView];
    }
}

//添加上边的weekDayViews
- (void)insertWeekDayViews
{
    CGFloat weekDayHeight ;
    CGFloat weekDayWidth = WINWIDTH/64.0*10;
    if (WINHEIGHT == 480) {
        weekDayHeight = (WINHEIGHT - 64)/9.0;
    }else{
        weekDayHeight = (WINHEIGHT - 64)/11.0;
    }
    
    NSDate * now = [NSDate date];

    
    NSCalendar * cal = [NSCalendar currentCalendar];

    NSDateComponents * comp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    
    NSInteger  item = [comp weekday];
   // NSInteger day = [comp day];
    //NSInteger month = [comp month];
    
    //将美国星期几转为中国星期几的算法 O.o
    NSInteger weekDay = ( item + 6)%7 + (item % 1) * 7;
    //NSInteger
    
    NSArray * weekDayArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSMutableArray * dayArry = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 7 ; i ++) {
        NSDateComponents * addComp = [[NSDateComponents alloc]init];
        [addComp setDay:(i - weekDay)];
        NSDate * pastDate = [cal dateByAddingComponents:addComp toDate:now options:NSCalendarWrapComponents];
        NSDateComponents * dayComp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:pastDate];
        NSInteger pastDay = [dayComp month];
        NSInteger pastMonth = [dayComp day];
        
        NSString * dayStr ;
        NSString * monthStr;
        
        if (pastDay < 10) {
            dayStr = [NSString stringWithFormat:@"0%ld",pastDay];
        }else{
            dayStr = [NSString stringWithFormat:@"%ld",pastDay];
        }
        
        if (pastMonth < 10) {
            monthStr = [NSString stringWithFormat:@"0%ld",pastMonth];
        }else{
            monthStr = [NSString stringWithFormat:@"%ld",pastMonth];
        }
        
        NSString * dateStr = [NSString stringWithFormat:@"%@-%@",dayStr,monthStr];
        NSLog(@"%@",dateStr);
        [dayArry addObject:dateStr];
    }
    
    for (NSInteger i = 0 ; i < 7; i ++) {
        NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"WeekDayButton" owner:self options:nil];
        WeekDayButton * weekDayBtn = [nibArray objectAtIndex:0];
        weekDayBtn.frame = CGRectMake(0 + i * weekDayWidth, 0 , weekDayWidth, weekDayHeight-1);

        if (i + 1 == weekDay) {
            [weekDayBtn onItDay];
        }
        
        [weekDayBtn setWeekDayLabel:[weekDayArr objectAtIndex:i] DayLabel:[dayArry objectAtIndex:i]];
        
        [self.horizonView addSubview:weekDayBtn];
    }
}

@end
