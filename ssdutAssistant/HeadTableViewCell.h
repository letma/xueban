//
//  HeadTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/23.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadTableViewCell : UITableViewCell
- (void)creatCellWithImage:(UIImage *)headImg Name:(NSString *)nameStr Department:(NSString *)departmentStr Sex:(BOOL)sex Single:(NSInteger)single;
@end
