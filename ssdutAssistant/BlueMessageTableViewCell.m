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

@end
