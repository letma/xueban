//
//  BlueMessageTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/26.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlueMessageTableViewCell : UITableViewCell
- (void)creatCellWithImg:(UIImage *)img Content:(NSString *)content Time:(NSString *)time;
- (void)setError;
@end
