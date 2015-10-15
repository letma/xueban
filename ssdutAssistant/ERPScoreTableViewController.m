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
@property (nonatomic) NSMutableArray * scoreArr;
@property (nonatomic) NSUserDefaults * userDefaults;
@end

@implementation ERPScoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = @"本学期课表";
    
    self.scoreArr = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:MyScore_Key]];
    NSLog(@"scoreArr : %@",self.scoreArr);
    
    [self.tableView registerNibWithClass:[ERPScoreTableViewCell class]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([scoreStr integerValue] >= 60) {
        statusStr = @"已通过";
    }else{
        statusStr = @"未通过";
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
