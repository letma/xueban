//
//  NetworkingNoticeView.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/15.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "NetworkingNoticeView.h"
@interface NetworkingNoticeView()

@property(nonatomic,strong)IBOutlet UIView * backView;
@end
@implementation NetworkingNoticeView

- (void)setCornerRadius
{
    self.backView.layer.cornerRadius = 5;
}


@end
