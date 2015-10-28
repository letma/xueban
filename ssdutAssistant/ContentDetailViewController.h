//
//  ContentDetailViewController.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/28.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentDetailViewController : UIViewController
@property (nonatomic,strong)UIImage * controllerHeadImg;
@property (nonatomic,strong)NSString * controllerName;
@property (nonatomic,strong)NSString * controllerTime;
@property (nonatomic,strong)NSString * controllerContent;
@property (nonatomic,strong)NSString * controllerMessageID;
@property (nonatomic,assign)NSInteger controllerViewCounts;
@property (nonatomic,assign)NSInteger controllerReplyCounts;
@property (nonatomic,assign)NSInteger controllerLikeNum;
@property (nonatomic,assign)BOOL controllerIsLike;
@property (nonatomic,assign)BOOL controllerSex;

@end
