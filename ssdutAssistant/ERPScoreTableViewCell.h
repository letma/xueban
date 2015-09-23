//
//  ERPScoreTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/11.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERPScoreTableViewCell : UITableViewCell

-(void)insertScoreCardWithTitle:(NSString*)titleStr Type:(NSString *)typeStr Score:(NSString *)scoreStr Credit:(NSString *)creditStr Status:(NSString *)statusStr;

@end
