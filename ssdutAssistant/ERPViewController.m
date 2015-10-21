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

@property(nonatomic,strong) NSUserDefaults * userDefaults;

@end

@implementation ERPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"学伴";
    
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
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
    [self.mainTableView registerNibWithClass:[ERPCommonTableViewCell class]];
}

#pragma mark - TableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        ERPCommonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ERPCommonTableViewCell" forIndexPath:indexPath];
    [cell setCellType:indexPath.row];
    
    [cell.leftBtn addTarget:self action:@selector(leftBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.rightBtn addTarget:self action:@selector(rightBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.courseListBtn addTarget:self action:@selector(pushToCourse) forControlEvents:UIControlEventTouchUpInside];
    
//
//        [cell.libraryBtn addTarget:self action:@selector(pushToLibrary) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
   
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (WINHEIGHT == 480) {
        return (WINHEIGHT - 49 - 64)/3.0 ;
    }else{
        return (WINHEIGHT - 49 - 64)/4.0 ;
    }

}

#pragma mark - UIButton
- (void)leftBtnSelected:(UIButton *)button
{
    
    if ([self.userDefaults boolForKey:IF_Login]) {
        NSString * viewControllerStr;
        
        switch (button.tag) {
            case 0:
            {
                ERPSSDUTTableViewController * viewController = [[ERPSSDUTTableViewController alloc] init];
                viewController.NewsIndex = 0;
                [self.navigationController pushViewController:viewController animated:YES];

                break;
            }
        
            case 2:
                viewControllerStr = @"ERPExamTableViewController";
                break;
                
            case 4:
            {

                ERPSSDUTTableViewController * viewController = [[ERPSSDUTTableViewController alloc] init];
                viewController.NewsIndex = 1;
                [self.navigationController pushViewController:viewController animated:YES];

            }
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
}

- (void)rightBtnSelected:(UIButton *)button
{
    if ([self.userDefaults boolForKey:IF_Login]) {
        
        NSString * viewControllerStr;
        
        switch (button.tag) {
            case 1:
            {
                ERPSSDUTTableViewController * viewController = [[ERPSSDUTTableViewController alloc] init];
                viewController.NewsIndex = 2;
                [self.navigationController pushViewController:viewController animated:YES];

            }
                break;
            case 3:
                viewControllerStr = @"ERPScoreTableViewController";
                break;
            case 5:
            {
                ERPSSDUTTableViewController * viewController = [[ERPSSDUTTableViewController alloc] init];
                viewController.NewsIndex = 3;
                [self.navigationController pushViewController:viewController animated:YES];
                
            }
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
}


#pragma mark - 课程表 ＋ 图书馆
-(IBAction)pushToCourse:(id)sender
{

    
    if ([self.userDefaults boolForKey:IF_Login]) {
        ERPCourseViewController * viewController = [[ERPCourseViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        SignInViewController * signInController  = [[SignInViewController alloc]init];
        [self presentViewController:signInController animated:YES completion:nil];
    }

}
-(IBAction)pushToLibrary:(id)sender
{
//    ERPLibraryTableViewController * viewController = [[ERPLibraryTableViewController alloc]init];
//    [self.navigationController pushViewController:viewController animated:YES];

    if ([self.userDefaults boolForKey:IF_Login]) {
        ERPLibraryTableViewController * viewController = [[ERPLibraryTableViewController alloc]init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        SignInViewController * signInController  = [[SignInViewController alloc]init];
        [self presentViewController:signInController animated:YES completion:nil];
    }


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
