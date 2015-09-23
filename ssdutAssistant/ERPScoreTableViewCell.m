//
//  ERPScoreTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/11.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPScoreTableViewCell.h"
@interface ERPScoreTableViewCell()
@property (nonatomic,strong) IBOutlet UILabel * titleLabel;
@property (nonatomic,strong) IBOutlet UILabel * typeLabel;
@property (nonatomic,strong) IBOutlet UILabel * scoreLabel;
@property (nonatomic,strong) IBOutlet UILabel * creditLabel;
@property (nonatomic,strong) IBOutlet UILabel * statusLabel;
@end

@implementation ERPScoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)insertScoreCardWithTitle:(NSString*)titleStr Type:(NSString *)typeStr Score:(NSString *)scoreStr Credit:(NSString *)creditStr Status:(NSString *)statusStr
{
    self.titleLabel.text = titleStr;
    self.typeLabel.text = typeStr;
    self.scoreLabel.text = scoreStr;
    self.creditLabel.text = creditStr;
    self.statusLabel.text = statusStr;
    
}

@end
