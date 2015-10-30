//
//  GPACalculateViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/29.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "GPACalculateViewController.h"

@interface GPACalculateViewController ()

@end

@implementation GPACalculateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绩点计算";
    self.view.backgroundColor = UIColorFromRGB(0xefefef);
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT - 64)];
    NSString * urlStr= [NSString stringWithFormat:@"%@gpa",DLUT_IP];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [request setValue:[userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
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
