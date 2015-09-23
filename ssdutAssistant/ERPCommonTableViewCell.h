//
//  ERPCommonTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/18.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERPCommonTableViewCell : UITableViewCell
@property (nonatomic) IBOutlet UIButton * leftBtn;
@property (nonatomic) IBOutlet UIButton * rightBtn;

- (void)setCellType:(NSInteger)cellIndex;
@end
