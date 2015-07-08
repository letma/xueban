//
//  CourseListView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/6.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//



#import "CourseListView.h"
//#import "SectionView.h"
#import "WeekDayButton.h"
#import "VerticalViewCell.h"
#import "UITableView+Register.h"

@interface CourseListView()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger indexOfWeekDay;
}
@property (nonatomic) IBOutlet UIView * horizonView;
@property (nonatomic) IBOutlet UITableView * verticalTableView;
@property (nonatomic) IBOutlet UIScrollView * horizonScrollView;
@property (nonatomic) IBOutlet UIScrollView * verticalScrollView;
@property (nonatomic) WeekDayButton * lastWeekDayBtn;
@end

@implementation CourseListView

// 7 : 17 : 10*4
-(void)initCourseListView
{

    
    [self insertWeekDayViews];
    [self registerNibCell];

    self.verticalTableView.userInteractionEnabled = NO;
    self.verticalTableView.delegate = self;
    self.verticalTableView.dataSource =self;
    
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

    
    //将美国星期几转为中国星期几的算法 O.o
    NSInteger weekDay = ( item + 6)%7 + (item % 1) * 7;
    indexOfWeekDay = weekDay;
    
    NSArray * weekDayArr = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    NSMutableArray * dayArry = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 7 ; i ++) {
        NSDateComponents * addComp = [[NSDateComponents alloc]init];
        [addComp setDay:(i - weekDay + 1)];
        NSDate * pastDate = [cal dateByAddingComponents:addComp toDate:now options:NSCalendarWrapComponents];
        NSDateComponents * dayComp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:pastDate];
        NSInteger pastDay = [dayComp month];
        NSInteger pastMonth = [dayComp day];
        
        NSString * dayStr ;
        NSString * monthStr;
        
        if (pastDay < 10) {
            dayStr = [NSString stringWithFormat:@"0%ld",pastDay ];
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
    CGFloat addWidth = 0;
    for (NSInteger i = 0 ; i < 7; i ++) {
        
        
        NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"WeekDayButton" owner:self options:nil];
        WeekDayButton * weekDayBtn = [nibArray objectAtIndex:0];

        //tag
        weekDayBtn.tag = i + 1;
        
        weekDayBtn.frame = CGRectMake(0 + i * weekDayWidth +addWidth, 0 , weekDayWidth, weekDayHeight-1);
        
        if (i + 1 == weekDay) {
            [weekDayBtn onItDay];
            addWidth = WINWIDTH/64.0*7;
            weekDayBtn.frame = CGRectMake(0 + i * weekDayWidth, 0 , weekDayWidth + addWidth, weekDayHeight-1);
            self.lastWeekDayBtn = weekDayBtn;
            
        }

        [weekDayBtn addTarget:self action:@selector(clickedWeekDayBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [weekDayBtn setWeekDayLabel:[weekDayArr objectAtIndex:i] DayLabel:[dayArry objectAtIndex:i]];
        
        [self.horizonView addSubview:weekDayBtn];
    }
}

#pragma mark - weekDayBtn的点击事件
-(void)clickedWeekDayBtn:(WeekDayButton *)currentBtn
{
    CGFloat weekDayHeight ;
    CGFloat weekDayWidth = WINWIDTH/64.0*10;
    if (WINHEIGHT == 480) {
        weekDayHeight = (WINHEIGHT - 64)/9.0 - 1;
    }else{
        weekDayHeight = (WINHEIGHT - 64)/11.0 -1;
    }
    CGFloat currentbtn_x = currentBtn.frame.origin.x;
    CGFloat currentbtn_y = currentBtn.frame.origin.y;
    CGFloat lastBtn_x = self.lastWeekDayBtn.frame.origin.x;
    CGFloat lastBtn_y = self.lastWeekDayBtn.frame.origin.y;
    
    [self.lastWeekDayBtn clickedOut];
    [currentBtn clickedOnByTodayTag:indexOfWeekDay WithButtonTag:currentBtn.tag];
    if (currentBtn.tag < self.lastWeekDayBtn.tag) {

        currentBtn.frame = RECT(currentbtn_x, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, weekDayHeight);
        self.lastWeekDayBtn.frame = RECT(lastBtn_x + WINWIDTH/64.0*7, lastBtn_y, weekDayWidth, weekDayHeight);
        for (NSInteger i = currentBtn.tag + 1 ; i < self.lastWeekDayBtn.tag; i ++) {
            WeekDayButton * itemBtn = (WeekDayButton *)[self.horizonView viewWithTag:i];
            CGFloat changeBtn_x = itemBtn.frame.origin.x;
            CGFloat changeBtn_y = itemBtn.frame.origin.y;
            itemBtn.frame = RECT(changeBtn_x +  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, weekDayHeight);
        }
    }else{
        currentBtn.frame = RECT(currentbtn_x - WINWIDTH/64.0*7, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, weekDayHeight);
        self.lastWeekDayBtn.frame = RECT(lastBtn_x , lastBtn_y, weekDayWidth, weekDayHeight);
        for (NSInteger i = self.lastWeekDayBtn.tag + 1 ; i < currentBtn.tag; i ++) {
            WeekDayButton * itemBtn = (WeekDayButton *)[self.horizonView viewWithTag:i];
            CGFloat changeBtn_x = itemBtn.frame.origin.x;
            CGFloat changeBtn_y = itemBtn.frame.origin.y;
            itemBtn.frame = RECT(changeBtn_x -  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, weekDayHeight);
        }
    }
    self.lastWeekDayBtn = currentBtn;
}

#pragma mark - registerNibCell
-(void)registerNibCell
{
    [self.verticalTableView registerNibWithClass:[VerticalViewCell class]];

}
#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.verticalTableView]) {
        return 12;
    }else{
        return  0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.verticalTableView]) {
        //添加左边栏的课节views
        VerticalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VerticalViewCell"];
        [cell initSectionViewWithIndex:indexPath.row];
        return  cell;
    }else{
        UITableViewCell * cell;
        return  cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.verticalTableView]) {
        CGFloat weekDayHeight ;
        if (WINHEIGHT == 480) {
            weekDayHeight = (WINHEIGHT - 64)/9.0;
        }else{
            weekDayHeight = (WINHEIGHT - 64)/11.0;
        }
        return weekDayHeight;
    }else{
        return  10;
    }

}
@end
