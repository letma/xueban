//
//  LessonMesViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/16.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "LessonMesViewController.h"
#import "LessonCardView.h"

@interface LessonMesViewController ()
{
    NSInteger weekNum;
}
@property (nonatomic) NSUserDefaults * userDefualts;
@end

@implementation LessonMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userDefualts = [NSUserDefaults standardUserDefaults];
    
    weekNum = [[self.userDefualts objectForKey:TempNowWeek] integerValue];
    NSInteger colorValue = [[self.userDefualts objectForKey:TempCourseColor] integerValue];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, 64)];
    topView.backgroundColor = UIColorFromRGB(colorValue);
    [self.view addSubview:topView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:UIIMGName(@"erp_course_icon_cancelhite") forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(20, 30,20, 20);
    [cancelBtn addTarget:self action:@selector(backToCourseList) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    UILabel * courseLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    courseLbl.text = @"课程详情";
    courseLbl.textColor = [UIColor whiteColor];
    courseLbl.font = [UIFont fontWithName:@"Optima-Bold" size:20.0];
    courseLbl.textAlignment = NSTextAlignmentCenter;
    courseLbl.center = CGPointMake(WINWIDTH/2.0, cancelBtn.center.y);
    [topView addSubview:courseLbl];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, WINWIDTH, WINHEIGHT - 64)];
    scrollView.backgroundColor = UIColorFromRGB(0xefefef);
    [self.view addSubview:scrollView];
    
    //添加课程
    NSArray * courseArr = [self.userDefualts objectForKey:MyCourseSorted_Key];
    NSInteger courseID = [[self.userDefualts objectForKey:TempCourseID] integerValue];
    NSInteger i = 0;
    BOOL flag;
    do {
    
        flag = NO;
        
        NSDictionary * courseDic = [[NSDictionary alloc] initWithDictionary:[courseArr objectAtIndex:courseID]];
        
        if (weekNum <= 9) {
            courseID ++;
        }else{
            courseID --;
        }

        
        NSLog(@"%@",courseDic);
        
        
        NSString * credit = [courseDic objectForKey:@"Credit"];
        NSString * location = [courseDic objectForKey:@"Location"];
        NSString * name = [courseDic objectForKey:@"Name"];
        NSString * teacher = [courseDic objectForKey:@"Teacher"];
        NSString * type = [courseDic objectForKey:@"Type"];
        
        NSDictionary * lessonDic = [[NSDictionary alloc] initWithDictionary:[courseDic objectForKey:@"Lesson"]];
        NSString * startWeek = [lessonDic objectForKey:@"StartWeek"];
        NSString * endWeek = [lessonDic objectForKey:@"EndWeek"];
        NSString * duration = [lessonDic objectForKey:@"Duration"];
        NSString * section = [lessonDic objectForKey:@"Section"];
        NSString * weekDay = [lessonDic objectForKey:@"WeekDay"];
        
        NSString * classroom = [lessonDic objectForKey:@"Classroom"];
        
        NSString * creditStr = [NSString stringWithFormat:@"%@ %@学分",type,credit];
        NSString * weekStr = [NSString stringWithFormat:@"%@-%@周",startWeek,endWeek];
        
        
        
        NSString * nextSection = [NSString stringWithFormat:@"%ld",([section integerValue] + [duration integerValue] - 1)];
        switch ([weekDay integerValue]) {
            case 1:
                weekDay = @"一";
                break;
            case 2:
                weekDay = @"二";
                break;
            case 3:
                weekDay = @"三";
                break;
            case 4:
                weekDay = @"四";
                break;
            case 5:
                weekDay = @"五";
                break;
            case 6:
                weekDay = @"六";
                break;
            case 7:
                weekDay = @"日";
                break;
                
            default:
                break;
        }
        NSString * dayStr = [NSString stringWithFormat:@"星期%@ %@-%@节",weekDay,section,nextSection];
        
        NSString * classroomStr = [NSString stringWithFormat:@"%@ %@",location,classroom];
        
        NSArray * nibArr = [[NSBundle mainBundle] loadNibNamed:@"LessonCardView" owner:self options:nil];
        LessonCardView * lessonCardView = [nibArr objectAtIndex:0];
        
        if (weekNum < [startWeek integerValue] || weekNum > [endWeek integerValue]) {
            colorValue = 0x979D9C;
        }
        [lessonCardView setCardWithLesson:name Teacher:teacher Credit:creditStr Week:weekStr Day:dayStr Classroom:classroomStr Color:colorValue];
        lessonCardView.frame = CGRectMake(15, 15 + i * 265 , WINWIDTH - 30 , 250);
        [scrollView addSubview:lessonCardView];
        
        i ++;
        
        lessonCardView.layer.shadowColor = UIColorFromRGB(0xaaaaaa).CGColor;
        lessonCardView.layer.shadowOffset = CGSizeMake(6, 6);
        lessonCardView.layer.shadowOpacity = 0.8;
        lessonCardView.layer.shadowRadius = 5;
        
        if(![self.userDefualts boolForKey:TempIFCover] || courseID == [courseArr count])
        {
            break;
        }
        
        NSDictionary * nextCourseDic = [[NSDictionary alloc] initWithDictionary:[courseArr objectAtIndex:courseID]];
        NSString * nextLessonSection = [[nextCourseDic objectForKey:@"Lesson"] objectForKey:@"Section"];
        
        if ([section isEqual:nextLessonSection]) {
            flag = YES;
        }
        
    } while (flag);
    
    NSInteger length = 15 + 265 * i +15;
    scrollView.contentSize = CGSizeMake(WINWIDTH, length);
    scrollView.showsVerticalScrollIndicator = NO;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backToCourseList
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
