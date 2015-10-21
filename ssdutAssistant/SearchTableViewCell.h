//
//  SearchTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/20.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
- (void)creatCellWithTitle:(NSString *)titleStr Publish:(NSString *)publishStr Num:(NSString *)numStr;

//已经考完的;
- (void)haveGone;
@end
