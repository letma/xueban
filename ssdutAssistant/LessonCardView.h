//
//  LessonCardView.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/16.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LessonCardView : UIView
- (void)setCardWithLesson :(NSString *)lesson Teacher:(NSString *)teacher Credit:(NSString *)credit Week:(NSString *)week Day:(NSString *)day Classroom:(NSString *)classroom Color:(NSInteger)colorValue;
@end
