//
//  ERPSSDUTTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/13.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPSSDUTTableViewController.h"
#import "SSDUTNewsCell.h"
#import "SSDUTNewsWebViewController.h"

@interface ERPSSDUTTableViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate,UIScrollViewDelegate,UITableViewDelegate>
{
    NSInteger page;
}
@property (nonatomic) NSMutableArray * newsArr;
@property (nonatomic) NSMutableArray * IDArr;
@property (nonatomic) UIRefreshControl * rC;
@property (nonatomic) NetWorking * newsNetWorking;
@property (nonatomic) NSMutableData * NewsData;
@end

@implementation ERPSSDUTTableViewController
@synthesize NewsIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
   // self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%ld",NewsIndex);
    switch (NewsIndex) {
        case 0:
             self.title = @"学生周知";
            break;
        case 1:
            self.title = @"校园新闻";
            break;
        case 2:
            self.title = @"活动公告";
            break;
            
        default:
            break;
    }
   
    
    page = 1;
    
    self.newsArr = [[NSMutableArray alloc] init];
    self.IDArr = [[NSMutableArray alloc] init];
    
    [self loadData];
    
    [self.tableView registerNibWithClass:[SSDUTNewsCell class]];
    [self.tableView registerNibWithClass:[NothingTableViewCell class]];
    
    self.tableView.delegate = self;
    //下拉刷新
    self.rC = [[UIRefreshControl alloc] init];
    //self.rC.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    [self.rC  addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = self.rC;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LoadData
- (void)loadData
{

    
    page = 1;
    NSString * urlStr = [NSString stringWithFormat:@"%@list/%ld/1",DLUT_NEWS_IP,NewsIndex];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4.0];
    NSURLConnection * connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    if (connection) {
        self.NewsData = [NSMutableData new];
    }
}

-(void)refreshTableView
{
    if (self.refreshControl.refreshing) {
        //self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"加载中..."];
        [self loadData];
        

    }
}
#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > 25 * 85 * page - WINHEIGHT + 64) {
        NSLog(@"hhhhh");
        //每次下拉加载都要清空idArr
        //[self.IDArr removeAllObjects];
    //    NSLog(@"%f",scrollView.contentOffset.y);
        page ++;
        NetWorking * tempNetWorking = [[NetWorking alloc] init];
        NSString * urlStr = [NSString stringWithFormat:@"%@list/%ld/%ld",DLUT_NEWS_IP,NewsIndex,page];
        
        NSArray * tempArr =[tempNetWorking synchronousGetContentWithUrl:urlStr];
//        for (NSInteger i = 0; i <  [tempArr count]; i ++) {
//            [self.newsArr addObject:[tempArr objectAtIndex:i]];
//        }
        [self.newsArr addObjectsFromArray:tempArr];
        
        [self.tableView reloadData];
        
    }
    
}


#pragma mark - NSUrlConnection
 - (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.NewsData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.rC endRefreshing];
//    NSLog(@"error!!!!:%@",error);
//    
//    UIImageView * imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150*598/445.0)];
//    imgView.center = CGPointMake(WINWIDTH/2.0, WINHEIGHT/3.0);
//    imgView.image = UIIMGName(@"logo_nothing");
//    [self.tableView addSubview:imgView];
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.newsArr = [NSJSONSerialization JSONObjectWithData:self.NewsData options:NSJSONReadingMutableContainers error:nil];
    [self.rC endRefreshing];
    //self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"下拉刷新"];
    [self.tableView reloadData];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.newsArr count] == 0) {
        return 1;
    }else{
         return [self.newsArr count] ;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([self.newsArr count] == 0) {
        NothingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NothingTableViewCell"];
        return cell;
    }else{
        SSDUTNewsCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"SSDUTNewsCell" forIndexPath:indexPath];
        JsonAnalysisTool * tools = [[JsonAnalysisTool alloc] init];
        [tools getSSDutNewsContentWith:self.newsArr Index:indexPath.row];
        [cell setCellWithTitle:tools.titleStr Time:tools.timeStr ClickCount:tools.clickCountStr];
        [self.IDArr setObject:tools.articalIDStr atIndexedSubscript:indexPath.row];
        return cell;
    }
    
    
    
    


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.newsArr count] == 0) {
        return WINHEIGHT - 64;
    }else{
        return 85;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.newsArr count] != 0)
    {
        SSDUTNewsWebViewController * webView = [[SSDUTNewsWebViewController alloc] init];
        webView.articalID = [NSString stringWithFormat:@"%@",[self.IDArr objectAtIndex:indexPath.row]];
        NSLog(@"%@",self.IDArr);
        [webView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:webView animated:YES completion:nil];
    }

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
