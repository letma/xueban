//
//  MySettingCustomTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MySettingCustomTableViewCell.h"
@interface MySettingCustomTableViewCell()
@property (nonatomic,strong)IBOutlet UILabel * titleLabel;

@end

@implementation MySettingCustomTableViewCell

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
        case 6:
            self.titleLabel.text = @"关于学伴";
            break;
        case 7:
            self.titleLabel.text = @"关于我们";
            break;
        case 9:
            self.titleLabel.text = @"切换账号";
            break;
            
        default:
            break;
    }
}
@end
