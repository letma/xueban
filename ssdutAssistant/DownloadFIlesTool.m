//
//  DownloadFIlesTool.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/30.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "DownloadFIlesTool.h"

@implementation DownloadFIlesTool
- (BOOL)ifHaveDownload:(NSString *)fileName{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * studentID = [userDefaults objectForKey:MyStudentId_Key];
    NSDictionary * dic = [userDefaults objectForKey:FilesList_Key];
    NSArray * arr = [dic objectForKey:studentID];
    for (NSInteger i = 0; i < [arr count]; i ++) {
        if ([fileName isEqual:[arr objectAtIndex:i]]) {
            return YES;
        }
    }
    return NO;
}
- (void)downloadWithURL:(NSURL *)url SavePath:(NSString *)savePath{
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url];
    [request addValue:@"http://ssdut.dlut.edu.cn/index/bkstz.htm" forHTTPHeaderField:@"referer"];
    AFHTTPRequestOperation * operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    NSArray * documentPaths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    NSString * studentFile = [documentPath stringByAppendingPathComponent:[userDefaults objectForKey:MyStudentId_Key]];
    NSString * filePath = [studentFile stringByAppendingPathComponent:savePath];
    NSLog(@"path:%@",studentFile);
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:filePath append:NO]];
}


- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress

{
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    [request addValue:@"http://ssdut.dlut.edu.cn/index/bkstz.htm" forHTTPHeaderField:@"referer"];
    
    NSArray * documentPaths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    NSString * studentFile = [documentPath stringByAppendingPathComponent:[userDefaults objectForKey:MyStudentId_Key]];
    NSString * filePath = [studentFile stringByAppendingPathComponent:savedPath];
    NSLog(@"%@",filePath);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:filePath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        
        NSString * studentID = [userDefaults objectForKey:MyStudentId_Key];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:[userDefaults objectForKey:FilesList_Key]];;
        if ([[dic objectForKey:studentID] count] == 0) {
             NSMutableArray * arr = [[NSMutableArray alloc] init];
            [arr addObject:savedPath];
            [dic setObject:arr forKey:studentID];
        }else{
            NSMutableArray * arr = [[NSMutableArray alloc] initWithArray:[dic objectForKey:studentID]];
            [dic removeObjectForKey:studentID];
            [arr addObject:savedPath];
            [dic setObject:arr forKey:studentID];
        }
        [userDefaults setObject:dic forKey:FilesList_Key];
        [userDefaults synchronize];
       
        NSLog(@"***%@",[userDefaults objectForKey:FilesList_Key]);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}


@end
