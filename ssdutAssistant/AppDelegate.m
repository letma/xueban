//
//  AppDelegate.m
//  ssdutAssistant
//
//  Created by OurEDA on 15/7/3.
//  Copyright (c) 2015年 OurEDA. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults setObject:@"OurEDA" forKey:Token_Str];
//    [userDefaults setBool:NO forKey:IF_Login];
//    [userDefaults synchronize];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    TabBarViewController * mainViewController = [[TabBarViewController alloc]init];
    
    UINavigationController * rootViewController = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    rootViewController.delegate = self;
    

    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Optima-Bold" size:20.0]}];
    
    [[UINavigationBar appearance] setBarTintColor:RGB(45, 45, 45)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    self.window.rootViewController = rootViewController;
    return YES;
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    navigationController.navigationBar.translucent = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
