//
//  ChangeWeekView.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/29.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeWeekView : UIView
@property (nonatomic ,strong) IBOutlet UITableView * weekTableView;

- (void)setCornerRadius;
@end
