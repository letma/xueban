//
//  ERPCourseViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPCourseViewController.h"
#import "CourseListView.h"

@interface ERPCourseViewController ()

@end

@implementation ERPCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程表";
    
    NSArray * nibArray ;

    if (WINHEIGHT == 480) {
        nibArray = [[NSBundle mainBundle]loadNibNamed:@"CourseListView67" owner:self options:nil];
    }else{
        nibArray = [[NSBundle mainBundle]loadNibNamed:@"CourseListView56" owner:self options:nil];
    }
    
    CourseListView * courseView = [nibArray objectAtIndex:0];

    [courseView initCourseListView];
    courseView.frame = RECT(0, 64, WINWIDTH, WINHEIGHT-64);
    
    [self.view addSubview:courseView];


    NSDate * now = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString * timeStr = [dateFormatter stringFromDate:now];
    NSLog(@"= =date:%@",timeStr);
    
    NSCalendar * cal = [NSCalendar currentCalendar];
    //NSUInteger flag = NSDayCalendarUnit|NSWeekdayCalendarUnit|NSWeekCalendarUnit|NSWeekOfMonthCalendarUnit;
NSDateComponents * comp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitHour|NSCalendarUnitDay|NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekdayOrdinal|NSCalendarUnitWeekOfYear fromDate:now];

    NSInteger  day = [comp day];
    NSInteger  weekDay = [comp weekday];
    NSInteger hour = [comp hour];
    NSInteger weekOfMonth = [comp weekOfMonth];
    NSInteger weekDayOrdinal = [comp weekdayOrdinal];
    NSInteger weekOfYear = [comp weekOfYear];
    
    
    NSLog(@"day:%ld  hour: :%ld weekDay: :%ldweekOfMonth: :%ld weekDayOrdinal : :%ld weekOfYear::%ld ",(long)day,hour,weekDay,weekOfMonth,weekDayOrdinal,weekOfYear);
    
    //将美国星期转为中国星期的算法 O.o
    NSInteger item = ( weekDay + 6)%7 + (weekDay % 1) * 7;
        NSLog(@"hahahha %ld",item);
    //NSInteger

    
    //self.horizonView.frame = CGRectMake(0, 100, 320, 20);
   // self.view.backgroundColor =UIColorFromRGB(0xefefef);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
