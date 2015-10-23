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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatCellWithImage:(UIImage *)headImg Name:(NSString *)nameStr Department:(NSString *)departmentStr Sex:(BOOL)sex Single:(NSInteger)single
{
    [self.headImgView setImage:headImg];
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
