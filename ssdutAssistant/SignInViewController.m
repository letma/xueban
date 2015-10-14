//
//  SignInViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/10.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "SignInViewController.h"
#import "NetworkingNoticeView.h"
#import "NSTimer+Addition.h"
#import "MyDetailViewController.h"
#import "FreshView.h"

@interface SignInViewController () <UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>

{
    NSInteger reachbilityStatus;
    NSInteger animationFlag ;
}
@property (nonatomic) IBOutlet UIView * userView;
@property (nonatomic) IBOutlet UIView * passwordView;
@property (nonatomic) IBOutlet UIView * libPasswordView;
@property (nonatomic) IBOutlet UIButton * signInBtn;

@property (nonatomic,strong) IBOutlet UITextField * userTf;
@property (nonatomic,strong) IBOutlet UITextField * passwordTf;
@property (nonatomic,strong) IBOutlet UITextField * libPasswordTf;

@property (nonatomic,strong) NSMutableData * loginData;
@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic,strong) NetworkingNoticeView * warningView;
@property (nonatomic,strong) NSURLConnection * connection;
@property (nonatomic,strong) FreshView * freshView;
@property (nonatomic,strong) NSTimer * animationTimer;


@end


@implementation SignInViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    animationFlag = 0;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];

    self.userView.layer.cornerRadius =5;
    self.passwordView.layer.cornerRadius = 5;
    self.libPasswordView.layer.cornerRadius = 5;
    self.signInBtn.layer.cornerRadius = 5;
    self.signInBtn.titleLabel.alpha = 0.2;
    self.signInBtn.userInteractionEnabled = NO;
    
    self.userTf.delegate = self;
    self.passwordTf.delegate = self;
    self.libPasswordTf.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
}

-(IBAction)cancelBtnDo:(id)sender
{
    [self.warningView removeFromSuperview];;
    [self dismissViewControllerAnimated:YES completion:nil];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self viewDown];
}

- (IBAction)singleTap:(id)sender
{
    [self.userTf resignFirstResponder];
    [self.passwordTf resignFirstResponder];
    [self.libPasswordTf resignFirstResponder];
    
}

- (IBAction)signIn:(id)sender
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
//    NSInteger netWorkStatus = [AFNetworkReachabilityManager sharedManager].reachable;
//    
//    NSLog(@"networkStatus:%ld",netWorkStatus);
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        NSLog(@"statusssss:%ld",status);
        if (status > 0) {
            //风火轮
            NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"FreshView" owner:self options:nil];
            self.freshView = [nibArray objectAtIndex:0];
            self.freshView.frame = CGRectMake(0, 0, 80, 80);
            self.freshView.center = CGPointMake(WINWIDTH/2.0, WINHEIGHT/2.0);
            [self.view addSubview:self.freshView];
            [self.freshView freshStart];
            
            //网络情况测试
            reachbilityStatus = 100;
            NSString * urlStr = [NSString stringWithFormat:@"%@",TEST_IP];
            NSURL * url = [NSURL URLWithString:urlStr];
            NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
                if (![[[httpResponse allHeaderFields] objectForKey:@"OurEDA"] isEqual:@"OurEDA"]) {
                    reachbilityStatus = 0;
                };
                if (reachbilityStatus == 0) {
                    
                    if (animationFlag == 0) {
                        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animationDo) userInfo:nil repeats:YES];
                    }
                    animationFlag = 0;
                    [self.freshView removeFromSuperview];
                }else{
                    //网络申请
                    NSString * urlStr = [NSString stringWithFormat:@"%@register",DLUT_IP];
                    NSURL * url = [NSURL URLWithString:urlStr];
                    NSString * postStr = [NSString stringWithFormat:@"student_id=%@&pwd=%@&pwd_lib=%@",self.userTf.text,self.passwordTf.text,self.libPasswordTf.text];

                    NSData * postData = [postStr dataUsingEncoding:NSUTF8StringEncoding];
                    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
                    [request setHTTPMethod:@"POST"];
                    [request setHTTPBody:postData];
                    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                    if (self.connection) {
                        self.loginData = [NSMutableData new];
                    }
                    
                }
            }];

        }else{
            if (animationFlag == 0) {
                self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(animationDo) userInfo:nil repeats:YES];
            }
            animationFlag = 0;
            
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}


#pragma mark - NetWorkingAnmation
- (void)warningViewDown
{

    if (!self.warningView) {
        NSArray * nibArray = [[NSBundle mainBundle] loadNibNamed:@"NetworkingNoticeView" owner:self options:nil];
        self.warningView = [nibArray objectAtIndex:0];
    }

    self.warningView.layer.cornerRadius = 5;
    [self.warningView setCornerRadius];
    self.warningView.frame = CGRectMake((WINWIDTH - 300)/2.0, -42, 300, 40);
    [self.view addSubview:self.warningView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    self.warningView.frame = CGRectMake((WINWIDTH - 300)/2.0, 0, 300, 40);
    [UIView commitAnimations];
    
}

-(void)warningViewKeep
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    self.warningView.frame = CGRectMake((WINWIDTH - 300)/2.0, 0, 300, 40);
    [UIView commitAnimations];
}
- (void)warningViewUp
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    self.warningView.frame = CGRectMake((WINWIDTH - 300)/2.0, -42, 300, 40);
    [UIView commitAnimations];
    
    
}

-(void)animationDo
{
    if (animationFlag < 3) {
        if (animationFlag == 0) {
            [self warningViewDown];
        }
        if (animationFlag == 1) {
            [self warningViewKeep];
        }
        if (animationFlag == 2) {
            [self warningViewUp];
        }

        animationFlag ++;
    }
}

- (void)textFieldDidChange
{

    if (self.userTf.text.length != 0 &&self.passwordTf.text.length != 0 && self.libPasswordTf.text.length != 0) {
        self.signInBtn.titleLabel.alpha = 1;
        self.signInBtn.userInteractionEnabled = YES;
    }else{
        self.signInBtn.titleLabel.alpha = 0.2;
        self.signInBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - NSUrlConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if ([connection isEqual:self.connection]) {
        [self.loginData appendData:data];
    }
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.freshView removeFromSuperview];
    if ([connection isEqual:self.connection]) {

        NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:self.loginData options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"000%@",contentDic);
        
        if ([[contentDic objectForKey:@"status"] boolValue]) {
            
            [self.userDefaults setBool:YES forKey:IF_CourseHave];
            
            NSDictionary * loginDic = [contentDic objectForKey:@"msg"];
            NSLog(@"%@",loginDic);

            [self.userDefaults setObject:[loginDic objectForKey:@"LoginToken"] forKey:LoginToken_Str];
            NSLog(@"***%@",[loginDic objectForKey:@"LoginToken"]);
           
            [self.userDefaults setObject:[loginDic objectForKey:@"Token"] forKey:Token_Str];
            [self.userDefaults setObject:[loginDic objectForKey:@"User"] forKey:UserContent_Key];
            [self.userDefaults setBool:YES forKey:IF_Login];
            [self.userDefaults setObject:self.userTf.text forKey:MyStudentId_Key];
            [self.userDefaults synchronize];
            [self.warningView removeFromSuperview];
            [self dismissViewControllerAnimated:YES completion:nil];

            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
            //异步获取课表
            NSString * urlStr = [NSString stringWithFormat:@"%@curriculum",DLUT_IP];
            NSURL * url = [NSURL URLWithString:urlStr];
            NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
            NSLog(@"%@",[self.userDefaults objectForKey:LoginToken_Str]);
            [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                //NSLog(@"%@",contentDic);
                if ([[contentDic objectForKey:@"status"] boolValue]) {
                    NSArray * courseArr = [contentDic objectForKey:@"msg"];
                    [self.userDefaults setObject:courseArr forKey:MyCourse_Key];
                    
                }
                
            }];
            
            //异步获取成绩                                   
            NSString * scoreUrlStr = [NSString stringWithFormat:@"%@scores",DLUT_IP];
            NSURL * scoreUrl = [NSURL URLWithString:scoreUrlStr];
            NSMutableURLRequest * scoreRequest = [[NSMutableURLRequest alloc] initWithURL:scoreUrl];
            //NSLog(@"%@",[self.userDefaults objectForKey:LoginToken_Str]);
            [scoreRequest setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
            [NSURLConnection sendAsynchronousRequest:scoreRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                
                NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",contentDic);
                if ([[contentDic objectForKey:@"status"] boolValue]) {
                    NSArray * courseArr = [contentDic objectForKey:@"msg"];
                    [self.userDefaults setObject:courseArr forKey:MyScore_Key];
                    
                }
                
            }];
            
            
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"用户名或密码错误" message:@"请重新输入用户名或密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }


    
}

#pragma mark - UITextFeild
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self viewUp];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self viewDown];
}


#pragma mark - Animation
- (void)viewUp
{
    NSInteger change_h;
    NSInteger win_hight = WINHEIGHT;
    switch (win_hight) {
        case 480:
            change_h = -180;
            break;
        case 568:
            change_h = -100;
            break;
        case 667:
            change_h = -40;
            break;
        case 736:
            change_h = -40;
            break;
            
        default:
            break;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(0, change_h, WINWIDTH, WINHEIGHT);
    [UIView commitAnimations];
    
}

- (void)viewDown
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(0, 0, WINWIDTH, WINHEIGHT);
    [UIView commitAnimations];
}


#pragma mark - StatusBar
- (BOOL)prefersStatusBarHidden
{
    return  YES;
}

@end
