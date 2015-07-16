//
//  LessonButton.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/16.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "LessonButton.h"
@interface LessonButton()

@property (nonatomic) IBOutlet UILabel * courseLabel;
@property (nonatomic) IBOutlet UILabel * localLabel;
@end
@implementation LessonButton

-(void)setCourse:(NSString *)courseStr Local:(NSString *)localStr BackgroundColor:(NSInteger)colorValue
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
