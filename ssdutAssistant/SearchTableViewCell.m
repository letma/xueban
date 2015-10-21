//
//  SearchTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/20.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SearchTableViewCell.h"
@interface SearchTableViewCell()
@property(nonatomic) IBOutlet UIView * backGroundView;
@property(nonatomic) IBOutlet UILabel * titleLbl;
@property (nonatomic) IBOutlet UILabel * publishLbl;
@property (nonatomic) IBOutlet UILabel * numLbl;

@end
@implementation SearchTableViewCell

- (void)awakeFromNib {
    self.backGroundView.layer.shadowColor = UIColorFromRGB(0xaaaaaa).CGColor;
    self.backGroundView.layer.shadowOffset = CGSizeMake(6, 6);
    self.backGroundView.layer.shadowOpacity = 0.8;
    self.backGroundView.layer.shadowRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)creatCellWithTitle:(NSString *)titleStr Publish:(NSString *)publishStr Num:(NSString *)numStr
{
    self.titleLbl.text = titleStr;
    self.publishLbl.text = publishStr;
    self.numLbl.text = numStr;
}

- (void)haveGone
{
    [self.titleLbl setTextColor:UIColorFromRGB(0xefefef)];
    [self.publishLbl setTextColor:UIColorFromRGB(0xefefef)];
    [self.numLbl setTextColor:UIColorFromRGB(0xefefef)];
}
@end
