//
//  AboutXueBanViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/9/11.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AboutXueBanViewController.h"
#import "AboutXueHeaderTableViewCell.h"
#import "AboutXueCustomTableViewCell.h"
#import "AboutXueFooterTableViewCell.h"

@interface AboutXueBanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) IBOutlet UITableView * aboutXueTableView;
@end

@implementation AboutXueBanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于学伴";
    self.view.backgroundColor = [UIColor whiteColor];
    [self registerNibCell];
    
    self.aboutXueTableView.dataSource = self;
    self.aboutXueTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)registerNibCell
{
    [self.aboutXueTableView registerNibWithClass:[AboutXueHeaderTableViewCell class]];
    [self.aboutXueTableView registerNibWithClass:[AboutXueCustomTableViewCell class]];
    [self.aboutXueTableView registerNibWithClass:[AboutXueFooterTableViewCell class]];
}

#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AboutXueHeaderTableViewCell * headerCell = [tableView dequeueReusableCellWithIdentifier:@"AboutXueHeaderTableViewCell" forIndexPath:indexPath];
        return headerCell;
    }else if (indexPath.row == 3){
        AboutXueFooterTableViewCell * footerCell = [tableView dequeueReusableCellWithIdentifier:@"AboutXueFooterTableViewCell" forIndexPath:indexPath];
        return footerCell;
    }else{
        AboutXueCustomTableViewCell * customCell = [tableView dequeueReusableCellWithIdentifier:@"AboutXueCustomTableViewCell" forIndexPath:indexPath];
        [customCell setCellType:indexPath.row];
        return customCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat custom_h ;
    if (WINWIDTH > 375) {
        custom_h = 75;
    }else if(WINWIDTH ==375){
        custom_h = 60;
    } else {
        custom_h = 50;
    }
    
    CGFloat header_h ;
    if (WINHEIGHT == 480) {
        header_h = 200;
    }else{
        header_h = 220;
    }
    
    switch (indexPath.row) {
        case 0:
            return header_h;
            break;
        case 1:case 2:
            return custom_h;
            break;
        case 3:
            return (WINHEIGHT - 2*custom_h - header_h-64);
            break;
            
        default:
            break;
    }
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.aboutXueTableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
