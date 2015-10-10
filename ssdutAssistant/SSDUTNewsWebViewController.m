//
//  SSDUTNewsWebViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SSDUTNewsWebViewController.h"

@interface SSDUTNewsWebViewController ()

@end

@implementation SSDUTNewsWebViewController
@synthesize articalID;
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT)];
//    backgroundView.backgroundColor = UIColorFromRGB(0xefefef);
//    [[[UIApplication sharedApplication] keyWindow] addSubview:backgroundView];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT-64)];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@article/%@",DLUT_SSDUTNEWS_IP,articalID];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
