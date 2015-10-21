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
    NSInteger minute;
}
@property (nonatomic) NSMutableArray * examArray;
@property (nonatomic) NSUserDefaults * userDefaluts;

@end

@implementation ERPExamTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaluts = [NSUserDefaults standardUserDefaults];
    
    /*************************计算时间与日期********************************/
    NSDate * now = [NSDate date];
    NSCalendar * cal = [NSCalendar currentCalendar];
    NSDateComponents * comp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:now];
    NSInteger  item = [comp weekday];
    
    hour = [comp hour];
    minute = [comp minute];
    
    //将美国星期几转为中国星期几的算法 O.o
    weekDay = ( item + 6)%7 + ((item - 8) * (-1) / 7 )*7;
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * startDate = [dateFormatter dateFromString:@"2015-09-07 00:00:00"];
    NSTimeInterval  timeInterval = [now timeIntervalSinceDate:startDate]/(24*60*60*7);
    
    week = timeInterval + 1;
    

    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView.backgroundColor = UIColorFromRGB(0xefefef);
    self.examArray = [[NSMutableArray alloc] initWithArray:[self.userDefaluts objectForKey:MyExamMessage_Key]];
    [self sortExamArray];
    
    [self.tableView registerNibWithClass:[NothingTableViewCell class]];
    [self.tableView registerNibWithClass:[SearchTableViewCell class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 排序
- (void)sortExamArray
{
    //考过的
    NSMutableArray * beforeArr = [[NSMutableArray alloc] init];
    //还没考的
    NSMutableArray * afterArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < [self.examArray count]; i ++) {
        NSInteger tempWeek;
        NSInteger tempDay;
        NSInteger tempHour;
    }
    
    
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
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell" forIndexPath:indexPath];
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
