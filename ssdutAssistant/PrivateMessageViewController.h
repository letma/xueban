//
//  PrivateMessageViewController.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/25.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivateMessageViewController : UIViewController
@property (nonatomic,strong)NSString * controllerName;
@property (nonatomic ,strong) UIImage * guestHeadImg;
@property (nonatomic, assign) NSInteger senderID;
@end
