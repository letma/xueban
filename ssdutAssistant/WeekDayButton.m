//
//  WeekDayButton.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/7.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "WeekDayButton.h"
@interface WeekDayButton()
@property (nonatomic) IBOutlet UILabel * weekDayLabel;
@property (nonatomic) IBOutlet UILabel * dayLabel;
@property (nonatomic) IBOutlet UIView * lineView;
@end

@implementation WeekDayButton

-(void)setWeekDayLabel:(NSString *)weekDay DayLabel:(NSString *)day
{
    self.weekDayLabel.text = weekDay;
    self.dayLabel.text = day;
}

-(void)onItDay
{
    [self clickedOn];
    self.dayLabel.textColor = UIColorFromRGB(0x00bad1);
    self.weekDayLabel.textColor = UIColorFromRGB(0x00bad1);
    self.lineView.backgroundColor = UIColorFromRGB(0x00bad1);
}

-(void)clickedOn
{
    [self.weekDayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17]];
    self.lineView.backgroundColor = UIColorFromRGB(0x808584);
}

-(void)clickedOut
{
    [self.weekDayLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17]];
    self.lineView.backgroundColor = UIColorFromRGB(0xffffff);
}
@end
