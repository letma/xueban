//
//  ERPScoreTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/14.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPScoreTableViewController.h"
#import "ERPScoreTableViewCell.h"

@interface ERPScoreTableViewController ()
@property (nonatomic) NSArray * scoreArr;
@property (nonatomic) NSUserDefaults * userDefaults;
@property (nonatomic) UIRefreshControl * rC;

@end

@implementation ERPScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"我的成绩";
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.scoreArr = [[NSArray alloc] initWithArray:[self.userDefaults objectForKey:MyScore_Key]];
    NSLog(@"scoreArr : %@",self.scoreArr);
    
    [self.tableView registerNibWithClass:[ERPScoreTableViewCell class]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

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

#pragma mark - refresh
- (void)refreshTableView
{
    if (self.refreshControl.refreshing) {
        //self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"加载中..."];
        [self loadData];
    }
}

- (void)loadData
{
    NSString * scoreUrlStr = [NSString stringWithFormat:@"%@scores",DLUT_IP];
    NSURL * scoreUrl = [NSURL URLWithString:scoreUrlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:scoreUrl];
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",contentDic);
        if ([[contentDic objectForKey:@"status"] boolValue]) {
            NSArray * courseArr = [contentDic objectForKey:@"msg"];
            [self.userDefaults setObject:courseArr forKey:MyScore_Key];
            [self.userDefaults synchronize];
            self.scoreArr = courseArr;
            [self.rC endRefreshing];
            [self.tableView reloadData];
        }

    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.scoreArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * scoreDic = [[NSDictionary alloc] initWithDictionary:[self.scoreArr objectAtIndex:indexPath.row]];
    
    ERPScoreTableViewCell * scoreCell = [tableView dequeueReusableCellWithIdentifier:@"ERPScoreTableViewCell" forIndexPath:indexPath];
    
    NSString * titleStr = [scoreDic objectForKey:@"Name"];
    NSString * creditStr = [scoreDic objectForKey:@"Credit"];
    NSString * typeStr = [scoreDic objectForKey:@"Type"];
    NSString * scoreStr = [scoreDic objectForKey:@"Score"];
    NSString * statusStr;
    
    if ([scoreStr isEqual:@""]) {
        statusStr = @"暂未公布成绩";
    }else{
        if ([scoreStr integerValue] >= 60) {
            statusStr = @"已通过";
        }else{
            statusStr = @"未通过";
        }
    }
    

    
    [scoreCell insertScoreCardWithTitle:titleStr Type:typeStr Score:scoreStr Credit:creditStr Status:statusStr];
    return scoreCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (WINWIDTH > 375) {
        return 110;
    }else {
        return 100;
    }
    
}

@end
