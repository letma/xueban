//
//  NetWorking.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "NetWorking.h"
@interface NetWorking()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic) NSURLConnection * getConnection;
@property (nonatomic) NSURLConnection * postConnection;

@end

@implementation NetWorking
@synthesize url;
@synthesize contentData;
@synthesize errorStr;
@synthesize contentArr;

- (id)synchronousGetContentWithUrl:(NSString *)urlStr
{
    url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
    contentData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    contentArr = [[NSMutableArray alloc] init];
    contentArr = [NSJSONSerialization JSONObjectWithData:contentData options:NSJSONReadingMutableLeaves error:nil];
    
    return contentArr;
    
    //NSLog(@"-----%@",contentArr);
}

- (void)getContentWithUrl:(NSString *)urlStr ToArr:(id)contentArr
{
    
}
- (void)postContentWithUrl:(NSString *)urlStr PostStr:(NSString *)postStr ToArr:(id)contentArr
{
    
}

@end
