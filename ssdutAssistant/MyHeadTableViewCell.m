//
//  MyHeadTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/8.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyHeadTableViewCell.h"
@interface MyHeadTableViewCell()
@property (nonatomic , strong) IBOutlet UIImageView * headImageView;
@property(nonatomic ,strong) IBOutlet UILabel * myNameLabel;
@property (nonatomic,strong) IBOutlet UILabel * weekLabel;
@end

@implementation MyHeadTableViewCell

- (void)awakeFromNib {
    self.headImageView.layer.cornerRadius = 5;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMyHeadImage:(UIImage *)myHeadImage MyName:(NSString *)myName
{
    if (myName) {
        self.headImageView.image = myHeadImage;
        self.myNameLabel.text = myName;
    }
}

-(void)setWeek:(NSInteger)weekIndex WeekDay:(NSInteger)weekDayIndex
{
    NSString * weekDayStr;
    switch (weekDayIndex) {
        case 1:
            weekDayStr = @"一";
            break;
        case 2:
            weekDayStr = @"二";
            break;
        case 3:
            weekDayStr = @"三";
            break;
        case 4:
            weekDayStr = @"四";
            break;
        case 5:
            weekDayStr = @"五";
            break;
        case 6:
            weekDayStr = @"六";
            break;
        case 7:
            weekDayStr = @"日";
            break;
            
        default:
            break;
    }
    self.weekLabel.text = [NSString stringWithFormat:@"第%ld周 星期%@",weekIndex,weekDayStr];

}
@end
