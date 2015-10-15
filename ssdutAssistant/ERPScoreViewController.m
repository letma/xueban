//
//  ERPScoreViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPScoreViewController.h"
#import "ERPScoreTableViewCell.h"

@interface ERPScoreViewController () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) IBOutlet UITableView * scoreTableView;
@end

@implementation ERPScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"本学期成绩";
    
    UIButton * freshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freshBtn.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc]initWithImage:UIIMGName(@"erp_icon_freshBtn") style:UIBarButtonItemStylePlain target:self action:@selector(freshDo)];
    self.navigationItem.rightBarButtonItem = barBtn;
    
    [self registerNibCells];
    self.scoreTableView.dataSource = self;
    self.scoreTableView.delegate = self;
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@",[userDefaults objectForKey:MyScore_Key]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)registerNibCells
{
    [self.scoreTableView registerNibWithClass:[ERPScoreTableViewCell class]];
}

#pragma mark - Fersh Reload TableView
-(void)freshDo
{
    
}

#pragma  mark _ UItableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}



@end
