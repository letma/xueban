//
//  UserAgreeementViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/13.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "UserAgreeementViewController.h"

@interface UserAgreeementViewController ()

@end

@implementation UserAgreeementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    NSString * urlStr = [NSString stringWithFormat:@"%@agreement",DLUT_SOCIAL_IP];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT-64)];
    [webView loadRequest:request];
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
