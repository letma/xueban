//
//  UITableView+Register.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "UITableView+Register.h"

@implementation UITableView (Register)

- (void)registerNibWithClass:(Class)classid
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *identifier = NSStringFromClass(classid);
    UINib *nib = [UINib nibWithNibName:identifier bundle:bundle];
    [self registerNib:nib forCellReuseIdentifier:identifier];
}

@end
