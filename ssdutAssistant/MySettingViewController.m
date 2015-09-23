//
//  MySettingViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/9.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "MySettingViewController.h"
#import "MySettingCustomTableViewCell.h"
#import "MySettingSwitchTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "AboutUsViewController.h"
#import "AboutXueBanViewController.h"
#import "SignInViewController.h"

@interface MySettingViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)IBOutlet UITableView * settingTableView;
@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self registerNibCell];
    self.settingTableView.delegate = self;
    self.settingTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerNibCell
{
    [self.settingTableView registerNibWithClass:[EmptyTableViewCell class]];
    [self.settingTableView registerNibWithClass:[MySettingCustomTableViewCell class]];
    [self.settingTableView registerNibWithClass:[MySettingSwitchTableViewCell class]];
}


#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 10) {
        
        EmptyTableViewCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTableViewCell" forIndexPath:indexPath];
        return emptyCell;
    
    }else if (indexPath.row == 6 || indexPath.row == 7 ||indexPath.row == 9){
        
        MySettingCustomTableViewCell * customCell = [tableView dequeueReusableCellWithIdentifier:@"MySettingCustomTableViewCell" forIndexPath:indexPath];
        [customCell setCellType:indexPath.row];
        return customCell;

    }else{
        
        MySettingSwitchTableViewCell * switchCell = [tableView dequeueReusableCellWithIdentifier:@"MySettingSwitchTableViewCell" forIndexPath:indexPath];
        [switchCell setCellType:indexPath.row];
        return switchCell;
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 10) {
        
        return 20;

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 6:
        {
            AboutXueBanViewController * aboutXueController = [[AboutXueBanViewController alloc] init];
            [self.navigationController pushViewController:aboutXueController animated:YES];
        }
            break;
        case 7:
        {
            AboutUsViewController * aboutUsController = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUsController animated:YES];
        }
            break;
        case 9:
        {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"确定切换账号" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alertView show];
        }
            break;
            
        default:
            break;
    }

    [self.settingTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        SignInViewController * signInController = [[SignInViewController alloc]init];
        [self presentViewController:signInController animated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];

    }
}

@end
