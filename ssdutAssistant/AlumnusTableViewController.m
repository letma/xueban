//
//  AlumnusTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/27.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AlumnusTableViewController.h"
#import "ContentTableViewCell.h"
#import "ContentDetailViewController.h"

@interface AlumnusTableViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIScrollViewDelegate>
{
    NSInteger page;
}
@property (nonatomic ,strong)NSUserDefaults * userDefaults;
@property (nonatomic,strong) NSMutableData * contentData;
@property (nonatomic,strong) NSMutableArray * contentArr;
@property (nonatomic,strong) UIRefreshControl * rC;
@end

@implementation AlumnusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"校园广场";
     self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    page = 1;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.contentArr = [[NSMutableArray alloc] init];
    [self.tableView registerNibWithClass:[ContentTableViewCell class]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadData];
    
    self.rC = [[UIRefreshControl alloc] init];
    self.refreshControl = self.rC;
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    [self.rC addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    
//    RTLabel * lll = [[RTLabel alloc] initWithFrame:CGRectMake(20, 200, 40, 40)];
//    NSString * sss = @"<font color=\"#f46200\">hahha <strong><i>V</i></strong></font>";
//    [lll setText:sss];
//    [self.tableView addSubview:lll];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    page = 1;
    NSString * urlStr = [NSString stringWithFormat:@"%@messages/2/1/%ld",DLUT_SOCIAL_IP,page];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSURLConnection  * connection = [NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        self.contentData = [[NSMutableData alloc] init];
    }
}
#pragma mark - NSUrlConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.contentData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.rC endRefreshing];
    NSLog(@"error%@",error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:self.contentData options:NSJSONReadingMutableContainers error:nil];

    if ([[dic objectForKey:@"status"] boolValue]) {
        self.contentArr = [dic objectForKey:@"msg"];
        [self.tableView reloadData];
    }
    NSLog(@"%@   %ld",self.contentArr,[self.contentArr count]);
    [self.rC endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.contentArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentTableViewCell" forIndexPath:indexPath];
    
    [cell.replyBtn addTarget:self action:@selector(replyDo:) forControlEvents:UIControlEventTouchUpInside];
    cell.replyBtn.tag = indexPath.row * 2;
    [cell.likeBtn addTarget:self action:@selector(likeDo:) forControlEvents:UIControlEventTouchUpInside];
    cell.likeBtn.tag = indexPath.row * 2 + 1;
    NSDictionary * dic = [self.contentArr objectAtIndex:indexPath.row];
    NSString * name = [dic objectForKey:@"SenderName"];
    NSString * imgIP = [dic objectForKey:@"SenderHeadImage"];
    NSString * studentID = [dic objectForKey:@"SenderStudentId"];
    NSString * messageID = [dic objectForKey:@"Id"];
    NSString * content = [dic objectForKey:@"Content"];
    NSString * time = [dic objectForKey:@"CreateAt"];
    NSInteger viewCount = [[dic objectForKey:@"PageView"] integerValue];
    NSInteger replyCount = [[dic objectForKey:@"ReplyCount"] integerValue];
    NSInteger likeNum = [[dic objectForKey:@"LikeNum"] integerValue];
    BOOL sex = [[dic objectForKey:@"Sex"] boolValue];
    BOOL isLike = [[dic objectForKey:@"IsLiked"] boolValue];

    
    ImageProcess * classmateImg = [[ImageProcess alloc] init];
    
    
    if ([classmateImg ifImageHaveHadWithStudentID:studentID ImageIP:imgIP]) {
        
        [cell createCellWithHeadImage:[classmateImg getImgWithStudentID:studentID] Name:name Time:time Content:content MessageID:messageID Sex:sex ViewCount:viewCount ReplyCount:replyCount LikeNum:likeNum IsLike:isLike];

        
        
    }else{
        NSString * urlStr = imgIP;
        NSURL * url = [NSURL URLWithString:urlStr];
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4.0];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage * img = [UIImage imageWithData:data];
            
        [cell createCellWithHeadImage:img Name:name Time:time Content:content MessageID:messageID Sex:sex ViewCount:viewCount ReplyCount:replyCount LikeNum:likeNum IsLike:isLike];
            //img 本地化
            ImageProcess * storgeImg = [[ImageProcess alloc]init];
            //NSLog(@"%@  %@",studentID,imgIP);
            [storgeImg storageImgWithStudentID:studentID WithImage:img WithImageIP:imgIP];
            
        }];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [self.contentArr objectAtIndex:indexPath.row];
    NSString * content = [dic objectForKey:@"Content"];
    CGFloat height = [content getHeightWithFontSize:17 Width:WINWIDTH-50];
    if (height >= 21 * 6) {
        height = 21 * 6;
    }
    return 129 + height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableViewCell * cell = (ContentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    ContentDetailViewController * viewController = [[ContentDetailViewController alloc] init];
    viewController.controllerName = cell.cellName;
    viewController.controllerHeadImg = cell.cellHeadImg;
    viewController.controllerContent = cell.cellContent;
    viewController.controllerSex = cell.cellSex;
    viewController.controllerTime = cell.cellTime;
    viewController.controllerMessageID = cell.cellMessageID;
    viewController.controllerViewCounts = cell.cellViewCounts;
    viewController.controllerReplyCounts = cell.cellReplyCounts;
    viewController.controllerLikeNum = cell.cellLikeNum;
    viewController.controllerIsLike = cell.cellIsLike;
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.y >scrollView.contentSize.height- WINHEIGHT + 64) {
        NSLog(@"hhhhh");
    
        page ++;
        NetWorking * tempNetWorking = [[NetWorking alloc] init];
        NSString * urlStr = [NSString stringWithFormat:@"%@messages/2/1/%ld",DLUT_SOCIAL_IP,page];
        
        NSArray * tempArr =[tempNetWorking synchronousGetArrWithUrl:urlStr];
        
        [self.contentArr addObjectsFromArray:tempArr];
        NSLog(@"%@",tempArr);
        
        [self.tableView reloadData];
        
    }
}
#pragma mark - Button
- (void)replyDo:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
    NSIndexPath * path = [NSIndexPath indexPathForRow:btn.tag/2 inSection:0];
    ContentTableViewCell * cell = (ContentTableViewCell *)[self.tableView cellForRowAtIndexPath:path];
    ContentDetailViewController * viewController = [[ContentDetailViewController alloc] init];
    viewController.controllerName = cell.cellName;
    viewController.controllerHeadImg = cell.cellHeadImg;
    viewController.controllerContent = cell.cellContent;
    viewController.controllerSex = cell.cellSex;
    viewController.controllerTime = cell.cellTime;
    viewController.controllerMessageID = cell.cellMessageID;
    viewController.controllerViewCounts = cell.cellViewCounts;
    viewController.controllerReplyCounts = cell.cellReplyCounts;
    viewController.controllerLikeNum = cell.cellLikeNum;
    viewController.controllerIsLike = cell.cellIsLike;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)likeDo:(UIButton *)btn
{

    NSIndexPath * path = [NSIndexPath indexPathForRow:(btn.tag - 1)/2 inSection:0];
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
}
@end
