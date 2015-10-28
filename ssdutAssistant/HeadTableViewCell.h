//
//  HeadTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/23.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString * cellName;
@property (nonatomic, strong) NSString * cellMajor;
@property (nonatomic, strong) NSString * cellStudentID;
@property (nonatomic, strong) NSString * cellAddress;
@property (nonatomic, strong) UIImage * cellHeadImg;
@property (nonatomic, assign) BOOL cellSex;
@property (nonatomic, assign) NSInteger cellSingle;
@property (nonatomic, assign) NSInteger cellMessageID;


//找同学找同乡用的cell
- (void)creatCellWithImage:(UIImage *)headImg Name:(NSString *)nameStr Department:(NSString *)departmentStr StudentID:(NSString *)studentIDStr Address:(NSString*)addressStr Sex:(BOOL)sex Single:(NSInteger)single MessageID:(NSInteger)messageID;
//私信列表用的cell
- (void)creatCellWithImage:(UIImage *)headImg Name:(NSString *)nameStr Content:(NSString *)contentStr StudentID:(NSString *)studentIDStr Time:(NSString *)timeStr MessageID:(NSInteger)messageID IfReturn:(BOOL)ifReturn;
@end
