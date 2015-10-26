//
//  ButtonTableViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/25.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonTableViewCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIButton * cellBtn;

-(void)creatCellWithIndex:(NSInteger)index;
@end
