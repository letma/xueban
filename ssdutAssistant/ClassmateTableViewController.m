//
//  ClassmateTableViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/23.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ClassmateTableViewController.h"
#import "HeadTableViewCell.h"
#import "ClassmateDetailViewController.h"


@interface ClassmateTableViewController ()<UIAlertViewDelegate>
{
    NSInteger page;
    //是否是第一次加载 如果是不用reload tableview
    BOOL ifFirstLoad;
}
@property (nonatomic,strong) UIRefreshControl * rC;
@property (nonatomic,strong) NSMutableArray * classmateArr;
@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic,strong) UIBarButtonItem * rightBtnItem;
@property (nonatomic,strong) UIButton * barButton;
@property (nonatomic,strong) NSString * controllerType;

@end

@implementation ClassmateTableViewController
@synthesize controllerIndex;
- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = UIColorFromRGB(0xefefef);
    switch (controllerIndex) {
        case 0:
            self.title = @"我的同学";
            self.controllerType = @"my_classmates";
            break;
        case 1:
            self.title = @"找同乡";
            self.controllerType = @"townee";
            break;
        default:
            break;
    }
    
    page = 1;
    ifFirstLoad = YES;
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    self.classmateArr = [[NSMutableArray alloc] init];
    
    [self loadData];
    
    [self.tableView registerNibWithClass:[HeadTableViewCell class]];
    [self.tableView registerNibWithClass:[NothingTableViewCell class]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    self.rC = [[UIRefreshControl alloc] init];
    self.refreshControl = self.rC;
    self.rC.tintColor = UIColorFromRGB(0x00a4e9);
    self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"下拉换一批"];
    [self.rC addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    

    self.barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.barButton.frame = CGRectMake(0, 0, 24, 24);
    [self.barButton addTarget:self action:@selector(barBtnSelected) forControlEvents:UIControlEventTouchUpInside];
    self.rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.barButton];

    NSString * type = [[self.userDefaults objectForKey:MySexuality_Key] objectAtIndex:controllerIndex];
    if ([type isEqual:@"all"]) {
        [self.barButton setImage:UIIMGName(@"discovery_icon_change_sex") forState:UIControlStateNormal];
        
    }else if ([type isEqual:@"boy"]){
        [self.barButton setImage:UIIMGName(@"discovery_icon_sex_boy") forState:UIControlStateNormal];
    }else{
        [self.barButton setImage:UIIMGName(@"discovery_icon_sex_girl") forState:UIControlStateNormal];;
    }
    
    self.navigationItem.rightBarButtonItem = self.rightBtnItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - BarBtn
- (void)barBtnSelected
{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"筛选条件 ≖‿≖✧" message:nil delegate:self cancelButtonTitle:@"全部" otherButtonTitles:@"只看男生",@"只看女生", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString * imgStr;
    page = 1;
    NSMutableArray * sexArr = [[NSMutableArray alloc] initWithArray:[self.userDefaults objectForKey:MySexuality_Key]];;
    switch (buttonIndex) {
        case 0:
            imgStr = @"discovery_icon_change_sex";
            [sexArr replaceObjectAtIndex:controllerIndex withObject:@"all"];

            break;
        case 1:
            imgStr = @"discovery_icon_sex_boy";
            [sexArr replaceObjectAtIndex:controllerIndex withObject:@"boy"];

            break;
        case 2:
            imgStr = @"discovery_icon_sex_girl";
            [sexArr replaceObjectAtIndex:controllerIndex withObject:@"girl"];
            break;
            
        default:
            break;
    }
    [self.barButton setImage:UIIMGName(imgStr) forState:UIControlStateNormal];
    [self.userDefaults setObject:sexArr forKey:MySexuality_Key];
    [self.userDefaults synchronize];
    self.tableView.contentOffset = CGPointMake(0, 0);
    [self loadData];
}


#pragma mark - 下拉刷新
- (void)loadData
{
    if ([self.rC isRefreshing]) {
        self.rC.attributedTitle = [[NSAttributedString alloc] initWithString: @"加载中"];
    }
    
    NSString * type = [[self.userDefaults objectForKey:MySexuality_Key] objectAtIndex:controllerIndex];

    NSString * urlStr = [NSString stringWithFormat:@"%@%@/%@/%ld",DLUT_SOCIAL_IP,self.controllerType,type,page];
    NSLog(@"%@",urlStr);
    NSURL * url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:4];
  [request setValue:[self.userDefaults objectForKey:LoginToken_Str] forHTTPHeaderField:@"Token"];
    NSData * classmatesData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary * dic;
    if (classmatesData) {
        dic = [NSJSONSerialization JSONObjectWithData:classmatesData options:NSJSONReadingMutableContainers error:nil];
    }

    if ([dic objectForKey:@"status"]) {
        if ([[dic objectForKey:@"msg"] count] != 0) {
            self.classmateArr = [dic objectForKey:@"msg"];
            if (!ifFirstLoad) {
                [self.tableView reloadData];
            }
            ifFirstLoad = NO;
            page ++;
        }
    }
    
    if ([self.rC isRefreshing]) {
        [self.rC endRefreshing];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (([self.classmateArr count] == 0) && ifFirstLoad) {
        return 1;
    }else{
        return [self.classmateArr count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (([self.classmateArr count] == 0) && ifFirstLoad) {
        return WINHEIGHT - 64 ;
    }else{
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (([self.classmateArr count] == 0) && ifFirstLoad) {
        
        NothingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NothingTableViewCell" forIndexPath:indexPath];

        return cell;
    }else{
        HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell" forIndexPath:indexPath];
        NSDictionary * dic = [self.classmateArr objectAtIndex:indexPath.row];
        NSString * name = [dic objectForKey:@"Name"];
        NSString * major = [dic objectForKey:@"Major"];
        NSString * studentID = [dic objectForKey:@"StudentId"];
        NSString * imgIP = [dic objectForKey:@"HeadImage"];
        NSString * address = [dic objectForKeyedSubscript:@"Address"];
        NSInteger messageID = [[dic objectForKey:@"Id"] integerValue];
        NSInteger single = [[dic objectForKey:@"Single"] integerValue];
        BOOL sex = [[dic objectForKey:@"Sex"] boolValue];
       // NSLog(@"bool : %@",[dic objectForKey:@"Sex"]);
        
        ImageProcess * classmateImg = [[ImageProcess alloc] init];

        
        if ([classmateImg ifImageHaveHadWithStudentID:studentID ImageIP:imgIP]) {
            
            [cell creatCellWithImage:[classmateImg getImgWithStudentID:studentID] Name:name Department:major StudentID:studentID Address:address Sex:sex Single:single MessageID:messageID];

            
        }else{
            NSString * urlStr = imgIP;
            NSURL * url = [NSURL URLWithString:urlStr];
            NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4.0];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                UIImage * img = [UIImage imageWithData:data];
                
                [cell creatCellWithImage:img Name:name Department:major StudentID:studentID Address:address Sex:sex Single:single MessageID:messageID];
                //img 本地化
                ImageProcess * storgeImg = [[ImageProcess alloc]init];
                NSLog(@"%@  %@",studentID,imgIP);
                [storgeImg storageImgWithStudentID:studentID WithImage:img WithImageIP:imgIP];
                
            }];

        }
        
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.classmateArr count] != 0 )  {
        HeadTableViewCell * cell = (HeadTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        ClassmateDetailViewController * viewController = [[ClassmateDetailViewController alloc] init];
        viewController.controllerName = cell.cellName;
        viewController.controllerMajor = cell.cellMajor;
        viewController.controllerHeadImg = cell.cellHeadImg;
        viewController.controllerStudentID = cell.cellStudentID;
        viewController.controllerMessageID = cell.cellMessageID;
        viewController.controllerSex = cell.cellSex;
        viewController.controllerAddress = cell.cellAddress;
        viewController.controllerSingle = cell.cellSingle;
        [self.navigationController pushViewController:viewController animated:YES];
        //[tableView cellForRowAtIndexPath:indexPath.row]
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    ifFirstLoad = NO;
}
@end
