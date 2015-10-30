//
//  AddNewViewController.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/29.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddNewDelegate

- (void)addNewTips;

@end

@interface AddNewViewController : UIViewController
@property (nonatomic ,strong) id<AddNewDelegate> delegate;
@end
