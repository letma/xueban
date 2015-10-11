//
//  SSDUTNewsWebViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SSDUTNewsWebViewController.h"

@interface SSDUTNewsWebViewController ()<UIWebViewDelegate>

@end

@implementation SSDUTNewsWebViewController
@synthesize articalID;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setBackgroundImage:UIIMGName(@"login_icon_cancel") forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(20, 28,23 , 23);
    [cancelBtn addTarget:self action:@selector(backToList) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    
    UIView * linView = [[UIView alloc] initWithFrame:CGRectMake(0, 63, WINWIDTH, 1)];
    linView.backgroundColor = UIColorFromRGB(0xcccccc);
    [topView addSubview:linView];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WINWIDTH, WINHEIGHT-64)];
    webView.delegate = self;
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

- (void)backToList
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //[self.navigationController.navigationBar setBarTintColor:RGB(45, 45, 45)];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
}

#pragma mark - UIWebView
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString * str = @"download.jsp";
    if ([[request.URL absoluteString] rangeOfString:str].location != NSNotFound) {
        NSLog(@"hahhahahahaah");
        return NO;

    }
    return YES;
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
