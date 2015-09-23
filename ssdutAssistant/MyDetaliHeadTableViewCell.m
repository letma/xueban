//
//  MyDetaliHeadTableViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyDetaliHeadTableViewCell.h"
@interface MyDetaliHeadTableViewCell ()
@property (nonatomic,strong) IBOutlet UIImageView * headImageView;
@end

@implementation MyDetaliHeadTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMyHeadImage:(UIImage *)myHeadImage
{
    self.headImageView.image = myHeadImage;
}

@end
