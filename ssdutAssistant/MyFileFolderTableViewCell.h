//
//  MyFileFolderTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFileFolderTableViewCell : UITableViewCell
@property (nonatomic,strong)NSString * fileName;
@property (nonatomic,strong)NSString * formate;
- (void)setFolderTitleName:(NSString *)titleName;
@end
