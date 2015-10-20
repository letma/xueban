//
//  ERPLibraryTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/20.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ERPLibraryTableViewController.h"
#import "LibraryTableViewCell.h"
#import "SearchTableViewCell.h"
#import "HintTableViewCell.h"

@interface ERPLibraryTableViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    //判断提示的显示
    BOOL HintFlag;
}

@property (nonatomic) IBOutlet UISearchBar * searchBar;
@property (nonatomic) NSMutableArray * borrowArray;
@property (nonatomic) NSMutableArray * searchArray;
@property (nonatomic) NSUserDefaults * userDefaults ;
@property (nonatomic) UIRefreshControl * rC;
@end

@implementation ERPLibraryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图书馆";
    self.view.backgroundColor = UIColorFromRGB(0xefefef);

    HintFlag = YES;
    
    [self.tableView registerNibWithClass:[LibraryTableViewCell class]];
    [self.searchDisplayController.searchResultsTableView registerNibWithClass:[SearchTableViewCell class]];
    [self.searchDisplayController.searchResultsTableView registerNibWithClass:[HintTableViewCell class]];
    
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDisplayController.searchResultsTableView.backgroundColor = UIColorFromRGB(0xefefef);
    self.searchDisplayController.searchResultsTableView.delegate =self;
    self.searchDisplayController.searchResultsTableView.dataSource = self;
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.borrowArray = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:MyBorrowMessage_Key]];
    self.searchArray = [[NSMutableArray alloc] init];
    
    NSLog(@"%@",self.borrowArray);
    
    //调整searchbar边框
    for (UIView * v in ((UIView *)self.searchBar.subviews[0]).subviews) {
        if ([v isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [v layer].borderColor = UIColorFromRGB(0xefefef).CGColor;
            [v layer].borderWidth = 0.5;
        }
    }
    
    //下拉刷新
    self.rC = [[UIRefreshControl alloc] init];
    //self.rC.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    [self.rC  addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = self.rC;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 刷新
-(void)refreshTableView
{
    if (self.refreshControl.refreshing) {
        //self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"加载中..."];
        [self connectToBorrowInfo];
        
        
    }
}
#pragma mark - 借阅信息
- (void)connectToBorrowInfo
{

    NSString * urlStr = [NSString stringWithFormat:@"%@lib/borrow_info",DLUT_IP];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSLog(@"%@",[self.userDefaults objectForKey:LoginToken_Str]);
    [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",contentDic);
        if ([[contentDic objectForKey:@"status"] boolValue]) {
            
            NSArray * courseArr = [contentDic objectForKey:@"msg"];
            [self.userDefaults setObject:courseArr forKey:MyBorrowMessage_Key];
            [self.userDefaults synchronize];
            [self.tableView reloadData];
        }
        [self.rC endRefreshing];
        
    }];
}

#pragma mark - 搜图书
- (void)connectToSearchInfo:(NSString *)searchMes
{
    NSString * str = [NSString stringWithFormat:@"%@lib/search/%@",DLUT_IP,searchMes];
    NSString * urlStr = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        HintFlag = NO;
        NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"%@",contentDic);
        if ([[contentDic objectForKey:@"status"] boolValue]) {
            
            self.searchArray = [contentDic objectForKey:@"msg"];
            NSLog(@"%@",self.searchArray);
            [self.searchDisplayController.searchResultsTableView reloadData];
        }

        
    }];

}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView]) {
        return [self.borrowArray count];
    }else if([tableView isEqual:self.searchDisplayController.searchResultsTableView]){

        return [self.searchArray count];

    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        NSDictionary * dic = [self.borrowArray objectAtIndex:indexPath.row];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
         NSString * strContent = [dic objectForKey:@"Title"];
        
        CGSize contentSize = [strContent boundingRectWithSize:CGSizeMake(WINWIDTH - 40, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        NSLog(@"%f",contentSize.height);
        return 175 + contentSize.height;
    }else if([tableView isEqual:self.searchDisplayController.searchResultsTableView]){

        return 120;

    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        
        NSDictionary * dic = [self.borrowArray objectAtIndex:indexPath.row];
        NSString * title = [dic objectForKey:@"Title"];
        NSString * startTime = [dic objectForKey:@"TimeBorrow"];
        NSString * endTime = [dic objectForKey:@"TimeReturn"];
        NSString * renewCounts = [dic objectForKey:@"RenewCounts"];
        NSString * location = [dic objectForKey:@"Location"];
        
        LibraryTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LibraryTableViewCell"];
        [cell creatCellWithName:title Location:location StartTime:startTime EndTime:endTime NumStr:renewCounts BorrowStatus:3];
        
        return cell;
    }else if([tableView isEqual:self.searchDisplayController.searchResultsTableView]){
        
        SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
        return cell;
    }else{
        UITableView * cell ;
        return cell;
    }
    
}

#pragma mark - searchBar Delegate
-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self connectToSearchInfo:searchBar.text];
    NSLog(@"%@",searchBar.text);
}

@end
