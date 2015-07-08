//
//  WeekDayButton.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/7.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "WeekDayButton.h"
@interface WeekDayButton()
{
    //日期和星期的字体大小
    CGFloat weekDayLabelSize;
    CGFloat dayLabelSize;
}
@property (nonatomic) IBOutlet UILabel * weekDayLabel;
@property (nonatomic) IBOutlet UILabel * dayLabel;
@property (nonatomic) IBOutlet UIView * lineView;

@end

@implementation WeekDayButton

-(void)setWeekDayLabel:(NSString *)weekDay DayLabel:(NSString *)day
{
    self.weekDayLabel.text = weekDay;
    self.dayLabel.text = day;
    weekDayLabelSize = 14.0;
    dayLabelSize = 11.0;
}

-(void)setWeekDayFont:(CGFloat)weekDaySize DayFont:(CGFloat)daySize
{
    weekDayLabelSize = weekDaySize;
    dayLabelSize = daySize;
    
    self.weekDayLabel.font = [UIFont systemFontOfSize:weekDayLabelSize];
    self.dayLabel.font = [UIFont systemFontOfSize:dayLabelSize];
}

-(void)onItDay
{
    [self clickedOnByTodayTag:0 WithButtonTag:0];
    self.dayLabel.textColor = UIColorFromRGB(0x00bad1);
    self.weekDayLabel.textColor = UIColorFromRGB(0x00bad1);
    
}

-(void)clickedOnByTodayTag:(NSInteger )todayTag WithButtonTag:(NSInteger)buttonTag;
{
    [self.weekDayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:weekDayLabelSize]];
    if (todayTag == buttonTag) {
        self.lineView.backgroundColor = UIColorFromRGB(0x00bad1);
    }else{
        self.lineView.backgroundColor = UIColorFromRGB(0x808584);
    }
    
}

-(void)clickedOut
{
    [self.weekDayLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:weekDayLabelSize]];
    self.lineView.backgroundColor = [UIColor clearColor];
}
@end
