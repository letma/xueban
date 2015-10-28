//
//  ContentTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/27.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentTableViewCell : UITableViewCell
@property (nonatomic,strong)IBOutlet UIButton * replyBtn;
@property (nonatomic,strong)IBOutlet UIButton * likeBtn;
@property (nonatomic,strong)UIImage * cellHeadImg;
@property (nonatomic,strong)NSString * cellName;
@property (nonatomic,strong)NSString * cellTime;
@property (nonatomic,strong)NSString * cellContent;
@property (nonatomic,strong)NSString * cellMessageID;
@property (nonatomic,assign)NSInteger cellViewCounts;
@property (nonatomic,assign)NSInteger cellReplyCounts;
@property (nonatomic,assign)NSInteger cellLikeNum;
@property (nonatomic,assign)BOOL cellIsLike;
@property (nonatomic,assign)BOOL cellSex;


- (void)createCellWithHeadImage:(UIImage *)headImg Name:(NSString *)name Time:(NSString *)timeStr Content:(NSString *)contentStr MessageID:(NSString *)messageIDStr Sex:(BOOL)sex  ViewCount:(NSInteger) viewCount ReplyCount:(NSInteger)replayCount LikeNum:(NSInteger)likeNum IsLike:(BOOL)isLike;
//点赞
- (void)clickZan;
@end
