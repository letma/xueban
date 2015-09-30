//
//  ERPCourseViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPCourseViewController.h"
#import "CourseListView.h"
#import "ChangeWeekView.h"
#import "ChangeWeekTableViewCell.h"

@interface ERPCourseViewController ()<NSURLConnectionDelegate,
                                                                NSURLConnectionDataDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,
                                                                    UITableViewDataSource,
                                                                    UITableViewDelegate>
@property (nonatomic) CourseListView * courseView ;
@property (nonatomic) NSMutableData * courseData;
@property (nonatomic) NSUserDefaults * userDefualts ;
@property (nonatomic) UIButton * titleBtn;
@property (nonatomic) UIImageView * arrowView;

@property (nonatomic) ChangeWeekView * changeWeekView;
@property (nonatomic) UIView * backGroundView;
@property (nonatomic,retain) UIView * clearView;
@end

@implementation ERPCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"第18周";
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
        
    }
    //[self ConnectDlut];

    [self.view addSubview:self.courseView];
    



 

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.arrowView.alpha = 1;
    if (!self.titleBtn) {
        self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleBtn.frame = CGRectMake(0, 0, 100, 44);
        self.titleBtn.center = CGPointMake(WINWIDTH/2.0, 22);
        [self.titleBtn addTarget:self action:@selector(changeWeek) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationController.navigationBar addSubview:self.titleBtn];
        
        // top 加箭头
        self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(WINWIDTH, 16, 12, 12)];
        self.arrowView.image = [UIImage imageNamed:@"erp_icon_arrowDown"];
        [self.navigationController.navigationBar addSubview:self.arrowView];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        self.arrowView.frame = CGRectMake(WINWIDTH/2.0 +40, 16, 12, 12);
        [UIView commitAnimations];
        
    }


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.arrowView.alpha = 0;
    [self.courseView adjustWeekDayBarAndSectionView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.titleBtn) {
        [self.titleBtn removeFromSuperview];
        [self.arrowView removeFromSuperview];
    }
    
}

- (void)changeWeek
{
    NSLog(@"hahah");
    self.arrowView.image = [UIImage imageNamed:@"erp_icon_arrowUp"];
    
    [self.clearView removeFromSuperview];
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT)];
    self.clearView.backgroundColor = [UIColor clearColor];
    [[[UIApplication sharedApplication] keyWindow]
         addSubview:self.clearView];
    
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT )];
    self.backGroundView.backgroundColor = [UIColor blackColor];
    self.backGroundView.alpha = 0.0;
    [self.clearView addSubview:self.backGroundView];
    
    
    //weekView
    self.changeWeekView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeWeekView" owner:self options:nil] objectAtIndex:0];
    [self.changeWeekView setCornerRadius];
    self.changeWeekView.frame =CGRectMake(WINWIDTH/4.0, 84, WINWIDTH/2.0, WINWIDTH/4.0*3.5);
    self.changeWeekView.alpha = 0;
    [self.changeWeekView.weekTableView registerNibWithClass:[ChangeWeekTableViewCell class]];
    self.changeWeekView.weekTableView.delegate = self;
    self.changeWeekView.weekTableView.dataSource = self;
    [self.clearView addSubview:self.changeWeekView];
        
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.backGroundView.alpha = 0.3;
    self.changeWeekView.alpha = 1;
    [UIView commitAnimations];


    
    
    

}
#pragma mark - AddCourseList
-(void)addCourseListWith:(NSArray *)courseArr
{
    NSLog(@"+++++%@",courseArr);
   
    NSMutableArray * realCourseList = [[NSMutableArray alloc]init];;
    for(NSInteger i = 0 ; i < [courseArr count] ; i ++)
    {
         //去除掉尔雅的数组
        if ([[[courseArr objectAtIndex:i] objectForKey:@"Lesson"] count] > 0 ) {
            //开始将一周多节课的课程按照每一节课分开
            for (NSInteger j = 0; j < [[[courseArr objectAtIndex:i] objectForKey:@"Lesson"] count]; j ++) {
                //NSMutableDictionary * mutDic =(NSMutableDictionary *)[courseArr objectAtIndex:i];
                NSMutableDictionary * mutDic = [[NSMutableDictionary alloc] initWithDictionary:[courseArr objectAtIndex:i]];
                [mutDic removeObjectForKey:@"Lesson"];
                [mutDic setObject:[[[courseArr objectAtIndex:i] objectForKey:@"Lesson"] objectAtIndex:j] forKey:@"Lesson"];
                [realCourseList addObject:mutDic];
            }
        }

    }
    
    //冒泡排序
    for (NSInteger i = 0 ;  i < ([realCourseList count] - 2) ; i ++) {
        for (NSInteger j = 0 ; j < ([realCourseList count] - 2 - i) ; j ++) {
            if ([[[realCourseList objectAtIndex:j] objectForKey:@"Lesson"] objectForKey:@"WeekDay"] > [[[realCourseList objectAtIndex:j + 1] objectForKey:@"Lesson"] objectForKey:@"WeekDay"]) {
                
                NSDictionary * tempDic = [[NSDictionary alloc]initWithDictionary:[realCourseList objectAtIndex:j]];
                [realCourseList replaceObjectAtIndex:j withObject:[realCourseList objectAtIndex:j + 1]];
                [realCourseList replaceObjectAtIndex:j + 1 withObject:tempDic];
                
            }else if ([[[realCourseList objectAtIndex:j] objectForKey:@"Lesson"] objectForKey:@"WeekDay"] ==[[[realCourseList objectAtIndex:j + 1] objectForKey:@"Lesson"] objectForKey:@"WeekDay"]) {
                
                if ([[[realCourseList objectAtIndex:j] objectForKey:@"Lesson"] objectForKey:@"Section"] > [[[realCourseList objectAtIndex:j + 1] objectForKey:@"Lesson"] objectForKey:@"Section"]) {
                    
                    NSDictionary * tempDic = [[NSDictionary alloc]initWithDictionary:[realCourseList objectAtIndex:j]];
                    [realCourseList replaceObjectAtIndex:j withObject:[realCourseList objectAtIndex:j + 1]];
                    [realCourseList replaceObjectAtIndex:j + 1 withObject:tempDic];
                }
            }
        }
    }
    
    //打印
    NSArray * keyArray = @[@"Name",@"Teacher",@"Type",@"Classroom",@"Credit",@"Location",@"Lesson"];
    
    for (NSInteger i = 0 ; i < [realCourseList count] ; i ++) {
        NSLog(@"///////////////////////////////");
        NSDictionary * dic = [realCourseList objectAtIndex:i];
        
        for (NSInteger j = 0; j < [keyArray count]; j ++) {
            NSLog(@"%@",[dic objectForKey:[keyArray objectAtIndex:j]]);
        }
        
    }
    [self.userDefualts setObject:realCourseList forKey:MyCourseSorted_Key];
    [self.userDefualts synchronize];
    
    [self.courseView loadCourseWithContent:realCourseList WithWeekIndex:4];
    
    

}


#pragma mark - NSTableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 18;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeWeekTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ChangeWeekTableViewCell" forIndexPath:indexPath];
    [cell setWeekWithIndex:indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray * keyArray = @[@"Name",@"Teacher",@"Type",@"Classroom",@"Credit",@"Location",@"Lesson"];
    
    for (NSInteger i = 0 ; i < [[self.userDefualts objectForKey:MyCourseSorted_Key] count] ; i ++) {
        NSLog(@"///////////////////////////////");
        NSDictionary * dic = [[self.userDefualts objectForKey:MyCourseSorted_Key] objectAtIndex:i];
        
        for (NSInteger j = 0; j < [keyArray count]; j ++) {
            NSLog(@"%@",[dic objectForKey:[keyArray objectAtIndex:j]]);
        }
        
    }
    
    if (indexPath.row + 1 != 4) {
        for (NSInteger i = 0; i < [self.courseView.backView.subviews count]; i ++) {
            NSLog(@"%@",[self.courseView.backView.subviews objectAtIndex:i]);
            [[self.courseView.backView.subviews objectAtIndex:i] removeFromSuperview];
            

            
        }
        [self.courseView initViews];
        [self.courseView loadCourseWithContent:[self.userDefualts objectForKey:MyCourseSorted_Key] WithWeekIndex:indexPath.row +1];
        self.title = [NSString stringWithFormat:@"第%ld周",indexPath.row + 1];
    }
    self.arrowView.image = [UIImage imageNamed:@"erp_icon_arrowDown"];
    [self.clearView removeFromSuperview];
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
