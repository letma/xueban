//
//  CourseListView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/6.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//



#import "CourseListView.h"
#import "WeekDayButton.h"
#import "SectionPartView.h"
#import "LessonButton.h"
#import "LessonMesViewController.h"


@interface CourseListView()<UIScrollViewDelegate>
{
    //今天是星期几
    NSInteger indexOfWeekDay;
    //星期button的高度 -1 了！！！！！！！！！
    CGFloat weekDayHeight ;
    //星期button的原始宽度
    CGFloat weekDayWidth ;
    //上边栏的宽度
    CGFloat horzonViewWidth;
    
    //7个scrollView
    NSMutableArray * viewsArray;
    
    //colorArray
    NSArray * colorArray;
    
    /*******为下一界面存储信息*********/
//    //课程名
//    NSMutableArray * courseArray;
//    //教师姓名
//    NSMutableArray * teacherArray;
//    //学分信息
//    NSMutableArray * pointArray;
//    //周数信息
//    NSMutableArray * weekArray;
//    //节次信息
//    NSMutableArray * sectionArray;
//    //地点信息
//    NSMutableArray * localArray;
    
}
@property (nonatomic) IBOutlet UIView * horizonView;
@property (nonatomic) IBOutlet UIView * verticalView;
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
    
    [self setColorArray];
    
    [self insertWeekDayViews];
    
    [self initVerticalViews];
    
    [self initViews];
    
    self.horizonScrollView.delegate = self;
    self.horizonScrollView.decelerationRate = 0.1;
    

}

-(void)adjustWeekDayBarAndSectionView
{
    self.horizonScrollView.contentOffset = CGPointMake(0, 0);
}

-(void)setColorArray
{
    //12个
    colorArray = @[
                   @0xE675C4,
                   @0x03B2EE,
                   @0xFF8D41,
                   @0x91C605,
                   @0xF87D8A,
                   @0xBA8ADF,
                   @0xFAAB4B,
                   @0x03BFF3,
                   @0xB3CE1C,
                   @0xF16D7F,
                   @0xFFBB07,
                   @0x68DDAB,
                   @0x6ddab,
                   @0xf36861,
                   @0x53d37e,
                   @0x13ca9a];
}

-(void)insertLessonsWithCourse:(NSString *)course Local:(NSString *)local ColorIndex:(NSInteger)index weekDay:(NSInteger)weekDay lesson:(NSInteger)lesson number:(NSInteger)num ifCover:(BOOL)ifCover
{
    NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"LessonButton" owner:self options:nil];
    LessonButton * btn = [nibArray objectAtIndex:0];
    
    if ((weekDay + 1) != indexOfWeekDay) {
        btn.frame = CGRectMake(0 , (weekDayHeight+1) * lesson, weekDayWidth, (weekDayHeight + 1) * num);
    }else{
        btn.frame = CGRectMake(0 , (weekDayHeight+1) * lesson, weekDayWidth+WINWIDTH/64.0*7.0, (weekDayHeight + 1) * num);
    }
    NSString * localStr = [NSString stringWithFormat:@"@%@",local];
    [btn setCourse:course Local:localStr BackgroundColor:[[colorArray objectAtIndex:index] integerValue] IfCover:ifCover  CornerIndex:index];
    [btn addTarget:self action:@selector(toCourseMes:) forControlEvents:UIControlEventTouchUpInside];
    [((UIView *)[viewsArray objectAtIndex:weekDay]) addSubview:btn];
}

#pragma mark - Btn
-(void)toCourseMes:(LessonButton *)btn
{
    //NSLog(@"hahahahha");
}

-(void)initViews
{
    //出现当天后需增加一些宽度
    CGFloat addWidth = 0;
    
    viewsArray = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0 ; i < 7 ; i ++) {
        UIView * item = [[UIView alloc]init];
        item.tag = i;
        item.backgroundColor = UIColorFromRGB(0xeaeaea);
        [viewsArray addObject:item];
        
        item.frame = RECT(0 + i *weekDayWidth + addWidth, 0, weekDayWidth, (weekDayHeight +1)*12);
        if (i + 1 == indexOfWeekDay) {
            addWidth = WINWIDTH/64.0*7;
            item.frame = CGRectMake(0 + i * weekDayWidth, 0 , weekDayWidth + addWidth, (weekDayHeight +1)*12);
            
        }
        [self.horizonScrollView addSubview:item];
//        for (NSInteger j = 0; j < 12; j ++) {
//            UIImageView * lineView = [[UIImageView alloc]init];
//            l;
//        }
    }

}


//添加左边的sectionViews
-(void)initVerticalViews
{

    for (NSInteger i = 0; i < 12 ; i ++) {
        NSArray * nibArray = [[NSBundle mainBundle]loadNibNamed:@"SectionPartView" owner:self options:nil];
        SectionPartView * item = [nibArray objectAtIndex:0];
        [item initSectionViewWithIndex:i];
        item.frame = CGRectMake(0, 0 + i * (weekDayHeight + 1), WINWIDTH/64.0*7, weekDayHeight+1);
        [self.verticalView addSubview:item];
    }
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
    NSInteger weekDay = ( item + 6)%7 + ((item - 8) * (-1) / 7 )*7;

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
        
        /******Views*****/
        [self changeViewsWithIndex:currentBtn.tag - 1 X:currentbtn_x Y:currentbtn_y W:weekDayWidth + WINWIDTH/64.0*7 H:(weekDayHeight+1)*12];
        
        [self changeViewsWithIndex:self.lastWeekDayBtn.tag - 1 X:lastBtn_x + WINWIDTH/64.0*7 Y:lastBtn_y W:weekDayWidth  H:(weekDayHeight+1)*12];

        
        
        /*******夹在中间的控件********/
        for (NSInteger i = currentBtn.tag + 1 ; i < self.lastWeekDayBtn.tag; i ++) {
            /*****button*****/
            WeekDayButton * itemBtn = (WeekDayButton *)[self.horizonView viewWithTag:i];
            CGFloat changeBtn_x = itemBtn.frame.origin.x;
            CGFloat changeBtn_y = itemBtn.frame.origin.y;
            itemBtn.frame = RECT(changeBtn_x +  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, weekDayHeight);
            
            /******Views*****/
            
            [self changeViewsWithIndex:i - 1 X:changeBtn_x +  WINWIDTH/64.0*7 Y:changeBtn_y W:weekDayWidth  H:(weekDayHeight+1)*12];
            
        }
    }else{
        /*****button*****/
        currentBtn.frame = RECT(currentbtn_x - WINWIDTH/64.0*7, currentbtn_y, weekDayWidth + WINWIDTH/64.0*7, weekDayHeight);
        
        self.lastWeekDayBtn.frame = RECT(lastBtn_x , lastBtn_y, weekDayWidth, weekDayHeight);
        
        /******Views*****/
        
        [self changeViewsWithIndex:currentBtn.tag - 1 X:currentbtn_x - WINWIDTH/64.0*7 Y:currentbtn_y W:weekDayWidth + WINWIDTH/64.0*7 H:(weekDayHeight+1)*12];
        
        [self changeViewsWithIndex:self.lastWeekDayBtn.tag - 1 X:lastBtn_x Y:lastBtn_y W:weekDayWidth  H:(weekDayHeight+1)*12];

        
         /*******夹在中间的控件********/
        for (NSInteger i = self.lastWeekDayBtn.tag + 1 ; i < currentBtn.tag; i ++) {
            /*****button*****/
            WeekDayButton * itemBtn = (WeekDayButton *)[self.horizonView viewWithTag:i];
            CGFloat changeBtn_x = itemBtn.frame.origin.x;
            CGFloat changeBtn_y = itemBtn.frame.origin.y;
            itemBtn.frame = RECT(changeBtn_x -  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, weekDayHeight);
            /******Views*****/
            [self changeViewsWithIndex:i - 1 X:changeBtn_x - WINWIDTH/64.0*7 Y:changeBtn_y W:weekDayWidth  H:(weekDayHeight+1)*12];
//            ((UITableView *)[tableViewArray objectAtIndex:i - 1]).frame = RECT(changeBtn_x -  WINWIDTH/64.0*7, changeBtn_y, weekDayWidth, (weekDayHeight+1)*12);
        }
    }
    self.lastWeekDayBtn = currentBtn;
}

#pragma mark - changeViewsFrame
-(void)changeViewsWithIndex:(NSInteger)index X:(CGFloat)x Y:(CGFloat)y W:(CGFloat)w H:(CGFloat)h
{
    ((UIView *)[viewsArray objectAtIndex:index]).frame = CGRectMake(x, y, w, h);
    for (UIView * view in [((UIView *)[viewsArray objectAtIndex:index]) subviews]) {
        CGFloat view_x = view.frame.origin.x;
        CGFloat view_y = view.frame.origin.y;
        CGFloat view_h = view.frame.size.height;
        view.frame = CGRectMake(view_x, view_y, w, view_h);
    }
    
}



#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.horizonScrollView]) {
        self.verticalView.frame = RECT(0, weekDayHeight + 1 - scrollView.contentOffset.y, WINWIDTH/64.0*7.0, (weekDayHeight + 1) * 12);
        self.horizonView.frame = RECT(0 - scrollView.contentOffset.x + WINWIDTH/64.0*7.0, 0, WINWIDTH/64.0*77.0, weekDayHeight + 1);
    }
}
@end
