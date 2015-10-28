//
//  ContentTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/27.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ContentTableViewCell.h"
@interface ContentTableViewCell()
@property (nonatomic,strong) IBOutlet UIView * backView;
@property (nonatomic,strong) IBOutlet UIImageView * headImgView;
@property (nonatomic,strong) IBOutlet UILabel * nameLbl;
@property (nonatomic,strong) IBOutlet UILabel * timeLbl;
@property (nonatomic,strong) IBOutlet UIImageView * sexImgView;
@property (nonatomic,strong) IBOutlet UILabel * contentLbl;
@property (nonatomic,strong) IBOutlet UILabel* viewCountLbl;
@property (nonatomic,strong) IBOutlet UILabel * replayCountLbl ;
@property (nonatomic ,strong) IBOutlet UILabel * likeNumLbl;
@property (nonatomic ,strong) IBOutlet UIImageView * isLikeImgView;

@end
@implementation ContentTableViewCell
@synthesize cellContent;
@synthesize cellHeadImg;
@synthesize cellIsLike;
@synthesize cellLikeNum;
@synthesize cellName;
@synthesize cellReplyCounts;
@synthesize cellSex;
@synthesize cellTime;
@synthesize cellViewCounts;
@synthesize cellMessageID;

- (void)awakeFromNib {
    // Initialization code
}

 -(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.headImgView.layer.cornerRadius = 20.0;
    self.headImgView.clipsToBounds = YES;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createCellWithHeadImage:(UIImage *)headImg Name:(NSString *)name Time:(NSString *)timeStr Content:(NSString *)contentStr MessageID:(NSString *)messageIDStr Sex:(BOOL)sex  ViewCount:(NSInteger) viewCount ReplyCount:(NSInteger)replayCount LikeNum:(NSInteger)likeNum IsLike:(BOOL)isLike
{

    self.nameLbl.text = name;
    self.timeLbl.text = timeStr;
    self.contentLbl.text = contentStr;
    self.viewCountLbl.text = [NSString stringWithFormat:@"%ld",viewCount];
    self.replayCountLbl.text = [NSString stringWithFormat:@"%ld",replayCount];
    self.likeNumLbl.text = [NSString stringWithFormat:@"%ld",likeNum];
    
    if (headImg) {
        self.headImgView.image = headImg;
    }else{
        self.headImgView.image = UIIMGName(@"logo_anonymous");
    }
    
    if (sex) {
        self.sexImgView.image = UIIMGName(@"discovery_icon_sex_boy");
    }else{
        self.sexImgView.image = UIIMGName(@"discovery_icon_sex_girl");
    }
    
    if (isLike) {
        self.isLikeImgView.image = UIIMGName(@"discovery_icon_love_pressed");
    }else{
        self.isLikeImgView.image = UIIMGName(@"discovery_icon_love_normal");
    }
    
    //赋值
    cellName = name;
    cellContent = contentStr;
    cellTime = timeStr;
    cellMessageID = messageIDStr;
    cellHeadImg = headImg;
    cellReplyCounts = replayCount;
    cellViewCounts = viewCount;
    cellLikeNum = likeNum;
    cellSex = sex;
    cellIsLike = isLike;
    
}
- (void)clickZan
{
    if (cellIsLike) {
        self.isLikeImgView.image = UIIMGName(@"discovery_icon_love_normal");
        cellIsLike = NO;
        cellLikeNum = cellLikeNum -1;
    }else{
        self.isLikeImgView.image = UIIMGName(@"discovery_icon_love_pressed");
        cellIsLike = YES;
        cellLikeNum = cellLikeNum +1;
        
    }
    self.likeNumLbl.text = [NSString stringWithFormat:@"%ld",cellLikeNum];

}
@end
