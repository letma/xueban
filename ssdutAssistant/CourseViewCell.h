//
//  CourseViewCell.h
//  ssdutAssistant
//
//  Created by OurEDA on 9/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseViewCell : UITableViewCell

/*
 *设置cell的课程名 上课地点 背景颜色
 */
-(void)setCourse:(NSString *)courseStr Local:(NSString *)localStr BackgroundColor:(int)colorValue;

-(void)setCourseFont:(CGFloat)courseSize LocalFont:(CGFloat)localSize;

@end
