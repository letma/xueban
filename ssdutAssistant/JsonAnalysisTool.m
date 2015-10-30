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
@synthesize fileLinkArr;

- (void)getSSDutNewsContentWith:(NSArray *)newsArr Index:(NSInteger)index
{
    NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[newsArr objectAtIndex:index]];

    NSLog(@"%@",dic);
    
    NSString * time =  [NSString stringWithFormat:@"%@",[dic objectForKey:@"time"]];
    NSString * tttt = [time substringToIndex:10];
    NSDate * contentTime = [[NSDate alloc] initWithTimeIntervalSince1970:[tttt integerValue]];

    //NSLog(@"++%ld",[tttt integerValue]);
    //NSDate * cccc = [[NSDate alloc] initWithTimeIntervalSinceNow:[time integerValue]/1000000.0];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:MM"];
    timeStr = [dateFormatter stringFromDate:contentTime];
    
    titleStr = [dic objectForKey:@"title"];
    clickCountStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"clickCount"]];
    articalIDStr = [dic objectForKey:@"id"];
    fileLinkArr = [[NSMutableArray alloc] initWithArray:[dic objectForKey:@"fileLinks"]];
    
}
@end
