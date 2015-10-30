//
//  SSDUTNewsCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSDUTNewsCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray * fileLinkArr;
- (void)setCellWithTitle:(NSString *)title Time:(NSString *)time ClickCount:(NSString *)clickCount FileLinks:(NSMutableArray *)fileLink;
@end
