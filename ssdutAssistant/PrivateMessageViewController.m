//
//  PrivateMessageViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/25.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "PrivateMessageViewController.h"
#import "EmptyTimeTableViewCell.h"
#import "WhiteMessageTableViewCell.h"
#import "BlueMessageTableViewCell.h"
#import "CustomStatusBar.h"

@interface PrivateMessageViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    BOOL keyBoardIsUp;
    CGFloat content_y;
    CGFloat keyBorad_y;
    NSInteger page;
    NSInteger tipNums;
    
}
@property (nonatomic ,strong) UIView * bottomView;
@property (nonatomic ,strong) UIButton * sendBtn;
@property (nonatomic ,strong)  UITableView * priavteTableView;
@property (nonatomic ,strong) UITextView * messageTv;
@property (nonatomic ,strong) UILabel * placeholderLbl;
@property (nonatomic ,strong) UISwipeGestureRecognizer * swipeUp;
@property (nonatomic ,strong) UISwipeGestureRecognizer * swipeDown;
@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic ,strong) NSMutableArray * messageArr;
//@property (nonatomic ,strong) NSMutableArray * heightArr;
//先把头像抓到;
@property (nonatomic ,strong) UIImage * myHeadImg;
@end

@implementation PrivateMessageViewController
@synthesize controllerName;
@synthesize guestHeadImg;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = controllerName;
    self.view.backgroundColor = [UIColor whiteColor];
    

    page = 1;
    keyBoardIsUp = NO;
    content_y = 10000;
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.messageArr = [[NSMutableArray alloc] init];
    //self.heightArr = [[NSMutableArray alloc] init];
    
    ImageProcess * imgProcess = [[ImageProcess alloc] init];
    self.myHeadImg = [imgProcess getImgWithStudentID:[self.userDefaults objectForKey:MyStudentId_Key]];
    
    self.priavteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT - 64 - 49)];
    self.priavteTableView.backgroundColor = UIColorFromRGB(0xEBEBF1);
    self.priavteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.priavteTableView.autoresizesSubviews = NO;
    [self.view addSubview:self.priavteTableView];
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView)];
    [self.priavteTableView addGestureRecognizer:singleTap];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, WINHEIGHT - 49 -64, WINWIDTH, 49)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
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
    self.messageTv.font = [UIFont systemFontOfSize:16];
    [self.bottomView addSubview:self.messageTv];
    
    self.placeholderLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, 200, 20)];
    self.placeholderLbl.text = @"小马哥好帅啊";
    self.placeholderLbl.textColor = UIColorFromRGB(0xa0a0a0);
    self.placeholderLbl.font = [UIFont systemFontOfSize:16.0];
    [self.bottomView addSubview:self.placeholderLbl];
    
    
    self.swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDo)];
    self.swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    self.swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDo)];
    self.swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    //keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

    
    [self registerCells];
    self.priavteTableView.delegate = self;
    self.priavteTableView.dataSource =self;
    [self loadData];

    //[self sendMessage:@"傻叼"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.priavteTableView setContentOffset:CGPointMake(0, self.priavteTableView.contentSize.height - WINHEIGHT + 64 + 49) animated:NO];
    if ([self.messageArr count] != 0) {
        NSIndexPath * path = [NSIndexPath indexPathForRow:[self.messageArr count] - 1 inSection:0];
        [self.priavteTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }

}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)registerCells
{
    [self.priavteTableView registerNibWithClass:[EmptyTimeTableViewCell class]];
    [self.priavteTableView registerNibWithClass:[WhiteMessageTableViewCell class]];
    [self.priavteTableView registerNibWithClass:[BlueMessageTableViewCell class]];
}
- (void)sendMessage
{
    if([self.messageTv.text isEqual:@""])
    {
        NSLog(@"nothing");
    }else{
        [self sendMessage:self.messageTv.text];
    }
}

- (void)loadData
{
    //NSInteger i = 3;
    NSString * urlStr = [NSString stringWithFormat:@"%@messages/3/%ld/%ld",DLUT_SOCIAL_IP,self.senderID,page];
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
    tipNums = [self.messageArr count];
}

- (void)sendMessage:(NSString *)message
{
    //NSInteger i = 1;
    NSString * urlStr = [NSString stringWithFormat:@"%@leave_message",DLUT_SOCIAL_IP];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSString * postStr = [NSString stringWithFormat:@"Content=%@&Type=1&Public=true&ToId=%ld",message,self.senderID];
    
    NSData * postData = [postStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * messageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic;
    if (messageData) {
        dic = [NSJSONSerialization JSONObjectWithData:messageData options:NSJSONReadingMutableContainers error:nil];
    }
    NSLog(@"++++%@",dic);
    
    NSMutableDictionary * tempDic = [[NSMutableDictionary alloc] init];
    [tempDic setObject:message forKey:@"Content"];
    [tempDic setObject:[self.userDefaults objectForKey:MyStudentId_Key] forKey:@"SenderStudentId"];
    NSDate * now = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString * timeStr = [dateFormatter stringFromDate:now];
    [tempDic setObject:timeStr forKey:@"CreateAt"];
    if (!dic) {
        [tempDic setObject:@"error" forKey:@"Error"];
    }
    [self.messageArr addObject:tempDic];
    
   // NSLog(@"%@",self.messageArr);
    

   [self.priavteTableView reloadData];
    
    
    if (self.priavteTableView.contentSize.height > keyBorad_y)
    {
    content_y = self.priavteTableView.contentOffset.y;
    [self.priavteTableView setContentOffset:CGPointMake(0, self.priavteTableView.contentOffset.y + keyBorad_y - 49) animated:NO];
    }
    

    self.messageTv.text = @"";


}

#pragma mark - SingleTap
- (void)tapTableView
{
    [self.messageTv resignFirstResponder];
}

- (void)swipeDo
{
    [self.messageTv resignFirstResponder];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [self.messageArr objectAtIndex:indexPath.row];
    NSString * senderStudentID = [dic objectForKey:@"SenderStudentId"];
    NSString * myStudentID = [self.userDefaults objectForKey:MyStudentId_Key];
    NSString * contentStr =[dic objectForKey:@"Content"];
    NSString * timeStr = [dic objectForKey:@"CreateAt"];
    NSString * errorStr = [dic objectForKey:@"Error"];
    if ([senderStudentID isEqual:myStudentID]) {
        BlueMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BlueMessageTableViewCell" forIndexPath:indexPath];
        [cell creatCellWithImg:self.myHeadImg Content:contentStr Time:timeStr];
        if ([errorStr isEqual:@"error"]) {
            [cell setError];
        }
        
        return cell;
    }else{
        WhiteMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WhiteMessageTableViewCell" forIndexPath:indexPath];
        [cell creatCellWithImg:guestHeadImg Content:contentStr Time:timeStr];
        return cell;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [self.messageArr objectAtIndex:indexPath.row];
    NSString * content = [dic objectForKey:@"Content"];
    
    return [content getHeightWithFontSize:16 Width:WINWIDTH - 132] + 50;
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
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

    if (content_y == 10000) {
        content_y = self.priavteTableView.contentOffset.y;
    }
    
    keyBorad_y = bottomViewFrame.origin.y;
    

    if (self.priavteTableView.contentSize.height > keyBorad_y)
    {

        self.priavteTableView.contentOffset = CGPointMake(0, self.priavteTableView.contentSize.height- bottomViewFrame.origin.y);

 
    }
    
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    
    [self.priavteTableView addGestureRecognizer:self.swipeUp];
    [self.priavteTableView addGestureRecognizer:self.swipeDown];
    keyBoardIsUp = YES;
    self.priavteTableView.scrollEnabled = NO;

}
- (void)keyboardWillHide:(NSNotification *)notification {
    self.priavteTableView.scrollEnabled = YES;
    [self.priavteTableView removeGestureRecognizer:self.swipeUp];
    [self.priavteTableView removeGestureRecognizer:self.swipeDown];
    
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    CGRect bottomViewFrame = self.bottomView.frame;
    bottomViewFrame.origin.y = self.view.frame.size.height - bottomViewFrame.size.height;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.bottomView.frame = bottomViewFrame;
    [UIView commitAnimations];
//    self.priavteTableView.frame = CGRectMake(self.priavteTableView.frame.origin.x, self.priavteTableView.frame.origin.y,self.priavteTableView.frame.size.width, self.view.frame.size.height - self.bottomView.frame.size.height);
   // self.priavteTableView.contentOffset = CGPointMake(0.0f, content_y);
    if (self.priavteTableView.contentSize.height > keyBorad_y)
    {
        self.priavteTableView.contentOffset = CGPointMake(0.0f, content_y);
    }

    keyBoardIsUp = NO;
    content_y = 10000;
}


#pragma mark - scrollview
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //NSLog(@"hahaha");
////    if (keyBoardIsUp) {
////        [self.messageTv resignFirstResponder];
////    }
//    
//}



-(void)textViewDidChange:(UITextView *)textView
{
    if (self.messageTv.text.length == 0) {
        self.placeholderLbl.text = @"小马哥好帅啊";
    }else{
        self.placeholderLbl.text = @"";
    }
}

@end
