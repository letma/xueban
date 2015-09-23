//
//  MyHeadTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/8.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyHeadTableViewCell : UITableViewCell
//设置头像
-(void)setMyHeadImage:(UIImage *)myHeadImage MyName:(NSString *)myName;

-(void)setWeek:(NSInteger)weekIndex WeekDay:(NSInteger)weekDayIndex;
@end
