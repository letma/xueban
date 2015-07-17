//
//  SmallTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SmallTableViewCell.h"

@interface SmallTableViewCell()

@property(nonatomic,strong) IBOutlet UIImageView * iconImgView;
@property(nonatomic,strong) IBOutlet UILabel * titleLabel;

@end

@implementation SmallTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCellType:(NSInteger)cellIndex Height:(CGFloat)height;
{
    switch (cellIndex) {
        case 2:
            _iconImgView.image = UIIMGName(@"erp_icon_score");
            _titleLabel.text = @"考试成绩";
            [self setLineType:0 Height:height];
            break;
        case 3:
            _iconImgView.image = UIIMGName(@"erp_icon_exam");
            _titleLabel.text = @"考试安排";
            [self setLineType:1 Height:height];
            break;
        case 5:
            _iconImgView.image = UIIMGName(@"erp_icon_DUTNews");
            _titleLabel.text = @"大工新闻";
            [self setLineType:0 Height:height];
            break;
        case 6:
            _iconImgView.image = UIIMGName(@"erp_icon_ssdutNews");
            _titleLabel.text = @"学生周知";
            [self setLineType:2 Height:height];
            break;
        case 7:
            _iconImgView.image = UIIMGName(@"erp_icon_notice");
            _titleLabel.text = @"活动公告";
            [self setLineType:1 Height:height];
            break;
            
        default:
            break;
    }
}

/*
*设置line的index
*0,上端长
*1,上端短＋下端长
*2,上端短
*/
-(void)setLineType:(NSInteger)index Height:(CGFloat)height;
{
    UIView * longLineUp = [[UIView alloc]initWithFrame:RECT(0, 0, WINWIDTH, 1)];
    longLineUp.backgroundColor = UIColorFromRGB(0xefefef);
    UIView * longLineDown = [[UIView alloc]initWithFrame:RECT(0, height-1, WINWIDTH, 1)];
    longLineDown.backgroundColor = UIColorFromRGB(0xefefef);
    UIView * shortLine = [[UIView alloc]initWithFrame:RECT(20, 0, WINWIDTH-40, 1)];
    shortLine.backgroundColor = UIColorFromRGB(0xefefef);
    
    switch (index) {
        case 0:
            [self addSubview:longLineUp];
            break;
        case 1:
            [self addSubview:shortLine];
            [self addSubview:longLineDown];
            break;
        case 2:
            [self addSubview:shortLine];
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
