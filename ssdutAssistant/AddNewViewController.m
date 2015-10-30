//
//  AddNewViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/29.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AddNewViewController.h"

@interface AddNewViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property (nonatomic ,strong)IBOutlet UITextView * textView;
@property (nonatomic ,strong)IBOutlet UISwitch * anonymousSwitch;
@property (nonatomic ,strong)IBOutlet UILabel * placeHolderLbl;
@property (nonatomic ,strong)NSUserDefaults * userDefaults;
@property (nonatomic ,strong)UIAlertView * errorAlertView;

@end

@implementation AddNewViewController
@synthesize delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发帖子";
    self.textView.delegate = self;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    UIButton * barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 60, 24);
    [barButton addTarget:self action:@selector(barBtnSelected) forControlEvents:UIControlEventTouchUpInside];
    [barButton setTitle:@"发表" forState:UIControlStateNormal];
    UIBarButtonItem * rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)singleTap:(id)sender {
    [self.textView resignFirstResponder];
}
- (void)barBtnSelected
{
    
    NSString * anonmousStr;
    if (![self.textView.text isEqual:@""]) {
        if(self.anonymousSwitch.on){
            //匿名
            anonmousStr = @"false";
        }else{
            anonmousStr = @"true";
        }
        NSString * urlStr = [NSString stringWithFormat:@"%@leave_message",DLUT_SOCIAL_IP];
        NSLog(@"%@",urlStr);
        NSURL * url = [NSURL URLWithString:urlStr];
        NSString * postStr = [NSString stringWithFormat:@"Content=%@&Type=2&Public=%@&ToId=1",self.textView.text,anonmousStr];
        
        NSData * postData = [postStr dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
        NSData * messageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary * dic;
        if (messageData) {
            dic = [NSJSONSerialization JSONObjectWithData:messageData options:NSJSONReadingMutableContainers error:nil];
            if ([dic objectForKey:@"status"]) {
                [self.textView resignFirstResponder];
                self.textView.text = @"";
                [self.navigationController popViewControllerAnimated:YES];
                [delegate addNewTips];
                
//                self.succedAlertView = [[UIAlertView alloc] initWithTitle:@"发送成功" message:@"" delegate:self cancelButtonTitle:@"返回校园广场" otherButtonTitles:nil, nil];
//                [self.succedAlertView show];
            }else{
                NSString * errorStr = [dic objectForKey:@"msg"];
                self.errorAlertView = [[UIAlertView alloc] initWithTitle:@"发送失败" message:errorStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [self.errorAlertView show];
            }
        }

    }
    
}



#pragma mark -UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length == 0) {
        self.placeHolderLbl.text = @"说点儿什么吧";
    }else{
        self.placeHolderLbl.text = @"";
    }
}

@end
