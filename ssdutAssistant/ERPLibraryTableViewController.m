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

    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.borrowArray = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:MyBorrowMessage_Key]];
    self.searchArray = [[NSMutableArray alloc] init];
    
    HintFlag = YES;
    [self.tableView registerNibWithClass:[LibraryTableViewCell class]];
    [self.searchDisplayController.searchResultsTableView registerNibWithClass:[SearchTableViewCell class]];
//    [self.searchDisplayController.searchResultsTableView registerNibWithClass:[HintTableViewCell class]];
    
//    self.searchBar.delegate = self;
//    self.tableView.delegate = self;
//    self.searchDisplayController.delegate = self;
    self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDisplayController.searchResultsTableView.backgroundColor = UIColorFromRGB(0xefefef);
//    self.searchDisplayController.searchResultsTableView.delegate =self;
//    self.searchDisplayController.searchResultsTableView.dataSource = self;
    

    
   // NSLog(@"%@",self.borrowArray);
    
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
            self.borrowArray = [contentDic objectForKey:@"msg"];
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
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
    NSData * dddd = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSDictionary * contentDic = [NSJSONSerialization JSONObjectWithData:dddd options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"%@",contentDic);
    if ([[contentDic objectForKey:@"status"] boolValue]) {
        
        NSMutableArray * arr =[NSMutableArray arrayWithArray:[contentDic objectForKey:@"msg"]] ;
        
        self.searchArray = arr;
        NSLog(@"%@",self.searchArray);
        //NSLog(@"*************************************%ld",[[contentDic objectForKey:@"msg"] count]);
        HintFlag = NO;
        
        [self.searchDisplayController.searchResultsTableView reloadData];
        
    }
    HintFlag = YES;
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
    }else{

        if (HintFlag) {
            NSLog(@"yesyeysysysysysyssysysy");
            return 0;
        }else{
            NSLog(@"nononnonononnononononnononon");
            return [self.searchArray count];
        }
        

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

    }else{

        NSDictionary * dic = [self.searchArray objectAtIndex:indexPath.row];
        NSString * titleStr = [dic objectForKey:@"Title"];
        NSString * authorStr = [dic objectForKey:@"Author"];
        NSString * strContent = [NSString stringWithFormat:@"%@【%@】",titleStr,authorStr];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:20]};
        CGSize contentSize = [strContent boundingRectWithSize:CGSizeMake(WINWIDTH - 36, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        NSLog(@"%f",contentSize.height);
        return 98 + contentSize.height;

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
        [cell creatCellWithName:title Location:location StartTime:startTime EndTime:endTime NumStr:renewCounts BorrowStatus:0];
        
        return cell;
    }else {
        
        NSDictionary * dic = [self.searchArray objectAtIndex:indexPath.row];
        NSString * titleStr = [dic objectForKey:@"Title"];
        NSString * authorStr = [dic objectForKey:@"Author"];
        NSString * publisherStr = [dic objectForKey:@"Publisher"];
        NSString * codeStr = [dic objectForKey:@"Code"];
        NSString * totolStr = [dic objectForKey:@"Total"];
        NSString * availableaStr = [dic objectForKey:@"Available"];
        
        NSString * title = [NSString stringWithFormat:@"%@【%@】",titleStr,authorStr];
        NSString * publish = [NSString stringWithFormat:@"%@ / %@",publisherStr,codeStr];
        NSString * num = [NSString stringWithFormat:@"共%@本 / 可借%@本",totolStr,availableaStr];
        SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
        [cell creatCellWithTitle:title Publish:publish Num:num];
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
    if ([searchText isEqual:@""]) {
        //[self.searchArray removeAllObjects];;
    }
     //[self connectToSearchInfo:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //[self.searchDisplayController.searchResultsTableView reloadData];
    [self connectToSearchInfo:searchBar.text];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //[self.searchArray removeAllObjects];
}

@end
