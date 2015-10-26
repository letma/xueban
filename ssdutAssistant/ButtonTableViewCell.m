//
//  ButtonTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/25.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ButtonTableViewCell.h"
@interface ButtonTableViewCell()
@end

@implementation ButtonTableViewCell
@synthesize cellBtn;

- (void)awakeFromNib {
    cellBtn.userInteractionEnabled = YES;
    
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    cellBtn.layer.cornerRadius = 5;
    cellBtn.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)creatCellWithIndex:(NSInteger)index
{

    switch (index) {
        case 6:
            cellBtn.backgroundColor = UIColorFromRGB(0x16ABC6);
            [cellBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
            [cellBtn setTitle:@"发私信" forState:UIControlStateNormal];
            break;
        case 7:
            cellBtn.backgroundColor = UIColorFromRGB(0xffffff);
            [cellBtn setTitleColor:UIColorFromRGB(0x16ABC6) forState:UIControlStateNormal];
            [cellBtn setTitle:@"去留言" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}



@end
