//
//  AppDelegate.m
//  SmoothTransitionDemo
//
//  Created by Delpan on 16/3/16.
//  Copyright (c) 2016年 Delpan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "CatalogViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CatalogViewController *rootController = [[CatalogViewController alloc] initWithStyle:UITableViewStyleGrouped];
    RootNavigationController *navigationController = [[RootNavigationController alloc] initWithRootViewController:rootController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end






























