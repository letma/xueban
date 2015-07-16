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
@property (nonatomic) CourseListView * courseView ;
@end

@implementation ERPCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"课程表";
    
    NSArray * nibArray ;

    if (WINHEIGHT == 480) {
        nibArray = [[NSBundle mainBundle]loadNibNamed:@"CourseListView67" owner:self options:nil];
    }else{
        nibArray = [[NSBundle mainBundle]loadNibNamed:@"CourseListView56" owner:self options:nil];
    }
    
    self.courseView = [nibArray objectAtIndex:0];

    [self.courseView initCourseListView];
    self.courseView.frame = RECT(0, 0, WINWIDTH, WINHEIGHT);
    
    [self.courseView insertLessonsWithCourse:@"小马哥ios大讲堂小马哥ios大讲堂小马哥ios大讲堂" Local:@"OurEDA实验室" ColorIndex:0 weekDay:0 lesson:0 number:4];
    
    [self.courseView insertLessonsWithCourse:@"工科数学离散数学" Local:@"教学楼C102" ColorIndex:1 weekDay:3 lesson:5 number:2];
    
    [self.courseView insertLessonsWithCourse:@"优衣库" Local:@"2舍519" ColorIndex:2 weekDay:4 lesson:3 number:2];
    
    [self.view addSubview:self.courseView];
    
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.courseView adjustWeekDayBarAndSectionView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    

    NSLog(@"---------------------");
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
