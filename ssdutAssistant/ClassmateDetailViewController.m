//
//  ClassmateDetailViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/10/24.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "ClassmateDetailViewController.h"
#import "PrivateMessageViewController.h"
#import "EmptyTableViewCell.h"
#import "HeadTableViewCell.h"
#import "AddressTableViewCell.h"
#import "ButtonTableViewCell.h"

@interface ClassmateDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView * detailTableView;
@end

@implementation ClassmateDetailViewController
@synthesize controllerName;
@synthesize controllerMajor;
@synthesize controllerHeadImg;
@synthesize controllerStudentID;
@synthesize controllerSex;
@synthesize controllerSingle;
@synthesize controllerAddress;
@synthesize controllerMessageID;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细资料";
    [self registerCells];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

-(void)registerCells
{
    [self.detailTableView registerNibWithClass:[EmptyTableViewCell class]];
    [self.detailTableView registerNibWithClass:[HeadTableViewCell class]];
    [self.detailTableView registerNibWithClass:[AddressTableViewCell class]];
    [self.detailTableView registerNibWithClass:[ButtonTableViewCell class]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
        EmptyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyTableViewCell" forIndexPath:indexPath];
        return cell;
    }else if(indexPath.row == 1){
        HeadTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HeadTableViewCell" forIndexPath:indexPath];
        [cell creatCellWithImage:controllerHeadImg Name:controllerName Department:controllerMajor StudentID:controllerStudentID Address:controllerAddress Sex:controllerSex Single:controllerSingle MessageID:controllerMessageID];
        
        return cell;
    }else if(indexPath.row == 3){
        AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
        [cell setAddress:controllerAddress];
        return cell;
    }else{
        ButtonTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ButtonTableViewCell" forIndexPath:indexPath];
        
        [cell.cellBtn addTarget:self action:@selector(cellBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.cellBtn.tag = indexPath.row;
        [cell creatCellWithIndex:indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4 || indexPath.row == 5) {
        return 20;
    }else if(indexPath.row == 1){
        return 80;
    }else{
        return 50;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - cellBtn
- (void)cellBtnClicked:(UIButton *)tempBtn
{
    if (tempBtn.tag == 6) {
        PrivateMessageViewController * viewController = [[PrivateMessageViewController alloc] init];;
        viewController.controllerName = self.controllerName;
        viewController.guestHeadImg = self.controllerHeadImg;
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        ;
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
