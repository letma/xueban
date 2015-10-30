//
//  MyDetailViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MyDetailViewController.h"
#import "MyDetaliHeadTableViewCell.h"
#import "MyDetailCustomTableViewCell.h"
#import "MyDetailLoveTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "UITableView+Register.h"
#import "SignInViewController.h"

@interface MyDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)IBOutlet UITableView * detailTableView;
@property(nonatomic,strong)MyDetailLoveTableViewCell * detailLoveCell;
@property(nonatomic) NSUserDefaults * userDefualts;
@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userDefualts = [NSUserDefaults standardUserDefaults];
    
    [self registerNibCell];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerNibCell
{
    [self.detailTableView registerNibWithClass:[MyDetaliHeadTableViewCell class]];
    [self.detailTableView registerNibWithClass:[MyDetailCustomTableViewCell class]];
     [self.detailTableView registerNibWithClass:[MyDetailLoveTableViewCell class]];
    [self.detailTableView registerNibWithClass:[EmptyTableViewCell class]];
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 11) {
        EmptyTableViewCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTableViewCell" forIndexPath:indexPath];
        return emptyCell;
        
    }else if (indexPath.row == 1){
        
        MyDetaliHeadTableViewCell * detailHeadCell = [tableView dequeueReusableCellWithIdentifier:@"MyDetaliHeadTableViewCell" forIndexPath:indexPath];
        ImageProcess * getImg = [[ImageProcess alloc]init];
        [detailHeadCell setMyHeadImage:[getImg getImgWithStudentID:[self.userDefualts objectForKey:MyStudentId_Key]]];
        return detailHeadCell;
        
    }else if (indexPath.row == 10){
        
        self.detailLoveCell = [tableView dequeueReusableCellWithIdentifier:@"MyDetailLoveTableViewCell" forIndexPath:indexPath];
        [self.detailLoveCell initLoveStatus];
        return self.detailLoveCell;
        
    }else{
        
        MyDetailCustomTableViewCell * detailCustomCell = [tableView dequeueReusableCellWithIdentifier:@"MyDetailCustomTableViewCell" forIndexPath:indexPath];
        [detailCustomCell setCellType:indexPath.row ];
        return detailCustomCell;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 11) {
        return 20;
        
    }else if (indexPath.row == 1){

        if (WINWIDTH > 375) {
            return 95;
        }else if(WINWIDTH ==375){
            return 80;
        } else {
            return 80;
        }

    }else{
        
        if (WINWIDTH > 375) {
            return 75;
        }else if(WINWIDTH ==375){
            return 60;
        } else {
            return 50;
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        UIActionSheet * sheet = [[UIActionSheet alloc] initWithTitle:@"更改头像"delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        [sheet showInView:self.view];
    }
    
    if(indexPath.row == 10)
    {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请选择情感状态" message:@"" delegate:self cancelButtonTitle:@"单身" otherButtonTitles:@"恋爱中", nil];
        [alertView show];
    }
    
    [self.detailTableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.detailLoveCell setLoveStatus:0];
    }else{
        [self.detailLoveCell setLoveStatus:1];
    }
}

#pragma mark - UIActivitySheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {

    }
}


@end
