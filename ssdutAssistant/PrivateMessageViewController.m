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

@interface PrivateMessageViewController () <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    BOOL keyBoardIsUp;
    CGFloat content_y;
    CGFloat keyBorad_y;
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
//先把头像抓到;
@property (nonatomic ,strong) UIImage * myHeadImg;
@end

@implementation PrivateMessageViewController
@synthesize controllerName;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = controllerName;
    self.view.backgroundColor = [UIColor whiteColor];
    
    keyBoardIsUp = NO;
    content_y = 10000;
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.messageArr = [[NSMutableArray alloc] init];
    
    ImageProcess * imgProcess = [[ImageProcess alloc] init];
    self.myHeadImg = [imgProcess getImgWithStudentID:[self.userDefaults objectForKey:MyStudentId_Key]];
    
    self.priavteTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINWIDTH, WINHEIGHT - 64 - 49)];
    self.priavteTableView.backgroundColor = UIColorFromRGB(0xEBEBF1);
    self.priavteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    self.sendBtn.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.sendBtn];
    
    self.messageTv = [[UITextView alloc] initWithFrame:CGRectMake(10, 10,WINWIDTH - 68,29)];
    //self.messageTv.backgroundColor = [UIColor cyanColor];
    self.messageTv.delegate  =self;
    [self.bottomView addSubview:self.messageTv];
    
    self.placeholderLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 200, 20)];
    self.placeholderLbl.text = @"小马哥好帅啊";
    self.placeholderLbl.textColor = UIColorFromRGB(0xa0a0a0);
    self.placeholderLbl.font = [UIFont systemFontOfSize:14.0];
    [self.messageTv addSubview:self.placeholderLbl];
    
    
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)loadData
{
    NSInteger i = 2;
    NSString * urlStr = [NSString stringWithFormat:@"%@messages/3/%ld/1",DLUT_SOCIAL_IP,i];
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
        self.messageArr = [dic objectForKey:@"msg"];
        NSLog(@"%@",self.messageArr);
    }

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
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ||indexPath.row == 2 ||indexPath.row == 6 ||indexPath.row == 10) {
        WhiteMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WhiteMessageTableViewCell" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.row == 4 ||indexPath.row == 8 ){
        BlueMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BlueMessageTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    else{
        EmptyTimeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTimeTableViewCell" forIndexPath:indexPath];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ||indexPath.row == 2 ||indexPath.row == 4 ||indexPath.row == 6 ||indexPath.row == 8 || indexPath.row == 10) {
        return 50;
    }else{
        return 20;
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

    if (content_y == 10000) {
        content_y = self.priavteTableView.contentOffset.y;
    }
    
    keyBorad_y = bottomViewFrame.origin.y;
    
//    CGRect tableViewFrame = self.priavteTableView.frame;
//    tableViewFrame.size.height = bottomViewFrame.origin.y - self.view.frame.origin.y;
//    self.priavteTableView .frame = tableViewFrame;
    if (self.priavteTableView.contentSize.height > keyBorad_y)
    {

        self.priavteTableView.contentOffset = CGPointMake(0, self.priavteTableView.contentSize.height- bottomViewFrame.origin.y);
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:animationDuration];
//        self.priavteTableView.frame = CGRectMake(0, bottomViewFrame.origin.y - WINHEIGHT + 49 +64, WINWIDTH, WINHEIGHT - 64 -49);
//        self.priavteTableView.contentOffset = CGPointMake(0, bottomViewFrame.origin.y - bottomViewFrame.origin.y);
//        [UIView commitAnimations];
 
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"hahaha");
//    if (keyBoardIsUp) {
//        [self.messageTv resignFirstResponder];
//    }
    
}



-(void)textViewDidChange:(UITextView *)textView
{
    if (self.messageTv.text.length == 0) {
        self.placeholderLbl.text = @"小马哥好帅啊";
    }else{
        self.placeholderLbl.text = @"";
    }
}

@end
