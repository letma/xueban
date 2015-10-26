//
//  ClassmateDetailViewController.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/24.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassmateDetailViewController : UIViewController
@property (nonatomic, strong) NSString * controllerName;
@property (nonatomic, strong) NSString * controllerMajor;
@property (nonatomic, strong) NSString * controllerStudentID;
@property (nonatomic,strong) NSString * controllerAddress;
@property (nonatomic, strong) UIImage * controllerHeadImg;
@property (nonatomic, assign) BOOL controllerSex;
@property (nonatomic, assign) NSInteger controllerSingle;
@property (nonatomic, assign) NSInteger controllerMessageID;
@end
