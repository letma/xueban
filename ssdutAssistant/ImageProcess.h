//
//  ImageProcess.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/21.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageProcess : NSObject
- (void)storageImgWithStudentID:(NSString *)studentID WithImage:(UIImage *)headImage WithImageIP:(NSString *)imageIP;

- (UIImage *)getImgWithStudentID:(NSString *)studentID;

- (BOOL)ifImageHaveHadWithStudentID:(NSString *)studentID;
@end
