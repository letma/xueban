//
//  ReviewTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/28.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ReviewTableViewCell.h"
@interface ReviewTableViewCell()
@property (nonatomic,strong) IBOutlet UIImageView * headImgView;
@property (nonatomic,strong) IBOutlet UILabel * nameLbl;
@property (nonatomic,strong) IBOutlet UILabel * timeLbl;
@property (nonatomic,strong) IBOutlet UIImageView * sexImgView;
@property (nonatomic,strong) IBOutlet UILabel * contentLbl;
@end

@implementation ReviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headImgView.clipsToBounds = YES;
    self.headImgView.layer.cornerRadius = 20.0;
}

- (void)createCellWithHeadImage:(UIImage *)headImg Name:(NSString *)name Time:(NSString *)timeStr Content:(NSString *)contentStr Sex:(BOOL)sex
{
    self.headImgView.image = headImg;
    self.nameLbl.text = name;
    self.timeLbl.text = timeStr;
    self.contentLbl.text = contentStr;
    
    if (sex) {
        self.sexImgView.image = UIIMGName(@"discovery_icon_sex_boy");
    }else{
        self.sexImgView.image = UIIMGName(@"discovery_icon_sex_girl");
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
