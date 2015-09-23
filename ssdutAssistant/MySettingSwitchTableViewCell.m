//
//  MySettingSwitchTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MySettingSwitchTableViewCell.h"
@interface MySettingSwitchTableViewCell()
@property(nonatomic,strong) IBOutlet UILabel * titleLabel;
@property(nonatomic,strong) IBOutlet UISwitch * switchBtn;
@property(nonatomic,strong) IBOutlet UIView * lineView;
@end

@implementation MySettingSwitchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellType:(NSInteger)cellIndex
{
    switch (cellIndex) {
        case 1:
            self.titleLabel.text = @"仅在Wi-Fi下下载";
            break;
        case 2:
            self.titleLabel.text = @"新成绩提醒";
            break;
        case 3:
            self.titleLabel.text = @"图书到期提醒";
            break;
        case 4:
            self.titleLabel.text = @"图书自动续借";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}

@end
