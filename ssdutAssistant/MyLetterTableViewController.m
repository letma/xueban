//
//  MyLetterTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/27.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyLetterTableViewController.h"
#import "HeadTableViewCell.h"
#import "PrivateMessageViewController.h"

@interface MyLetterTableViewController ()
{
    NSInteger page ;
}
@property(nonatomic ,strong)NSUserDefaults * userDefaults;
@property(nonatomic ,strong)NSMutableArray * letterListArr;
@end

@implementation MyLetterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的私信";
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.letterListArr = [[NSMutableArray alloc] init];
    page = 1;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNibWithClass:[HeadTableViewCell class]];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadData
{
    NSString * urlStr = [NSString stringWithFormat:@"%@messages/1/1/1",DLUT_SOCIAL_IP];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * messageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic;
   
    if (messageData) {
        dic = [NSJSONSerialization JSONObjectWithData:messageData options:NSJSONReadingMutableContainers error:nil];
    }
     NSLog(@"%@",dic);
    
    
    if ([[dic objectForKey:@"status"] boolValue]) {
        if ([[dic objectForKey:@"msg"] count] != 0) {
            [self.letterListArr addObjectsFromArray:[dic objectForKey:@"msg"]];
            if ([self.letterListArr count] == 20 * page) {
                page ++;
                [self loadData];
            }
        }
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.letterListArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell" forIndexPath:indexPath];
    NSDictionary * dic = [self.letterListArr objectAtIndex:indexPath.row];
    NSString * imgIP = [dic objectForKey:@"HeadImage"];
    NSString * content = [dic objectForKey:@"Content"];
    NSString * time = [dic objectForKey:@"CreateAt"];
    NSInteger student_ID = [[dic objectForKey:@"SenderStudentId"] integerValue];
    
    NSString * name;
    NSInteger messageID;
    BOOL ifReturn;
    
    if (student_ID == [[self.userDefaults objectForKey:MyStudentId_Key]integerValue]) {
        student_ID = [[dic objectForKey:@"ReceiverStudentId"] integerValue];
        name = [dic objectForKey:@"ReceiverName"];
        messageID = [[dic objectForKey:@"ReceiverId"] integerValue];
        ifReturn = YES;
    }else{
        name = [dic objectForKey:@"SenderName"];
        messageID = [[dic objectForKey:@"SenderId"] integerValue];
        ifReturn = NO;

    }
   
    NSString * studentID = [NSString stringWithFormat:@"%ld",student_ID];
    ImageProcess * classmateImg = [[ImageProcess alloc] init];
    
    if ([classmateImg ifImageHaveHadWithStudentID:studentID ImageIP:imgIP]) {
        
        [cell creatCellWithImage:[classmateImg getImgWithStudentID:studentID] Name:name Content:content StudentID:studentID Time:time MessageID:messageID IfReturn:ifReturn];
        
        
    }else{
        NSString * urlStr = imgIP;
        NSURL * url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4.0];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage * img = [UIImage imageWithData:data];
            
            [cell creatCellWithImage:img Name:name Content:content StudentID:studentID Time:time MessageID:messageID IfReturn:ifReturn];
            //img 本地化
            ImageProcess * storgeImg = [[ImageProcess alloc]init];
            NSLog(@"%@  %@",studentID,imgIP);
            [storgeImg storageImgWithStudentID:studentID WithImage:img WithImageIP:imgIP];
            
        }];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeadTableViewCell * cell = (HeadTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    PrivateMessageViewController * viewController = [[PrivateMessageViewController alloc] init];
    viewController.controllerName = cell.cellName;
    viewController.guestHeadImg = cell.cellHeadImg;
    viewController.senderID = cell.cellMessageID;
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
