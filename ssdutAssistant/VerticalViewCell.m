//
//  VerticalViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 8/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import "VerticalViewCell.h"
@interface VerticalViewCell()
@property(nonatomic,strong ) IBOutlet UILabel * timeLabel;
@property(nonatomic) IBOutlet UILabel * sectionLabel;
@end

@implementation VerticalViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSectionLabelFont:(CGFloat)sectionSize TimeLabelFont:(CGFloat)timeSize
{
    self.timeLabel.font = [UIFont systemFontOfSize:timeSize];
    self.sectionLabel.font = [UIFont systemFontOfSize:sectionSize];
}

- (void)initSectionViewWithIndex:(NSInteger)index
{
    NSArray * timeArr = @[
                          @"8:00",
                          @"8:50",
                          @"9:50",
                          @"10:40",
                          @"13:30",
                          @"14:20",
                          @"15:10",
                          @"16:00",
                          @"18:00",
                          @"18:50",
                          @"19:40",
                          @"20:30",];
    
    NSArray * sectionArr = @[
                             @"1",
                             @"2",
                             @"3",
                             @"4",
                             @"5",
                             @"6",
                             @"7",
                             @"8",
                             @"9",
                             @"10",
                             @"11",
                             @"12",];
    
    self.timeLabel.text = [timeArr objectAtIndex:index];
    self.sectionLabel.text = [sectionArr objectAtIndex:index];
    
}


@end
