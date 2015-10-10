//
//  JsonAnalysisTool.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "JsonAnalysisTool.h"

@implementation JsonAnalysisTool
@synthesize timeStr;
@synthesize titleStr;
@synthesize clickCountStr;
@synthesize articalIDStr;

- (void)getSSDutNewsContentWith:(NSArray *)newsArr Index:(NSInteger)index
{
    NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[newsArr objectAtIndex:index]];

    NSString * time = [dic objectForKey:@"time"];
    NSDate * contentTime = [[NSDate alloc] initWithTimeIntervalSince1970:[time integerValue]/1000.0];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:MM"];
    timeStr = [dateFormatter stringFromDate:contentTime];
    
    titleStr = [dic objectForKey:@"title"];
    clickCountStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"clickCount"]];
    articalIDStr = [dic objectForKey:@"id"];
    
}
@end
