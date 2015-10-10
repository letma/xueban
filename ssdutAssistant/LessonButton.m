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
@property (nonatomic) IBOutlet UIImageView * cornerView;
@end
@implementation LessonButton


-(void)setCourse:(NSString *)courseStr Local:(NSString *)localStr BackgroundColor:(NSInteger)colorValue IfCover:(BOOL)ifCover CornerIndex:(NSInteger)cornerIndex
{
    NSString * cornerImgName = [NSString stringWithFormat:@"corner_icon_%ld",cornerIndex];
    self.ColorValue = colorValue;
    self.IFCover = ifCover;
    self.backgroundColor = UIColorFromRGB(colorValue);
    self.courseLabel.text = courseStr;
    self.localLabel.text = localStr;
    
    if (ifCover) {
        self.cornerView.image = UIIMGName(cornerImgName);
    }

    
}

-(void)setCourseFont:(CGFloat)courseSize LocalFont:(CGFloat)localSize
{
    self.courseLabel.font = [UIFont systemFontOfSize:courseSize];
    self.localLabel.font = [UIFont systemFontOfSize:localSize];
}

@end
