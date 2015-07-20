//
//  NSTimer+Addition.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/20.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)
-(void)pauseTimer;
-(void)resumeTimer;
-(void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
