//
//  ChangeWeekTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/30.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ChangeWeekTableViewCell.h"
@interface ChangeWeekTableViewCell()
@property (nonatomic) IBOutlet UILabel * weekLabel;
@end

@implementation ChangeWeekTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeekWithIndex:(NSInteger)index
{
    self.layer.cornerRadius = 5;
    self.weekLabel.text = [NSString stringWithFormat:@"第%ld周",index];
}

@end
