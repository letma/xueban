//
//  ERPViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 4/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import "ERPHeader.h"
#import "ERPViewController.h"


@interface ERPViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) IBOutlet UITableView * mainTableView;

@end

@implementation ERPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"学伴";
    self.view.backgroundColor = [UIColor whiteColor];
    [self registerNibCell];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
   

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSLog(@"--------------------------");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerNibCell
{
    [self.mainTableView registerNibWithClass:[BigTableViewCell class]];
    [self.mainTableView registerNibWithClass:[SmallTableViewCell class]];
    [self.mainTableView registerNibWithClass:[EmptyTableViewCell class]];
}

#pragma mark - TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BigTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BigTableViewCell" forIndexPath:indexPath];
        
        [cell.courseListBtn addTarget:self action:@selector(pushToCourse) forControlEvents:UIControlEventTouchUpInside];
        [cell.libraryBtn addTarget:self action:@selector(pushToLibrary) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 8)
    {
        EmptyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTableViewCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        
        CGFloat height ;
        
        if (WINWIDTH > 375) {
            height = 75;
        }else if(WINWIDTH == 375){
            height = 60;
        }else{
            height = 50;
        }
        
        //根据所在的row进行设置
        SmallTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SmallTableViewCell" forIndexPath:indexPath];
        [cell setCellType:indexPath.row Height:height];
        return cell;
        
    }
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return 70+WINWIDTH/2.0-110;
            break;
        }
        case 1:case 4:case 8:
        {
            return 20;
            break;
        }
        default:
        {
            if (WINWIDTH > 375) {
                return 75;
            }else if(WINWIDTH ==375){
                return 60;
            } else {
                return 50;
            }
            
            break;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * controllerName ;
    switch (indexPath.row) {
        case 2:
            controllerName = @"ERPScoreViewController";
            break;
        case 3:
            controllerName = @"ERPExamViewController";
            break;
        case 5:
            controllerName = @"ERPDUTViewController";
            break;
        case 6:
            controllerName = @"ERPSSDUTViewController";
            break;
        case 7:
            controllerName = @"ERPNoticeViewController";
            break;
            
        default:
            break;
    }
    
    
    UIViewController * viewController = [[NSClassFromString(controllerName) alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
    
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - 课程表 ＋ 图书馆
-(void)pushToCourse
{
    ERPCourseViewController * viewController = [[ERPCourseViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)pushToLibrary
{
    ERPLibraryViewController * viewController = [[ERPLibraryViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
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
