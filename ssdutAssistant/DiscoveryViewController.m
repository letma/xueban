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

    }else{
        SignInViewController * signInController  = [[SignInViewController alloc]init];
        [self presentViewController:signInController animated:YES completion:nil];
    }
    [self.discoveryTableView deselectRowAtIndexPath:indexPath animated:YES];
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
