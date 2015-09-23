//
//  ERPCourseViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPCourseViewController.h"
#import "CourseListView.h"

@interface ERPCourseViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (nonatomic) CourseListView * courseView ;
@property (nonatomic) NSMutableData * courseData;
@property (nonatomic) NSUserDefaults * userDefualts ;
@end

@implementation ERPCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"课程表";
    self.userDefualts = [NSUserDefaults standardUserDefaults];

    
    NSArray * nibArray ;

    if (WINHEIGHT == 480) {
        nibArray = [[NSBundle mainBundle]loadNibNamed:@"CourseListView67" owner:self options:nil];
    }else{
        nibArray = [[NSBundle mainBundle]loadNibNamed:@"CourseListView56" owner:self options:nil];
    }
    
    self.courseView = [nibArray objectAtIndex:0];

    [self.courseView initCourseListView];
    self.courseView.frame = RECT(0, 0, WINWIDTH, WINHEIGHT);
    
    if([self.userDefualts boolForKey:IF_CourseHave]){
        [self addCourseListWith:[self.userDefualts objectForKey:MyCourse_Key]];
    }else{
        [self ConnectDlut];
    }
    //[self addCourseList];
    
    
    
    [self.courseView insertLessonsWithCourse:@"小马哥ios大讲堂小马哥ios大讲堂小马哥ios大讲堂" Local:@"OurEDA实验室" ColorIndex:0 weekDay:0 lesson:0 number:4 ifCover:YES];
    
    [self.courseView insertLessonsWithCourse:@"工科数学离散数学" Local:@"教学楼C102" ColorIndex:1 weekDay:3 lesson:5 number:2 ifCover:NO];
    
    [self.courseView insertLessonsWithCourse:@"优衣库" Local:@"2舍519" ColorIndex:2 weekDay:4 lesson:3 number:2 ifCover:YES];
    
    [self.view addSubview:self.courseView];
    
    

}

#pragma mark - AddCourseList
-(void)addCourseListWith:(NSArray *)courseDic
{
    //NSDictionary * courseDic = [self.userDefualts objectForKey:MyCourse_Key];
}

#pragma mark - NSUrlConnection
- (void)ConnectDlut
{
    NSString * urlStr = [NSString stringWithFormat:@"%@curriculum",DLUT_IP];
    NSLog(@"*****%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",[self.userDefualts objectForKey:LoginToken_Str]);
    [request setValue:[self.userDefualts objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSURLConnection * connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        self.courseData = [NSMutableData new];
    }
    
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

#pragma mark - NSUrlConnectionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.courseData appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * courseDic = [NSJSONSerialization JSONObjectWithData:self.courseData options:NSJSONReadingMutableContainers error:nil];
    
//    NSLog(@"++++++++++++%@",courseDic);
    
    NSArray * courseArray = [courseDic objectForKey:@"msg"];

    NSArray * keyArray = @[@"Name",@"Teacher",@"Type",@"Classroom",@"Credit",@"Location",@"Lesson"];

    for (NSInteger i = 0 ; i < [courseArray count] ; i ++) {
        NSLog(@"///////////////////////////////");
        NSDictionary * dic = [courseArray objectAtIndex:i];

        for (NSInteger j = 0; j < [keyArray count]; j ++) {
            NSLog(@"%@",[dic objectForKey:[keyArray objectAtIndex:j]]);
        }
        
    }
}




@end
