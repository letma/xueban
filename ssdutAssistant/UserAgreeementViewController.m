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
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
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
    [webView loadRequest:request];
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backToList
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
