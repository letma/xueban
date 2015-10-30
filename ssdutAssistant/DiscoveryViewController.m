//
//  DiscoveryViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 4/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "DiscoveryHeader.h"
#import "UITableView+Register.h"

@interface DiscoveryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic , strong)IBOutlet UITableView * discoveryTableView;
@property(nonatomic , strong) NSUserDefaults * userDefaults;
@end

@implementation DiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [self registerNibCell];
    self.discoveryTableView.delegate = self;
    self.discoveryTableView.dataSource = self;

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- registe nib
-(void)registerNibCell
{
    [self.discoveryTableView registerNibWithClass:[EmptyTableViewCell class]];
    [self.discoveryTableView registerNibWithClass:[DiscoveryTableViewCell class]];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5 ) {
        EmptyTableViewCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTableViewCell" forIndexPath:indexPath];
        return emptyCell;
    }else{
        DiscoveryTableViewCell * discoveryCell = [tableView dequeueReusableCellWithIdentifier:@"DiscoveryTableViewCell" forIndexPath:indexPath];
        [discoveryCell setCellType:indexPath.row];
        return discoveryCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5 ) {
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.userDefaults boolForKey:IF_Login]) {
        
        NSString * viewControllerStr;
        
        switch (indexPath.row) {
            case 1:
                viewControllerStr = @"AlumnusTableViewController";
                break;
            case 3:case 4:
            {
                ClassmateTableViewController * viewController = [[ClassmateTableViewController alloc] init];
                viewController.controllerIndex = indexPath.row - 3;
                [self.navigationController pushViewController:viewController animated:YES];
                break;
            }
            case 6:
            {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"功能暂未开放" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                break;
            }
            case 7:
                viewControllerStr = @"GPACalculateViewController";
                break;
                
            default:
                break;
        }
        
        UIViewController * viewController = [[NSClassFromString(viewControllerStr) alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else{
        SignInViewController * signInController  = [[SignInViewController alloc]init];
        [self presentViewController:signInController animated:YES completion:nil];
    }
    [self.discoveryTableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
