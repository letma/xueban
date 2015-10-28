//
//  ReviewTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/28.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewTableViewCell : UITableViewCell
- (void)createCellWithHeadImage:(UIImage *)headImg Name:(NSString *)name Time:(NSString *)timeStr Content:(NSString *)contentStr Sex:(BOOL)sex ;
@end
