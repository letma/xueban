//
//  ERPExamTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/21.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPExamTableViewController.h"
#import "SearchTableViewCell.h"

@interface ERPExamTableViewController ()
{
    NSInteger weekDay;
    NSInteger week;
    NSInteger hour;
     //用之前的数 组一个序列数 方便排序
    CGFloat sortNum;
}
@property (nonatomic) NSMutableArray * examArray;
@property (nonatomic) NSUserDefaults * userDefaluts;
@property (nonatomic) UIRefreshControl * rC;
@end

@implementation ERPExamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaluts = [NSUserDefaults standardUserDefaults];
    
    [self.tableView registerNibWithClass:[NothingTableViewCell class]];
    [self.tableView registerNibWithClass:[SearchTableViewCell class]];
    
    /*************************计算时间与日期********************************/
    NSDate * now = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:now];
    NSInteger  item = [comp weekday];
    
    hour = [comp hour];
    
    //将美国星期几转为中国星期几的算法 O.o
    weekDay = ( item + 6)%7 + ((item - 8) * (-1) / 7 )*7;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * startDate = [dateFormatter dateFromString:@"2015-09-07 00:00:00"];
    NSTimeInterval  timeInterval = [now timeIntervalSinceDate:startDate]/(24*60*60*7);
    
    week = timeInterval + 1;
    
    sortNum = week * 10 + weekDay + hour / 100.0;
    NSLog(@"sortNum:%f",sortNum);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.examArray = [[NSMutableArray alloc] initWithArray:[self.userDefaluts objectForKey:MyExamMessage_Key]];
    
    if ([self.examArray count] == 0) {
        
    }
    //NSLog(@"= = %@",self.examArray);
    [self sortExamArray];
    NSLog(@"= = %@",self.examArray);

    
    self.rC = [[UIRefreshControl alloc] init];
    self.refreshControl = self.rC;
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    [self.rC addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 下拉刷新
- (void)loadData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@exam",DLUT_IP];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",[self.userDefaluts objectForKey:LoginToken_Str]);
    [request setValue:[self.userDefaluts objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * freshData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:freshData options:NSJSONReadingMutableContainers error:nil];
    
    if ([[dic objectForKey:@"status"] boolValue]) {
        
        if ([[dic objectForKey:@"msg"] count] != 0) {
            self.examArray = [dic objectForKey:@"msg"];
            [self.userDefaluts setObject:self.examArray forKey:MyExamMessage_Key];
            [self.userDefaluts synchronize];
            [self.tableView reloadData];
        }
    }
    
    [self.rC endRefreshing];

}

#pragma mark - 排序
- (void)sortExamArray
{
    //考过的
    NSMutableArray * beforeArr = [[NSMutableArray alloc] init];
    //还没考的
    NSMutableArray * afterArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self.examArray count]; i ++) {
        NSDictionary * dic = [self.examArray objectAtIndex:i];
        CGFloat tempNum = [self getSortNum:dic];
        
        if (tempNum < sortNum) {
            [beforeArr addObject:[self.examArray objectAtIndex:i]];
        } else {
            [afterArr addObject:[self.examArray objectAtIndex:i]];
        }
        
    }
    
    //分别冒泡排序
    NSLog(@"befor : %@    after:%@",beforeArr,afterArr);
    
    if ([beforeArr count] != 0) {
        for (NSInteger i = 0 ; i < [beforeArr count] - 1; i ++) {
            for (NSInteger j = 0; j < [beforeArr count] - i - 1; j ++) {
                CGFloat tempNum = [self getSortNum:[beforeArr objectAtIndex:j]];
                CGFloat tempNumNext = [self getSortNum:[beforeArr objectAtIndex:j + 1]];
                if (tempNum > tempNumNext) {
                    NSDictionary * temp = [beforeArr objectAtIndex:j];
                    [beforeArr replaceObjectAtIndex:j withObject:[beforeArr objectAtIndex:j + 1]];
                    [beforeArr replaceObjectAtIndex:j + 1 withObject:temp];
                }
            }
        }

    }
    
    if ([afterArr count] != 0) {
        for (NSInteger i = 0 ; i < [afterArr count] - 1; i ++) {
            for (NSInteger j = 0; j < [afterArr count] - i - 1; j ++) {
                CGFloat tempNum = [self getSortNum:[afterArr objectAtIndex:j]];
                CGFloat tempNumNext = [self getSortNum:[afterArr objectAtIndex:j + 1]];
                if (tempNum > tempNumNext) {
                    NSDictionary * temp = [afterArr objectAtIndex:j];
                    [afterArr replaceObjectAtIndex:j withObject:[afterArr objectAtIndex:j + 1]];
                    [afterArr replaceObjectAtIndex:j + 1 withObject:temp];
                }
            }
        }
    }

//    NSMutableDictionary * ddd = [[NSMutableDictionary alloc] initWithDictionary:[self.examArray objectAtIndex:2]];
//    [ddd setObject:@"9" forKey:@"ExamWeekNum"];
//    [afterArr addObject:ddd];
    
    
    [self.examArray removeAllObjects];
    [self.examArray addObjectsFromArray:afterArr];
    [self.examArray addObjectsFromArray:beforeArr];

    
}

//返回排序序列数
- (CGFloat)getSortNum:(NSDictionary *)dic;
{
    NSInteger tempWeek = [[dic objectForKey:@"ExamWeekNum"] integerValue]; ;
    NSInteger tempDay = [[dic objectForKey:@"ExamWeek"] integerValue];
    NSInteger tempHour = [[[dic objectForKey:@"ExamHourStart"] substringToIndex:3] integerValue];
    //用之前的数组一个序列数方便排序
    CGFloat tempNum = tempWeek * 10 + tempDay + tempHour / 100.0;
    NSLog(@"%f",tempNum);
    return tempNum;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.examArray count] == 0) {
        return 1;
    }else{
        return [self.examArray count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.examArray count] == 0) {
        
        NothingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NothingTableViewCell"];
        return cell;
        
    }else{
        NSDictionary * dic = [self.examArray objectAtIndex:indexPath.row];
        CGFloat tempNum = [self getSortNum:dic];
        NSString * nameStr = [dic objectForKey:@"ExamName"];
        NSString * location = [dic objectForKey:@"ExamLocation"];
        NSString * classRoom = [dic objectForKey:@"ExamClassroom"];
        NSString * weekStr = [dic objectForKey:@"ExamWeekNum"];
        NSString * startTime = [dic objectForKey:@"ExamHourStart"];
        NSString * endTime = [dic objectForKey: @"ExamHourEnd"];
        NSString * day ;
        switch ([[dic objectForKey:@"ExamWeek"] integerValue]) {
            case 1:
                day = @"一";
                break;
            case 2:
                day = @"二";
                break;
            case 3:
                day = @"三";
                break;
            case 4:
                day = @"四";
                break;
            case 5:
                day = @"五";
                break;
            case 6:
                day = @"六";
                break;
            case 7:
                day = @"七";
                break;
                
            default:
                break;
        }
        
        NSString * localStr = [NSString stringWithFormat:@"考试地点: %@ %@",location,classRoom];
        NSString * timeStr = [NSString stringWithFormat:@"考试时间: 第%@周 星期%@ %@-%@",weekStr,day,startTime,endTime];
        
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell" forIndexPath:indexPath];
        [cell creatCellWithTitle:nameStr Publish:localStr Num:timeStr];
        if (tempNum < sortNum) {
            [cell haveGone];
        }
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.examArray count] == 0) {
        return WINHEIGHT - 64;
    }else{
        return 120;
    }
}

@end
