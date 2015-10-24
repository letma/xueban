//
//  MineViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 4/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeader.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic,strong)IBOutlet UITableView * MineTableView;
@property (nonatomic,strong) NSUserDefaults * userDefaults;
@property (nonatomic,strong) NSMutableDictionary * userDictionary;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    [self registerNibCell];
    
    self.MineTableView.delegate = self;
    self.MineTableView.dataSource = self;

//    NSArray * paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * path = [paths objectAtIndex:0];
//    
//    NSFileManager * fm = [NSFileManager defaultManager];
//    
//    NSArray * files = [fm subpathsAtPath:path];
//    
//    NSData * dddd = [NSData data];
//    
//    NSLog(@"djkajfdkajfl:%@",files);
//    NSString * fileName = [path stringByAppendingPathComponent:@"201393149"];
//    [fm createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil];
//    NSString * ggggg = [fileName stringByAppendingPathComponent:@"date"];
//    [fm createFileAtPath:ggggg contents:dddd attributes:nil];
//    NSLog(@"%@",ggggg);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.userDictionary = [self.userDefaults objectForKey:UserContent_Key] ;
    
    NSString * myName = [self.userDictionary objectForKey:@"Name"];
    if (myName) {
        
        if (![[self.userDefaults objectForKey:MyName_Key] isEqual:myName]) {
            [self.MineTableView reloadData];
        }
        
    }

}



-(void)registerNibCell
{
    [self.MineTableView registerNibWithClass:[MineTableViewCell class]];
    [self.MineTableView registerNibWithClass:[MyHeadTableViewCell class]];
    [self.MineTableView registerNibWithClass:[EmptyTableViewCell class]];
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
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 10) {
        EmptyTableViewCell * emptyCell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTableViewCell" forIndexPath:indexPath];
        return emptyCell;
    }else if (indexPath.row == 1){
        MyHeadTableViewCell * myHeadCell = [tableView dequeueReusableCellWithIdentifier:@"MyHeadTableViewCell" forIndexPath:indexPath];
        
        ImageProcess * judgeImg = [[ImageProcess alloc]init];
        NSString * studentID = [self.userDefaults objectForKey:MyStudentId_Key];
        NSString * imgIP = [self.userDictionary objectForKey:@"HeadImage"];
        //判断图片是否存在
        if ([judgeImg ifImageHaveHadWithStudentID:studentID ImageIP:imgIP]) {
            [myHeadCell setMyHeadImage:[judgeImg getImgWithStudentID:studentID] MyName:[self.userDictionary objectForKey:@"Name"]];
            [self.userDefaults setObject:[self.userDefaults objectForKey:@"Name"] forKey:MyName_Key];
        }else{
            
            NSString * urlStr = [self.userDictionary objectForKey:@"HeadImage"];
            NSURL * url = [NSURL URLWithString:urlStr];
            NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:4.0];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                UIImage * img = [UIImage imageWithData:data];
                [myHeadCell setMyHeadImage:img MyName:[self.userDictionary objectForKey:@"Name"]];
                [self.userDefaults setObject:[self.userDefaults objectForKey:@"Name"] forKey:MyName_Key];
                
                //img 本地化
                ImageProcess * storgeImg = [[ImageProcess alloc]init];
                [storgeImg storageImgWithStudentID:[self.userDefaults objectForKey:MyStudentId_Key] WithImage:img WithImageIP:[self.userDictionary objectForKey:@"HeadImage"]];
                
            }];

        }

        
        /*************************计算时间与日期********************************/
        NSDate * now = [NSDate date];
        NSCalendar * cal = [NSCalendar currentCalendar];
        NSDateComponents * comp = [cal components:NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
        NSInteger  item = [comp weekday];
        
        //将美国星期几转为中国星期几的算法 O.o
        NSInteger weekDay = ( item + 6)%7 + ((item - 8) * (-1) / 7 )*7;
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate * startDate = [dateFormatter dateFromString:@"2015-09-07 00:00:00"];
        NSTimeInterval  timeInterval = [now timeIntervalSinceDate:startDate]/(24*60*60*7);
        NSInteger week = timeInterval + 1;
        
        [myHeadCell setWeek:week WeekDay:weekDay];
        return myHeadCell;
    }else{
        MineTableViewCell * mineCell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
        [mineCell setCellType:indexPath.row];
        return mineCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5 || indexPath.row == 7|| indexPath.row == 10) {
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
    if ([self.userDefaults boolForKey:IF_Login]) {
        
        NSString * controllerName ;
        switch (indexPath.row) {
            case 1:
                controllerName = @"MyDetailViewController";
                break;
            case 3:
                controllerName = @"MyLetterViewController";
                break;
            case 4:
                controllerName = @"MyMesBoardViewController";
                break;
            case 6:
                controllerName = @"MyFilesViewController";
                break;
            case 8:
                controllerName = @"MyFeedBackViewController";
                break;
            case 9:
                controllerName = @"MySettingViewController";
                break;
                
            default:
                break;
        }
        
        UIViewController * viewController = [[NSClassFromString(controllerName) alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else{
        SignInViewController * signInController  = [[SignInViewController alloc]init];
        [self presentViewController:signInController animated:YES completion:nil];
    }
    
    [self.MineTableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)writeToPlist:(NSMutableArray *)_array
{
    
    
//    NSArray * paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString * path = [paths objectAtIndex:0];
//    
//    NSFileManager * fm = [NSFileManager defaultManager];
//
//    NSArray * files = [fm subpathsAtPath:path];
//    
//    NSLog(@"djkajfdkajfl:%@",files);
//    NSString * fileName = [path stringByAppendingPathComponent:@"201393149"];
//   // NSString * gggg = [path stringByAppendingString:@"45645"];
//    [fm createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil];
//    //[fm createDirectoryAtPath:gggg withIntermediateDirectories:YES attributes:nil error:nil];
//    NSLog(@"%@",fileName);
   // [_array writeToFile:fileName atomically:YES];
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
