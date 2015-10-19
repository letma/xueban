//
//  LibraryTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/17.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LibraryTableViewCell : UITableViewCell
/*
 *borrowStatus
 *0 无须续借
 *1 立即续借
 *2 续借成功
 *3 图书到期
 */
- (void)creatCellWithName:(NSString *)nameStr Location:(NSString *)locationStr StartTime:(NSString *)startTimeStr EndTime:(NSString *)endTimeStr NumStr:(NSString *)numStr BorrowStatus:(NSInteger)borrowStatus;
@end
