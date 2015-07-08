//
//  CourseListView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/6.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//



#import "CourseListView.h"
#import "WeekDayButton.h"
#import "VerticalViewCell.h"
#import "EmptyCourseCell.h"
#import "CourseViewCell.h"
#import "UITableView+Register.h"

@interface CourseListView()<UITableViewDataSource,UITableViewDelegate>
{
    //今天是星期几
    NSInteger indexOfWeekDay;
    //星期button的高度 -1 了！！！！！！！！！
    CGFloat weekDayHeight ;
    //星期button的原始宽度
    CGFloat weekDayWidth ;
    //上边栏的宽度
    CGFloat horzonViewWidth;
    
    //七个tableView
    NSMutableArray * tableViewArray;
}
@property (nonatomic) IBOutlet UIView * horizonView;
@property (nonatomic) IBOutlet UITableView * verticalTableView;
@property (nonatomic) IBOutlet UIScrollView * horizonScrollView;
@property (nonatomic) IBOutlet UIView * backView;
//上一个被点击的button
@property (nonatomic) WeekDayButton * lastWeekDayBtn;

@end

@implementation CourseListView

// 7 : 17 : 10*4
-(void)initCourseListView
{
    //初始化星期button的高度与原始宽度 hieght -1 防止挡住line
    weekDayWidth = WINWIDTH/64.0*10;
    if (WINHEIGHT == 480) {
        weekDayHeight = (WINHEIGHT - 64)/9.0 - 1;
    }else{
        weekDayHeight = (WINHEIGHT - 64)/11.0 -1;
    }
    
    horzonViewWidth = self.horizonView.frame.size.width;
    
    [self insertWeekDayViews];
    
    [self initTableViews];
    [self registerNibCell];
    self.verticalTableView.userInteractionEnabled = NO;
    self.verticalTableView.delegate = self;
    self.verticalTableView.dataSource =self;
    
    self.horizonScrollView.delegate = self;
    self.horizonScrollView.decelerationRate = 0.1;

    
    [self insertTableViews];
    
}

-(void)initTableViews
{
    
    //初始化七个tableView的array
    tableViewArray = [[NSMutableArray alloc]init];
    for (NSInteger i = 0; i < 7; i ++) {
        UITableView * item = [[UITableView alloc]init];
        item.tag = i;
        item.delegate = self;
        item.dataSource = self;
        item.separatorStyle = UITableViewCellSeparatorStyleNone;
        item.userInteractionEnabled = NO;
        [tableViewArray addObject:item];
    }
    ((UITableView *)[tableViewArray objectAtIndex:0]).backgroundColor = [UIColor whiteColor];
    ((UITableView *)[tableViewArray objectAtIndex:1]).backgroundColor = [UIColor redColor];
    ((UITableView *)[tableViewArray objectAtIndex:2]).backgroundColor = [UIColor blueColor];
    ((UITableView *)[tableViewArray objectAtIndex:3]).backgroundColor = [UIColor yellowColor];
    ((UITableView *)[tableViewArray objectAtIndex:4]).backgroundColor = [UIColor purpleColor];
    ((UITableView *)[tableViewArray objectAtIndex:5]).backgroundColor = [UIColor greenColor];
    ((UITableView *)[tableViewArray objectAtIndex:6]).backgroundColor = [UIColor blackColor];
}


//添加上边的weekDayViews
- (void)insertWeekDayViews
{
/*************************计算时间与日期********************************/
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
        [addComp setDay:(i - indexOfWeekDay + 1)];
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
    
    /****************************开始添加button*****************************/
    CGFloat addWidth = 0;
    for (NSInteger i = 0 ; i < 7; i ++) {
        
        
        NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"WeekDayButton" owner:self options:nil];
        WeekDayButton * weekDayBtn = [nibArray objectAtIndex:0];

        //tag
        weekDayBtn.tag = i + 1;
        
        weekDayBtn.frame = CGRectMake(0 + i * weekDayWidth +addWidth, 0 , weekDayWidth, weekDayHeight);
        
        [weekDayBtn setWeekDayLabel:[weekDayArr objectAtIndex:i] DayLabel:[dayArry objectAtIndex:i]];
        
        if (i + 1 == indexOfWeekDay) {
            [weekDayBtn onItDay];
            addWidth = WINWIDTH/64.0*7;
            weekDayBtn.frame = CGRectMake(0 + i * weekDayWidth, 0 , weekDayWidth + addWidth, weekDayHeight);
            self.lastWeekDayBtn = weekDayBtn;
            
        }

        [weekDayBtn addTarget:self action:@selector(clickedWeekDayBtn:) forControlEvents:UIControlEventTouchUpInside];

        
        [self.horizonView addSubview:weekDayBtn];
    }
}

//添加7个tableView
-(void)insertTableViews
{
    CGFloat addWidth = 0;
    for (NSInteger i = 0; i < 7; i ++) {
        ((UITableView *)[tableViewArray objectAtIndex:i]).frame = RECT(0 + i *weekDayWidth + addWidth, 0, weekDayWidth, (weekDayHeight +1)*12);
        if (i + 1 == indexOfWeekDay) {
            addWidth = WINWIDTH/64.0*7;
            ((UITableView *)[tableViewArray objectAtIndex:i]).frame = CGRectMake(0 + i * weekDayWidth, 0 , weekDayWidth + addWidth, (weekDayHeight +1)*12);
            
        }
        [self.horizonScrollView addSubview:((UITableView *)[tableViewArray objectAtIndex:i])];
    }
}

#pragma mark - weekDayBtn的点击事件
-(void)clickedWeekDayBtn:(WeekDayButton *)currentBtn
{
    if ([currentBtn isEqual:self.lastWeekDayBtn]) {
        return;
    }

    CGFloat currentbtn_x = currentBtn.frame.origin.x;
    CGFloat currentbtn_y = currentBtn.frame.origin.y;
    CGFloat lastBtn_x = self.lastWeekDayBtn.frame.origin.x;
    CGFloat lastBtn_y = self.lastWeekDayBtn.frame.origin.y;
    
    [self.lastWeekDayBtn clickedOut];
    
    [currentBtn clickedOnByTodayTag:indexOfWeekDay WithButtonTag:currentBtn.tag];
    
    if (currentBtn.tag < self.lastWeekDayBtn.tag) {
        
        /*****button*****/
        currentBtn.frame = RECT(currentbtn_x, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, weekDayHeight);
        
        self.lastWeekDayBtn.frame = RECT(lastBtn_x + WINWIDTH/64.0*7, lastBtn_y, weekDayWidth, weekDayHeight);
        
        /******tableView*****/
        
        ((UITableView *)[tableViewArray objectAtIndex:currentBtn.tag - 1]).frame = RECT(currentbtn_x, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, (weekDayHeight+1)*12);
        
        ((UITableView *)[tableViewArray objectAtIndex:self.lastWeekDayBtn.tag - 1]).frame = RECT(lastBtn_x + WINWIDTH/64.0*7, lastBtn_y, weekDayWidth, (weekDayHeight+1)*12);
        
        
        /*******夹在中间的控件********/
        for (NSInteger i = currentBtn.tag + 1 ; i < self.lastWeekDayBtn.tag; i ++) {
            /*****button*****/
            WeekDayButton * itemBtn = (WeekDayButton *)[self.horizonView viewWithTag:i];
            CGFloat changeBtn_x = itemBtn.frame.origin.x;
            CGFloat changeBtn_y = itemBtn.frame.origin.y;
            itemBtn.frame = RECT(changeBtn_x +  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, weekDayHeight);
            /******tableView*****/
            ((UITableView *)[tableViewArray objectAtIndex:i - 1]).frame = RECT(changeBtn_x +  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, (weekDayHeight+1)*12);
            
        }
    }else{
        /*****button*****/
        currentBtn.frame = RECT(currentbtn_x - WINWIDTH/64.0*7, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, weekDayHeight);
        
        self.lastWeekDayBtn.frame = RECT(lastBtn_x , lastBtn_y, weekDayWidth, weekDayHeight);
        
        /******tableView*****/
        
        ((UITableView *)[tableViewArray objectAtIndex:currentBtn.tag - 1]).frame = RECT(currentbtn_x - WINWIDTH/64.0*7, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, (weekDayHeight+1)*12);
        
        ((UITableView *)[tableViewArray objectAtIndex:self.lastWeekDayBtn.tag - 1]).frame = RECT(lastBtn_x , lastBtn_y, weekDayWidth, (weekDayHeight+1)*12);
        
         /*******夹在中间的控件********/
        for (NSInteger i = self.lastWeekDayBtn.tag + 1 ; i < currentBtn.tag; i ++) {
            /*****button*****/
            WeekDayButton * itemBtn = (WeekDayButton *)[self.horizonView viewWithTag:i];
            CGFloat changeBtn_x = itemBtn.frame.origin.x;
            CGFloat changeBtn_y = itemBtn.frame.origin.y;
            itemBtn.frame = RECT(changeBtn_x -  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, weekDayHeight);
            /******tableView*****/
            ((UITableView *)[tableViewArray objectAtIndex:i - 1]).frame = RECT(changeBtn_x -  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, (weekDayHeight+1)*12);
        }
    }
    self.lastWeekDayBtn = currentBtn;
}

#pragma mark - registerNibCell
-(void)registerNibCell
{
    [self.verticalTableView registerNibWithClass:[VerticalViewCell class]];
    for (NSInteger i = 0; i < 7; i ++) {
        [(UITableView *)[tableViewArray objectAtIndex:i] registerNibWithClass:[EmptyCourseCell class]];
        [(UITableView *)[tableViewArray objectAtIndex:i] registerNibWithClass:[CourseViewCell class]];
    }


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
        switch (tableView.tag) {
            case 0:
                return 9;
                break;
            case 1:
                return 12;
                break;
            case 2:
                return 12;
                break;
            case 3:
                return 12;
                break;
            case 4:
                return 12;
                break;
            case 5:
                return 12;
                break;
            case 6:
                return 12;
                break;
                
            default:
                return 0;
                break;
        }
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

        switch (tableView.tag) {
            case 0:
            {
                if (indexPath.row == 0) {
                    CourseViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CourseViewCell" forIndexPath:indexPath];
                    [cell setCourse:@"小马哥ios大讲堂小马哥ios大讲堂小马哥ios大讲堂" Local:@"@OurEDA实验室" BackgroundColor:0x36A1FA];
                    return cell;
                }else{
                    EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                    return cell;
                }

                break;
            }
            case 1:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
            case 2:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
            case 3:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
            case 4:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
            case 5:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
            case 6:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
                
            default:
            {
                EmptyCourseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCourseCell" forIndexPath:indexPath];
                return cell;
                break;
            }
        }


        
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.verticalTableView]) {
        return weekDayHeight+1;
    }else{
        switch (tableView.tag) {
            case 0:
            {
                if (indexPath.row == 0) {
                    return (weekDayHeight+1)*4.0;
                } else {
                    return weekDayHeight+1;
                }
                
                break;
            }
            case 1:
                return weekDayHeight+1;
                break;
            case 2:
                return weekDayHeight+1;
                break;
            case 3:
                return weekDayHeight+1;
                break;
            case 4:
                return weekDayHeight+1;
                break;
            case 5:
                return weekDayHeight+1;
                break;
            case 6:
                return weekDayHeight+1;
                break;
                
            default:
                return weekDayHeight+1;
                break;
        }
    }

}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.horizonScrollView]) {
        self.verticalTableView.contentOffset = CGPointMake(0, 0+scrollView.contentOffset.y);
        self.horizonView.frame = RECT(0 - scrollView.contentOffset.x + WINWIDTH/64.0*7.0, 0, WINWIDTH/64.0*77.0, weekDayHeight + 1);
    }
}
@end
