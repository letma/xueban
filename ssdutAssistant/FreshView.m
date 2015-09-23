//
//  FreshView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/15.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "FreshView.h"
@interface FreshView()
@property(nonatomic ,strong)IBOutlet UIActivityIndicatorView * activityView;
@property(nonatomic,strong) IBOutlet UIView * backView;
@end

@implementation FreshView

- (void)freshStart
{
    self.backView.layer.cornerRadius = 10;
    [self.activityView startAnimating];
}

- (void)freshEnd
{
    [self.activityView stopAnimating];
}

@end
