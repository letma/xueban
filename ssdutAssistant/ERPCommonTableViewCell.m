//
//  ERPCommonTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/18.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPCommonTableViewCell.h"
@interface ERPCommonTableViewCell()
@property (nonatomic,strong) IBOutlet UIImageView * leftImgView;
@property (nonatomic,strong) IBOutlet UIImageView * rightImgView;
@property (nonatomic) IBOutlet UILabel * leftLabel;
@property (nonatomic) IBOutlet UILabel * rightLabel;

@end

@implementation ERPCommonTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellType:(NSInteger)cellIndex
{
    switch (cellIndex) {
        case 0:
            self.leftBtn.tag = 0;
            self.rightBtn.tag = 1;
            self.leftImgView.image = UIIMGName(@"erp_icon_ssdutNews");
            self.rightImgView.image = UIIMGName(@"erp_icon_notice");
            self.leftLabel.text = @"学生周知";
            self.rightLabel.text = @"活动公告";
            break;
        case 1:
            self.leftBtn.tag = 2;
            self.rightBtn.tag = 3;
            self.leftImgView.image = UIIMGName(@"erp_icon_exam");
            self.rightImgView.image = UIIMGName(@"erp_icon_score");
            self.leftLabel.text = @"考场安排";
            self.rightLabel.text = @"考试成绩";
            break;
        case 2:
            self.leftBtn.tag = 4;
            self.rightBtn.tag = 5;
            self.leftImgView.image = UIIMGName(@"erp_icon_DUTNews");
            self.rightImgView.image = UIIMGName(@"erp_icon_more");
            self.leftLabel.text = @"大工新闻";
            self.rightLabel.text = @"更多内容";
            break;
        default:
            break;
    }
}

@end
