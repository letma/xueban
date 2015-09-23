//
//  DiscoveryTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/7.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "DiscoveryTableViewCell.h"

@interface DiscoveryTableViewCell()
@property(nonatomic,strong) IBOutlet UIImageView * headView;
@property(nonatomic,strong) IBOutlet UILabel * titleLabel;
@property(nonatomic,strong) IBOutlet UIView * lineView;
@end

@implementation DiscoveryTableViewCell

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
            self.headView.image = UIIMGName(@"discovery_icon_schoolmate");
            self.titleLabel.text = @"校园广场";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
        case 3:
            self.headView.image = UIIMGName(@"discovery_icon_mystudent");
            self.titleLabel.text = @"我的同学";
            break;
        case 4:
            self.headView.image = UIIMGName(@"discovery_icon_paison");
            self.titleLabel.text = @"找同乡";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
        case 6:
            self.headView.image = UIIMGName(@"discovery_icon_evaluate");
            self.titleLabel.text = @"一键教学评估";
            break;
        case 7:
            self.headView.image = UIIMGName(@"discovery_icon_GPA");
            self.titleLabel.text = @"绩点计算";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}

@end
