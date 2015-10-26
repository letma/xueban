//
//  HeadTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/23.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "HeadTableViewCell.h"
@interface HeadTableViewCell()
@property (nonatomic,strong) IBOutlet UIImageView * headImgView;
@property (nonatomic,strong) IBOutlet UILabel * nameLbl;
@property (nonatomic,strong) IBOutlet UILabel * departmentLbl;
@property (nonatomic,strong) IBOutlet UIImageView * sexImgView;
@property (nonatomic,strong) IBOutlet UILabel * singleLbl;
@end

@implementation HeadTableViewCell
@synthesize cellName;
@synthesize cellMajor;
@synthesize cellStudentID;
@synthesize cellSex;
@synthesize cellSingle;
@synthesize cellHeadImg;
@synthesize cellAddress;
@synthesize cellMessageID;

- (void)awakeFromNib {
    self.headImgView.layer.cornerRadius = 35;
    // Initialization code
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headImgView.layer.cornerRadius = 10;
    self.headImgView.clipsToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatCellWithImage:(UIImage *)headImg Name:(NSString *)nameStr Department:(NSString *)departmentStr StudentID:(NSString *)studentIDStr Address:(NSString*)addressStr Sex:(BOOL)sex Single:(NSInteger)single MessageID:(NSInteger)messageID;
{
    
    cellName = nameStr;
    cellMajor = departmentStr;
    cellStudentID = studentIDStr;
    cellAddress = addressStr;
    cellSex = sex;
    cellSingle = single;
    cellHeadImg = headImg;
    cellMessageID = messageID;

    if (headImg) {
        [self.headImgView setImage:headImg];
    }else{
        [self.headImgView setImage:UIIMGName(@"logo_noimage")];
    }
    
    
    self.nameLbl.text = nameStr;
    self.departmentLbl.text = departmentStr;
    if (sex) {
        [self.sexImgView setImage:UIIMGName(@"discovery_icon_sex_boy")];

    }else{
        [self.sexImgView setImage:UIIMGName(@"discovery_icon_sex_girl")];

    }
    
    if (single == 0) {
        self.singleLbl.text = @"单身";
    }else{
        self.singleLbl.text = @"恋爱";
    }
}

@end
