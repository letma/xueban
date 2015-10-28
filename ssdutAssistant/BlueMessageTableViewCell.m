//
//  BlueMessageTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/26.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "BlueMessageTableViewCell.h"
@interface BlueMessageTableViewCell()
@property (nonatomic,strong) IBOutlet UIImageView * headImgView;
@property (nonatomic,strong) IBOutlet UIView * backView;
@property (nonatomic,strong) IBOutlet UILabel * contentLbl;
@property (nonatomic,strong) IBOutlet UILabel * timeLbl;
@end
@implementation BlueMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headImgView.layer.cornerRadius = 17.0;
    self.backView.layer.cornerRadius = 5.0;
    self.headImgView.clipsToBounds = YES;
    self.backView.clipsToBounds = YES;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)creatCellWithImg:(UIImage *)img Content:(NSString *)content Time:(NSString *)time
{
    [self.headImgView setImage:img];
    self.contentLbl.text = content;
    self.timeLbl.text = time;
    [self.timeLbl setTextColor:UIColorFromRGB(0xa0a0a0)];
}

- (void)setError
{
    self.timeLbl.text = @"发送失败";
    [self.timeLbl setTextColor:[UIColor redColor]];
}
@end
