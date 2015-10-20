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


//试试block 没什么卵用
//@property (nonatomic , copy) NSArray * (^ asnchronousGetContent)(NSString * url) ;

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

- (void)getContentWithUrl:(NSString *)urlStr SaveWithStr:(NSString *)saveKey
{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    

    url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",[userDefaults objectForKey:LoginToken_Str]);
    [request setValue:[userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",contentDic);
        if ([[contentDic objectForKey:@"status"] boolValue]) {
            NSArray * courseArr = [contentDic objectForKey:@"msg"];
            [userDefaults setObject:courseArr forKey:saveKey];
            [userDefaults synchronize];
            
            NSLog(@"UserDfaults Array: %@",courseArr);
        }
        
    }];
    
}


- (void)postContentWithUrl:(NSString *)urlStr PostStr:(NSString *)postStr SaveWithStr:(NSString *)saveKey
{

}

@end
