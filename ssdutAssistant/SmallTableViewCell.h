//
//  SmallTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallTableViewCell : UITableViewCell

/**
 *根据index.row设置cell的index
 *2,考试成绩
 *3,考场安排
 *5,大工新闻
 *6,学生周知
 *7,活动公告
 *设置cell height
 *4~5s  50  6~6plus 60
 */
-(void)setCellType:(NSInteger)cellIndex Height:(CGFloat)height;

//+(void)setCellHeight:(CGFloat);
@end
