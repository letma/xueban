//
//  TabBarViewController.m
//  ssdutAssistant
//
//  Created by OurEDA on 4/7/15.
//  Copyright (c) 2015 OurEDA. All rights reserved.
//

#import "TabBarViewController.h"
#import "ERPViewController.h"
#import "DiscoveryViewController.h"
#import "MineViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"学伴";
 
   // [[UITabBar appearance] setBarTintColor:[UIColor redColor]];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    self.tabBar.tintColor = UIColorFromRGB(0x00bad1);
    
    ERPViewController * erpViewController = [[ERPViewController alloc]init];
    
    DiscoveryViewController * discoveryViewController = [[DiscoveryViewController alloc]init];
    
    MineViewController * mineViewController = [[MineViewController alloc]init];
    
    NSArray * viewControllers = @[
                                  erpViewController,
                                  discoveryViewController,
                                  mineViewController];
    
    NSArray * selectImg = @[
                            @"tab_icon_edu_selected",
                            @"tab_icon_discovery_selected",
                            @"tab_icon_mine_selected"];
    
    NSArray * normalImg = @[
                            @"tab_icon_edu_normal",
                            @"tab_icon_discovery_normal",
                            @"tab_icon_mine_normal"];
    
    NSArray * tabbarName = @[@"教务",@"发现",@"我的"];
    
   
    
    for (int i = 0; i < 3 ; i ++) {
        UITabBarItem * tabBarItem = [[UITabBarItem alloc]initWithTitle:[tabbarName objectAtIndex:i] image:UIIMGName([normalImg objectAtIndex:i]) selectedImage:UIIMGName([selectImg objectAtIndex:i])];
        tabBarItem.tag = i;
        [(UIViewController *)[viewControllers objectAtIndex:i] setTabBarItem:tabBarItem];
    }
    
    [self setViewControllers:viewControllers];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置tabbar的navigationbar title
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 0:
            self.title = @"学伴";
            break;
        case 1:
            self.title = @"发现";
            break;
        case 2:
            self.title = @"我的";
            break;
            
        default:
            break;
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
