//
//  MyFilesViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyFilesViewController.h"
#import "MyFileFolderTableViewCell.h"
#import "PreviewViewController.h"

@interface MyFilesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView * FileTableView;
@property (nonatomic) NSMutableArray * fileArr;
@property (nonatomic) NSUserDefaults * userDefaults;
@end

@implementation MyFilesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的文件";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self registerNibCell];
    self.FileTableView.delegate = self;
    self.FileTableView.dataSource = self;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [self.userDefaults objectForKey:FilesList_Key];
    NSString * studentID = [self.userDefaults objectForKey:MyStudentId_Key];
    self.fileArr = [[NSMutableArray alloc] initWithArray:[dic objectForKey:studentID]];
    NSLog(@"%@",self.fileArr );
    
    
    
    
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
    return [self.fileArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * fileName = [self.fileArr objectAtIndex:indexPath.row];
    MyFileFolderTableViewCell * fileFolderCell = [tableView dequeueReusableCellWithIdentifier:@"MyFileFolderTableViewCell" forIndexPath:indexPath];
    [fileFolderCell setFolderTitleName:fileName];
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
    MyFileFolderTableViewCell * cell = (MyFileFolderTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray * documentPaths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentPath = [documentPaths objectAtIndex:0];
    NSString * studentFile = [documentPath stringByAppendingPathComponent:[userDefaults objectForKey:MyStudentId_Key]];
    NSString * filePath = [studentFile stringByAppendingPathComponent:cell.fileName];
    NSLog(@"--------%@",filePath);

    
    PreviewViewController * viewController  = [[PreviewViewController alloc] init];
    viewController.pathStr = filePath;
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
