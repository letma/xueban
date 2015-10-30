//
//  LeaveMesViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/29.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "LeaveMesViewController.h"
#import "ReviewTableViewCell.h"

@interface LeaveMesViewController ()<UITextViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
}
@property (nonatomic,strong) IBOutlet UITableView * tableView;
@property (nonatomic,strong)NSUserDefaults * userDefaults;
@property (nonatomic ,strong) UIView * bottomView;
@property (nonatomic ,strong) UIButton * sendBtn;
@property (nonatomic ,strong) UITextView * messageTv;
@property (nonatomic ,strong) UILabel * placeholderLbl;
@property (nonatomic ,strong) NSMutableArray * messageArr;
@end

@implementation LeaveMesViewController
@synthesize controllerMesID;
@synthesize controllerName;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@的留言板",controllerName];
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView)];
    [self.tableView addGestureRecognizer:singleTap];
    
    page = 1;
    self.messageArr = [[NSMutableArray alloc] init];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, WINHEIGHT - 49 -64, WINWIDTH, 49)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.autoresizesSubviews = NO;
    [self.view addSubview:self.bottomView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.bottomView addSubview:lineView];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.frame = CGRectMake(WINWIDTH - 68 + 15, 8, 50, 33);
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:UIColorFromRGB(0x16ABC6) forState:UIControlStateNormal];
    [self.sendBtn setBackgroundColor:[UIColor whiteColor]];
    [self.sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.sendBtn];
    
    self.messageTv = [[UITextView alloc] initWithFrame:CGRectMake(10, 12,WINWIDTH - 68,29)];
    //self.messageTv.backgroundColor = [UIColor cyanColor];
    self.messageTv.delegate  =self;
    self.messageTv.autoresizesSubviews = NO;
    self.messageTv.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.messageTv];
    
    self.placeholderLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 200, 20)];
    self.placeholderLbl.text = @"快给他留言吧";
    self.placeholderLbl.textColor = UIColorFromRGB(0xa0a0a0);
    self.placeholderLbl.font = [UIFont systemFontOfSize:16.0];
    [self.bottomView addSubview:self.placeholderLbl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [self loadData];
    [self.tableView registerNibWithClass:[ReviewTableViewCell class]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 -(void)loadData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@messages/0/%ld/%ld",DLUT_SOCIAL_IP,self.controllerMesID,page];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * messageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic;
    if (messageData) {
        dic = [NSJSONSerialization JSONObjectWithData:messageData options:NSJSONReadingMutableContainers error:nil];
    }
    //NSLog(@"%@",dic);
    if ([[dic objectForKey:@"status"] boolValue]) {
        if ([[dic objectForKey:@"msg"] count] != 0) {
            [self.messageArr addObjectsFromArray:[dic objectForKey:@"msg"]];
            
            
            if ([self.messageArr count] == 20 * page) {
                page ++;
                [self loadData];
            }
        }
        
    }
    NSLog(@"+++++++%@",self.messageArr);

}

- (void)tapTableView
{
    [self.messageTv resignFirstResponder];
}

- (void)sendMessage
{
    NSString * urlStr = [NSString stringWithFormat:@"%@leave_message",DLUT_SOCIAL_IP];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSString * postStr = [NSString stringWithFormat:@"Content=%@&Type=0&Public=true&ToId=%ld",self.messageTv.text,self.controllerMesID];
    
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
            page = 1;
            [self.messageArr removeAllObjects];
            [self loadData];
            [self.tableView reloadData];
            self.messageTv.text = @"";
            self.placeholderLbl.text = @"快给他留言吧";
            [self.messageTv resignFirstResponder];
        }else{
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"发送失败" message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [self.messageArr objectAtIndex:indexPath.row];
    NSString * content = [dic objectForKey:@"Content"];
    CGFloat height = [content getHeightWithFontSize:17 Width:WINWIDTH -50];
    return 89 + height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReviewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell" forIndexPath:indexPath];
    NSDictionary * dic =[self.messageArr objectAtIndex:indexPath.row ];
    NSString * name = [dic objectForKey:@"SenderName"];
    NSString * imgIP = [dic objectForKey:@"SenderHeadImage"];
    NSString * studentID = [dic objectForKey:@"SenderStudentId"];
    NSString * content = [dic objectForKey:@"Content"];
    NSString * time = [dic objectForKey:@"CreateAt"];
    BOOL sex = [[dic objectForKey:@"Sex"] boolValue];
    
    
    
    ImageProcess * classmateImg = [[ImageProcess alloc] init];
    
    
    if ([classmateImg ifImageHaveHadWithStudentID:studentID ImageIP:imgIP]) {
        
        [cell createCellWithHeadImage:[classmateImg getImgWithStudentID:studentID] Name:name Time:time Content:content Sex:sex];
        
        
        
    }else{
        NSString * urlStr = imgIP;
        NSURL * url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4.0];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage * img = [UIImage imageWithData:data];
            
            [cell createCellWithHeadImage:img Name:name Time:time Content:content Sex:sex];
            //img 本地化
            ImageProcess * storgeImg = [[ImageProcess alloc]init];
            //NSLog(@"%@  %@",studentID,imgIP);
            [storgeImg storageImgWithStudentID:studentID WithImage:img WithImageIP:imgIP];
            
        }];
        
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - TextView and KeyBoard

- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *boundsValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [boundsValue CGRectValue];
    
    if (keyboardRect.size.width < keyboardRect.size.height)
    {
        float tempHeight = keyboardRect.size.height;
        keyboardRect.size.height = keyboardRect.size.width;
        keyboardRect.size.width = tempHeight;
    }
    
    CGFloat keyboardTop = self.view.frame.size.height - keyboardRect.size.height;
    CGRect bottomViewFrame = self.bottomView.frame;
    
    bottomViewFrame.origin.y = keyboardTop - bottomViewFrame.size.height;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.bottomView.frame = bottomViewFrame;
    [UIView commitAnimations];
    
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    
    NSDictionary* userInfo = [notification userInfo];
    
    CGRect bottomViewFrame = self.bottomView.frame;
    bottomViewFrame.origin.y = self.view.frame.size.height - bottomViewFrame.size.height;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.bottomView.frame = bottomViewFrame;
    [UIView commitAnimations];
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (self.messageTv.text.length == 0) {
        self.placeholderLbl.text = @"快给他留言吧";
    }else{
        self.placeholderLbl.text = @"";
    }
}

@end
