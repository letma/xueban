//
//  SSDUTNewsWebViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SSDUTNewsWebViewController.h"

@interface SSDUTNewsWebViewController ()<UIWebViewDelegate>
{
    BOOL bottomViewFlag;
}

@property (nonatomic) UIProgressView * progressView;

@property (nonatomic) UIView * bottomView;
@property (nonatomic) UIWebView * webView;
@property (nonatomic) NSUserDefaults * userDefaults;
@end

@implementation SSDUTNewsWebViewController
@synthesize articalID;
@synthesize controllerFileLinkArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bottomViewFlag = NO;
    self.userDefaults = [NSUserDefaults standardUserDefaults];
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
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WINWIDTH, WINHEIGHT-64)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@article/%@",DLUT_NEWS_IP,articalID];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    //底下的栏
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, WINHEIGHT - 49, WINWIDTH, 49)];
    self.bottomView.backgroundColor = UIColorFromRGB(0xefefef);
    [self.view addSubview:self.bottomView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xcccccc);
    [self.bottomView addSubview:lineView];
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(40, 14, 20, 20);
    [backBtn setBackgroundImage:UIIMGName(@"erp_icon_leftArrow") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goToBack) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:backBtn];
    
    UIButton * forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forwardBtn.frame = CGRectMake(100, 14, 20, 20);
    [forwardBtn setBackgroundImage:UIIMGName(@"erp_icon_rightArrow") forState:UIControlStateNormal];
    [forwardBtn addTarget:self action:@selector(goToForward) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:forwardBtn];
    
    UIButton * reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadBtn.frame = CGRectMake(WINWIDTH - 60, 14, 20, 20);
    [reloadBtn setBackgroundImage:UIIMGName(@"erp_icon_reload") forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(goToReload) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:reloadBtn];

    self.bottomView.hidden = YES;
    
    NSLog(@"+++%@",controllerFileLinkArr);
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
        NSLog(@"hahhahahahaah:%@",request.URL);
        NSInteger location = [[request.URL absoluteString] rangeOfString:@"?"].location;
        NSString *subUrlStr = [[request.URL absoluteString] substringFromIndex:location];
        NSLog(@"sub:%@",subUrlStr);
        NSString * savePath;
        for (NSInteger i = 0; i < [controllerFileLinkArr count]; i ++) {
            NSDictionary * dic = [controllerFileLinkArr objectAtIndex:i];
            NSString * tempUrlStr = [dic objectForKey:@"link"];
            NSInteger tempLocation = [tempUrlStr rangeOfString:@"?"].location;
            NSString * tempSubUrlStr = [tempUrlStr substringFromIndex:tempLocation];
            NSLog(@"temp:%@",tempSubUrlStr);

            if ([subUrlStr isEqual:tempSubUrlStr]) {
                savePath = [dic objectForKey:@"fileName"];
            }
        }
        DownloadFIlesTool * downloadFile = [[DownloadFIlesTool alloc] init];
        
        if (![downloadFile ifHaveDownload:savePath]) {
            [downloadFile downloadFileWithOption:@{@"userid":[self.userDefaults objectForKey:MyStudentId_Key]}
                                   withInferface:[request.URL absoluteString]
                                       savedPath:savePath
                                 downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     
                                 } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     
                                 } progress:^(float progress) {
                                     
                                 }];

        }else{
            NSLog(@"已经下载过了");
        }

//        [downloadFile downloadFileWithOption:@{@"userid":[self.userDefaults objectForKey:MyStudentId_Key]}
//                               withInferface:[request.URL absoluteString]
//                                   savedPath:savePath
//                             downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//                                 
//                             } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                 
//                             } progress:^(float progress) {
//                                 
//                             }];
        

        return NO;

    }
    
    NSString * urlStr = DLUT_NEWS_IP;
    
    if ([[request.URL absoluteString] rangeOfString:urlStr].location != NSNotFound) {
        
        bottomViewFlag = NO;
        
    }else{
            
        bottomViewFlag = YES;

    }
    
    return YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, WINWIDTH, 0)];
    self.progressView.progressTintColor = UIColorFromRGB(0xFF2730);
    
    [self.view addSubview:self.progressView];
    [self.progressView setProgress:0.7 animated:YES];
    
    if (!bottomViewFlag) {
        self.bottomView.hidden = YES;
        self.webView.scrollView.bounces = YES;
    }

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.progressView setProgress:1.0 animated:YES];
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(progressRemove) userInfo:nil repeats:YES];
    NSLog(@"%@",timer);
    if (bottomViewFlag) {
        self.webView.scrollView.bounces = NO;
        self.bottomView.hidden = NO;
    }

    //[self.progressView removeFromSuperview];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

-(void)progressRemove
{
    [self.progressView removeFromSuperview];
}

#pragma mark - WebDo
- (void)goToBack
{
    [self.webView goBack];

}

- (void)goToForward
{
    [self.webView goForward];
}

-(void)goToReload
{
    [self.webView reload];
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
