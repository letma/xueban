//
//  CourseViewCell.m
//  ssdutAssistant
//
//  Created by OurEDA on 9/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import "CourseViewCell.h"
@interface CourseViewCell()
@property (nonatomic) IBOutlet UILabel * courseLabel;
@property (nonatomic) IBOutlet UILabel * localLabel;
@end

@implementation CourseViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCourse:(NSString *)courseStr Local:(NSString *)localStr BackgroundColor:(int)colorValue
{
    self.backgroundColor = UIColorFromRGB(colorValue);
    self.courseLabel.text = courseStr;
    self.localLabel.text = localStr;
    
}

-(void)setCourseFont:(CGFloat)courseSize LocalFont:(CGFloat)localSize
{
    self.courseLabel.font = [UIFont systemFontOfSize:courseSize];
    self.localLabel.font = [UIFont systemFontOfSize:localSize];
}

@end
