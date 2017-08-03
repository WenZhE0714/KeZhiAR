//
//  AppDelegate.m
//  KeZhiAR
//
//  Created by Mr.ZhE on 2017/4/23.
//  Copyright © 2017年 Mr.ZhE. All rights reserved.
//

#import "AppDelegate.h"
#import "DirectViewController.h"
#import <easyar/engine.oc.h>

NSString * key = @"VAyUZr5OYgGlS05lU0wmsYFWYGTbZ3tfpVfkciBJs2zcOtHBxidYlEUREu3q10nWY2iLvlE1lyyRddBHMXRXsSpyoO1OjrFZw9UfKLsisLLIfg8YNbVLUY2ddOfrOL6k596SXlMPg6GHDnkBmhIMy47T9ToltVsxyifHhEBsszPfGVYE9B3ijikrKJAHcfHMzSNdFuqf";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    (void)application;
    (void)launchOptions;
    if (![easyar_Engine initialize:key]) {
        NSLog(@"Initialization Failed.");
    }
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
   // 利用NSUserDefaults实现
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"首次启动");
        DirectViewController *vc = [[DirectViewController alloc] init];
        self.window.rootViewController = vc;
    }else {
        NSLog(@"非首次启动");
        //LaunchViewController *vc = [[LaunchViewController alloc] init];
        //self.window.rootViewController = vc;
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController = mainStoryboard.instantiateInitialViewController;
    }
    
    
    return YES;
    // Override point for customization after application launch.
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    (void)application;
    [easyar_Engine onPause];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    (void)application;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    (void)application;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    (void)application;
    [easyar_Engine onResume];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    (void)application;
}


@end
