//
//  SSDUTNewsCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SSDUTNewsCell.h"
@interface SSDUTNewsCell()
@property (nonatomic) IBOutlet UILabel * titleLbl;
@property (nonatomic) IBOutlet UILabel * timeLbl;
@property (nonatomic) IBOutlet UILabel * clickNumLbl;

@end
@implementation SSDUTNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithTitle:(NSString *)title Time:(NSString *)time ClickCount:(NSString *)clickCount
{
    self.titleLbl.text = title;
    self.timeLbl.text = time;
    self.clickNumLbl.text = [NSString stringWithFormat:@"浏览量:%@",clickCount];
}
@end
