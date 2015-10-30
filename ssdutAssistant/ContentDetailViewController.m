//
//  ContentDetailViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/28.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ContentDetailViewController.h"
#import "ContentTableViewCell.h"
#import "ReviewTableViewCell.h"
@interface ContentDetailViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSInteger page;
}
@property (nonatomic,strong) IBOutlet UITableView * tableView;
@property (nonatomic,strong)NSUserDefaults * userDefaults;
@property (nonatomic,strong)NSMutableData * reviewData;
@property (nonatomic,strong)NSMutableArray * reviewArr;
@property (nonatomic ,strong) UIView * bottomView;
@property (nonatomic ,strong) UIButton * sendBtn;
@property (nonatomic ,strong) UITextView * messageTv;
@property (nonatomic ,strong) UILabel * placeholderLbl;
@end

@implementation ContentDetailViewController
@synthesize controllerContent;
@synthesize controllerHeadImg;
@synthesize controllerName;
@synthesize controllerSex;
@synthesize controllerTime;
@synthesize controllerMessageID;
@synthesize controllerIsLike;
@synthesize controllerLikeNum;
@synthesize controllerReplyCounts;
@synthesize controllerViewCounts;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    page = 1;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.reviewArr = [[NSMutableArray alloc] init];
    [self loadData];
    
    [self.tableView registerNibWithClass:[ContentTableViewCell class]];
    [self.tableView registerNibWithClass:[ReviewTableViewCell class]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView)];
    [self.tableView addGestureRecognizer:singleTap];
    
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
    self.placeholderLbl.text = @"快评论他吧";
    self.placeholderLbl.textColor = UIColorFromRGB(0xa0a0a0);
    self.placeholderLbl.font = [UIFont systemFontOfSize:16.0];
    [self.bottomView addSubview:self.placeholderLbl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

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
    NSString * postStr = [NSString stringWithFormat:@"Content=%@&Type=4&Public=true&ToId=%@",self.messageTv.text,self.controllerMessageID];
    
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
            [self.reviewArr removeAllObjects];
            [self loadData];
            [self.tableView reloadData];
            self.messageTv.text = @"";
            self.placeholderLbl.text = @"快评论他吧";
            [self.messageTv resignFirstResponder];
        }else{
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"发送失败" message:[dic objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSMutableArray * arr = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:MySelectCell_Key]];
    NSString * cellIsLike = self.controllerIsLike ? @"1" : @"0";
    [arr replaceObjectAtIndex:1 withObject:cellIsLike];
    [self.userDefaults setObject:arr forKey:MySelectCell_Key];
    [self.userDefaults synchronize];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@messages/4/%@/%ld",DLUT_SOCIAL_IP,self.controllerMessageID,page];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSURLConnection  * connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        self.reviewData = [[NSMutableData alloc] init];
    }
    
}

#pragma mark - NSUrlConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.reviewData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:self.reviewData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"+++++++++++++++%@",dic);
    if ([[dic objectForKey:@"status"] boolValue]) {
        if ([[dic objectForKey:@"msg"] count] != 0) {
            [self.reviewArr addObjectsFromArray:[dic objectForKey:@"msg"]];
            
            
            if ([self.reviewArr count] == 20 * page) {
                page ++;
                [self loadData];
            }
        }
        
    }
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.reviewArr count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ContentTableViewCell" forIndexPath:indexPath];
        [cell createCellWithHeadImage:controllerHeadImg Name:controllerName Time:controllerTime Content:controllerContent MessageID:controllerMessageID Sex:controllerSex ViewCount:controllerViewCounts ReplyCount:controllerReplyCounts LikeNum:controllerLikeNum IsLike:controllerIsLike];
        [cell.replyBtn addTarget:self action:@selector(replyDo:) forControlEvents:UIControlEventTouchUpInside];
        [cell.likeBtn addTarget:self action:@selector(likeDo:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        
        ReviewTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewTableViewCell" forIndexPath:indexPath];
        NSDictionary * dic =[self.reviewArr objectAtIndex:indexPath.row - 1];
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString * content = controllerContent;
        CGFloat height = [content getHeightWithFontSize:17 Width:WINWIDTH -50];
        return 129 + height;
    }else{
        NSDictionary * dic =[self.reviewArr objectAtIndex:indexPath.row - 1];
        NSString * content = [dic objectForKey:@"Content"];
        CGFloat height = [content getHeightWithFontSize:17 Width:WINWIDTH -50];
        return 89 + height;
    }
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
        self.placeholderLbl.text = @"快评论他吧";
    }else{
        self.placeholderLbl.text = @"";
    }
}

- (void)replyDo:(UIButton *)btn
{
    [self.messageTv becomeFirstResponder];
}
- (void)likeDo:(UIButton *)btn
{
    
    NSIndexPath * path = [NSIndexPath indexPathForRow:0 inSection:0];
    ContentTableViewCell * cell = (ContentTableViewCell *)[self.tableView cellForRowAtIndexPath:path];
    NSInteger i;
    if (cell.cellIsLike) {
        i = 1;
    }else{
        i = 0;
    }
    NSString * urlStr = [NSString stringWithFormat:@"%@judge/%@/2/%ld",DLUT_SOCIAL_IP,cell.cellMessageID,i];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([[dic objectForKey:@"status"] boolValue]) {
        [cell clickZan];
    }
    self.controllerIsLike = cell.cellIsLike;
}
@end

