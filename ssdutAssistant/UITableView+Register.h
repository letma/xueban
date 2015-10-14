//
//  UITableView+Register.h
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>

//注册tableviewcelld的类目
@interface UITableView (Register)

- (void)registerNibWithClass:(Class)classid;

@end
