//
//  AlumnusTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/23.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AlumnusTableViewController.h"


@interface AlumnusTableViewController ()

@property (nonatomic) UIRefreshControl * rC;
@end

@implementation AlumnusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.title = @"校园广场";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.rC = [[UIRefreshControl alloc] init];
    self.refreshControl = self.rC;
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    [self.rC addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 下拉刷新
- (void)loadData
{
    [self.rC endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
