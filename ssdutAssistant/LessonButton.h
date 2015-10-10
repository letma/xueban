//
//  LessonButton.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/16.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonButton : UIButton
@property(nonatomic) NSInteger ColorValue;
@property(nonatomic) BOOL IFCover;

/*
 *设置cell的课程名 上课地点 背景颜色
 */
-(void)setCourse:(NSString *)courseStr Local:(NSString *)localStr BackgroundColor:(NSInteger)colorValue IfCover:(BOOL)ifCover CornerIndex:(NSInteger)cornerIndex;

-(void)setCourseFont:(CGFloat)courseSize LocalFont:(CGFloat)localSize;
@end
