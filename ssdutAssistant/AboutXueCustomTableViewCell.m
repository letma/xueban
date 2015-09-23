//
//  AboutXueCustomTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/11.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AboutXueCustomTableViewCell.h"
@interface AboutXueCustomTableViewCell()
@property(nonatomic,strong)IBOutlet UILabel * titleLabel;
@property(nonatomic,strong)IBOutlet UIView * lineView;
@end

@implementation AboutXueCustomTableViewCell

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
            self.titleLabel.text = @"用户协议";
            break;
        case 2:
            self.titleLabel.text = @"去评分";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}
@end
