//
//  MineTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/8.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MineTableViewCell.h"
@interface MineTableViewCell()
@property(nonatomic,strong) IBOutlet UIImageView * headView;
@property(nonatomic,strong) IBOutlet UILabel * titleLabel;
@property(nonatomic,strong) IBOutlet UIView * lineView;

@end

@implementation MineTableViewCell

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
        case 3:
            self.headView.image = UIIMGName(@"mine_icon_message");
            self.titleLabel.text = @"我的私信";
            break;
        case 4:
            self.headView.image = UIIMGName(@"mine_icon_board");
            self.titleLabel.text = @"留言板";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
        case 6:
            self.headView.image = UIIMGName(@"mine_icon_document");
            self.titleLabel.text = @"我的文件";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
        case 8:
            self.headView.image = UIIMGName(@"mine_icon_feedback");
            self.titleLabel.text = @"反馈";
            break;
        case 9:
            self.headView.image = UIIMGName(@"mine_icon_set");
            self.titleLabel.text = @"设置";
            self.lineView.backgroundColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}
@end
