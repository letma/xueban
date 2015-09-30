//
//  ChangeWeekView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/29.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ChangeWeekView.h"
@interface ChangeWeekView()

@property (nonatomic) IBOutlet UIView * backGroundView;
@end
@implementation ChangeWeekView

- (void)setCornerRadius
{
    self.backGroundView.layer.cornerRadius = 5;
    self.weekTableView.layer.cornerRadius = 5;
}

@end
