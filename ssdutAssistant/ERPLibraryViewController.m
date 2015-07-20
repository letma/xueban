//
//  ERPLibraryViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/4.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPLibraryViewController.h"
#import "NSTimer+Addition.h"

@interface ERPLibraryViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic) IBOutlet UISearchBar * searchBar;
@property(weak,nonatomic) IBOutlet UITableView * borrowTableView;
@property(nonatomic) UITableView * historyRecordTableView;
@property(nonatomic,strong) NSTimer * historyInitTimer;
//@property(nonatomic) UISearchDisplayController * searchDisplayCon;
@end

@implementation ERPLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

    //self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"图书馆";
    self.searchBar.delegate = self;
    self.borrowTableView.delegate = self;
    self.borrowTableView.dataSource = self;



    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //调整searchbar边框
    for (UIView * v in ((UIView *)self.searchBar.subviews[0]).subviews) {
        if ([v isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
             [v layer].borderColor = [UIColor whiteColor].CGColor;
            [v layer].borderWidth = 0.5;
        }
        
    }

    
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

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
       [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    self.historyInitTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(doFireTimer) userInfo:nil repeats:YES];

}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
         
    
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    return YES;
}

-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{

    return YES;
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.historyRecordTableView.hidden = YES;
   //self.historyRecordTableView == NULL;
}

-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
        //[NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(hiddenNo) userInfo:nil repeats:NO];
    [self performSelector:@selector(hiddenNo) withObject:self afterDelay:0.1];
}
-(void)hiddenNo
{
    self.historyRecordTableView.hidden = NO;
}

-(void)doFireTimer
{

    //self.historyRecordTableView.hidden = NO;

    if (self.historyRecordTableView == NULL) {
        for(UIView * dimmigView in self.searchDisplayController.searchResultsTableView.superview.subviews)
        {
            NSLog(@"%@",[dimmigView class]);
            
            if ([dimmigView isKindOfClass:NSClassFromString(@"_UISearchDisplayControllerDimmingView")]) {
                
                self.historyRecordTableView = [[UITableView alloc]init];
                self.historyRecordTableView.frame = self.searchDisplayController.searchResultsTableView.frame;
                self.historyRecordTableView.backgroundColor = [UIColor greenColor];
                self.historyRecordTableView.delegate = self;
                self.historyRecordTableView.dataSource = self;
                [dimmigView addSubview:self.historyRecordTableView];
                
            }
        }

    }else{
      // [self performSelector:@selector(pauseHistoryTimer) withObject:self afterDelay:0.1];

    }
  
}

-(void)pauseHistoryTimer
{
    [self.historyInitTimer pauseTimer];
}



@end
