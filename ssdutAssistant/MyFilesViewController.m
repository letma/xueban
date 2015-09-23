//
//  MyFilesViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyFilesViewController.h"
#import "MyFileFolderTableViewCell.h"

@interface MyFilesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView * FileTableView;
@end

@implementation MyFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的文件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self registerNibCell];
    self.FileTableView.delegate = self;
    self.FileTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerNibCell
{
    [self.FileTableView registerNibWithClass:[MyFileFolderTableViewCell class]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFileFolderTableViewCell * fileFolderCell = [tableView dequeueReusableCellWithIdentifier:@"MyFileFolderTableViewCell" forIndexPath:indexPath];
    return fileFolderCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (WINWIDTH > 375) {
        return 75;
    }else if(WINWIDTH ==375){
        return 60;
    } else {
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
