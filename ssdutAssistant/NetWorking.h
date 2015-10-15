//
//  NetWorking.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
@property (nonatomic,readonly) NSURL * url;
@property (nonatomic,readonly) NSData * contentData;
@property (nonatomic,readonly) NSString * errorStr;
@property (nonatomic,readonly) NSMutableArray * contentArr;


//同步GET 通过url获取数据 返回 (id)类型
- (id)synchronousGetContentWithUrl:(NSString *)urlStr;

//异步GET 通过url获取数据并传给存储到userdefaults里
- (void)getContentWithUrl:(NSString *)urlStr SaveWithStr:(NSString *)saveKey;

//POST 通过url获取数据并传给存储到userdefaults里
- (void)postContentWithUrl:(NSString *)urlStr PostStr:(NSString *)postStr SaveWithStr:(NSString *)saveKey;

@end
