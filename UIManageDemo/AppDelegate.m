//
//  AppDelegate.m
//  UIManageDemo
//
//  Created by 束 永兴 on 13-9-28.
//  Copyright (c) 2013年 Candy. All rights reserved.
//

#import "AppDelegate.h"
#import "UIManager.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSMutableArray *mArr = [NSMutableArray arrayWithObjects:@1, @3, @5, nil];
    [mArr removeAllObjects];
    NSLog(@"mArr = %@", [mArr lastObject]);
    int i = 1;
    
    switch (i) {
        case 1:
            NSLog(@"test 1");
            break;
        case 2:
            NSLog(@"test 2");
            break;
        default:
            NSLog(@"test 3333");
            break;
    }
    
    ViewController *ct = [[ViewController alloc] init];
    _navController = [[UINavigationController alloc] initWithRootViewController:ct];
    _navController.navigationBarHidden = YES;
    
    [self.window setRootViewController:_navController];
    
    [UIManager shareUIManger];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
