//
//  ClassmateTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/23.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ClassmateTableViewController.h"
#import "HeadTableViewCell.h"

@interface ClassmateTableViewController ()
@property (nonatomic,strong) UIRefreshControl * rC;
@end

@implementation ClassmateTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.title = @"我的同学";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNibWithClass:[HeadTableViewCell class]];
    self.rC = [[UIRefreshControl alloc] init];
    self.refreshControl = self.rC;
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"下拉换一批"];

//    self.rC
    [self.rC addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 下拉刷新
- (void)loadData
{
    self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"加载中"];
    [self.rC endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
