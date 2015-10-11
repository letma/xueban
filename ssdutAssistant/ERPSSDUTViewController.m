//
//  ERPSSDUTViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPSSDUTViewController.h"
#import "SSDUTNewsCell.h"
#import "SSDUTNewsWebViewController.h"
#import "TestViewController.h"

@interface ERPSSDUTViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger page;
}
@property (nonatomic) NSMutableArray * newsArr;
@property (nonatomic) NSMutableArray * IDArr;

@property (nonatomic) NetWorking * newsNetWorking;
@property (nonatomic) IBOutlet UITableView * NewsTableView;
@end

@implementation ERPSSDUTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"学生周知";
    
    page = 1;
    
    self.newsArr = [[NSMutableArray alloc] init];
    self.IDArr = [[NSMutableArray alloc] init];
    
    self.newsNetWorking = [[NetWorking alloc] init];
    
    NSString * urlStr = [NSString stringWithFormat:@"%@list/0/%ld",DLUT_SSDUTNEWS_IP,page];
    
    self.newsArr = [self.newsNetWorking synchronousGetContentWithUrl:urlStr];
    

    [self.NewsTableView registerNibWithClass:[SSDUTNewsCell class]];
    
    self.NewsTableView.delegate = self;
    self.NewsTableView.dataSource = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsArr count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SSDUTNewsCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"SSDUTNewsCell" forIndexPath:indexPath];
    JsonAnalysisTool * tools = [[JsonAnalysisTool alloc] init];
    [tools getSSDutNewsContentWith:self.newsArr Index:indexPath.row];
    [cell setCellWithTitle:tools.titleStr Time:tools.timeStr ClickCount:tools.clickCountStr];

    [self.IDArr addObject:tools.articalIDStr];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SSDUTNewsWebViewController * webView = [[SSDUTNewsWebViewController alloc] init];
    webView.articalID = [NSString stringWithFormat:@"%@",[self.IDArr objectAtIndex:indexPath.row]];
    //[self.navigationController pushViewController:webView animated:YES];

    [webView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:webView animated:YES completion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
