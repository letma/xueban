//
//  DownloadFIlesTool.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/30.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadFIlesTool : NSObject
- (BOOL)ifHaveDownload:(NSString *)fileName;

- (void)downloadWithURL:(NSURL *)url SavePath:(NSString *)savePath;

- (void)downloadFileWithOption:(NSDictionary *)paramDic
                 withInferface:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress;
@end
