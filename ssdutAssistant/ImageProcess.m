//
//  ImageProcess.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/21.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ImageProcess.h"

@implementation ImageProcess
- (void)storageImgWithStudentID:(NSString *)studentID WithImage:(UIImage *)headImage WithImageIP:(NSString *)imageIP
{
    NSArray * documentPaths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    NSString * studentFile = [documentPath stringByAppendingPathComponent:studentID];
    [fileManager createDirectoryAtPath:studentFile withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * imgFile = [studentFile stringByAppendingPathComponent:@"image"];
    NSString * imgIPFile = [studentFile stringByAppendingPathComponent:@"imageIP"];
    
    [imageIP writeToFile:imgIPFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [UIImagePNGRepresentation(headImage) writeToFile:imgFile atomically:YES];
    

    //[fm createFileAtPath:imgFile contents:dddd attributes:nil];
    //NSLog(@"%@",ggggg);
}

- (UIImage *)getImgWithStudentID:(NSString *)studentID
{
    NSArray * documentPaths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    NSString * studentFile = [documentPath stringByAppendingPathComponent:studentID];
    NSString * imgFile = [studentFile stringByAppendingPathComponent:@"image"];
    NSLog(@"%@",imgFile);
   // NSData * imgData = [NSData dataWithContentsOfFile:imgFile];
    UIImage * image = [UIImage imageWithContentsOfFile:imgFile];
    
    return image;
}

- (BOOL)ifImageHaveHadWithStudentID:(NSString *)studentID ImageIP:(NSString *)netImgIP
{
//    NSUserDefaults * userDefualts = [NSUserDefaults standardUserDefaults];
    
    NSArray * documentPaths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    NSString * studentFile = [documentPath stringByAppendingPathComponent:studentID];
    NSString * imgIPFile = [studentFile stringByAppendingPathComponent:@"imageIP"];
    NSString * imgIP = [NSString stringWithContentsOfFile:imgIPFile encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",documentPath);
    NSLog(@"%@",netImgIP);
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * fileArr =[fileManager subpathsAtPath:documentPath];

    NSString * imgFile = [studentFile stringByAppendingPathComponent:@"image"];
    UIImage * image = [UIImage imageWithContentsOfFile:imgFile];
    
    if ([imgIP isEqual:netImgIP] && image) {
        for (NSInteger i = 0 ; i < [fileArr count]; i ++) {
            if ([studentID isEqual:[fileArr objectAtIndex:i]]) {
                NSLog(@"dafadffd:%@",[fileArr objectAtIndex:i]);
                return YES;
            }
        }

    }
 
    return NO;
}
@end
