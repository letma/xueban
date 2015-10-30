//
//  JsonAnalysisTool.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>
//json解析的工具类
@interface JsonAnalysisTool : NSObject
@property (nonatomic,readonly) NSString * timeStr;
@property (nonatomic,readonly) NSString * titleStr;
@property (nonatomic,readonly) NSString * clickCountStr;
@property (nonatomic,readonly) NSString * articalIDStr;
@property (nonatomic,readonly) NSMutableArray * fileLinkArr;

//SSDUTNEWS获取time title clickCount articalID
- (void)getSSDutNewsContentWith:(NSArray *)newsArr Index:(NSInteger)index;
@end
