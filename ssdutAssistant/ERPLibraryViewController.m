//
//  ERPLibraryViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPLibraryViewController.h"

@interface ERPLibraryViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic) IBOutlet UISearchBar * searchBar;
@property(weak,nonatomic) IBOutlet UITableView * borrowTableView;
//@property(nonatomic) UISearchDisplayController * searchDisplayCon;
@end

@implementation ERPLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    

    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图书馆";
    self.searchBar.delegate = self;
    self.borrowTableView.delegate = self;
    self.borrowTableView.dataSource = self;
    [self.searchBar sizeToFit];
   // self.searchBar.frame = CGRectMake(0, 20, 0, 0);
//    self.searchDisplayController.searchResultsDelegate = self;
//    self.searchDisplayController.searchResultsDataSource = self;
    self.searchDisplayController.searchResultsTableView.frame = self.view.frame;
//    [self.searchDisplayController setActive:NO animated:YES];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]init];
    return cell;
}
//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    searchBar.frame = CGRectMake(0, 20, 0, 0);
//}
//
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //self.searchBar.frame = CGRectMake(0, 20, 0, 0);
}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
   // self.searchBar.frame = CGRectMake(0, 20, 0, 0);
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

@end
