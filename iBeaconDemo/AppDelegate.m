//
//  AppDelegate.m
//  iBeaconDemo
//
//  Created by Christof Luethi on 27.03.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "AppDelegate.h"
#import "BeaconManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /* configure navigation bar color */
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:40/255.0f green:61/255.0f blue:82/255.0f alpha:1.0f]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];

    
    BeaconManager *beaconManager = [BeaconManager sharedInstance];
    [beaconManager start];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    //[[BeaconManager sharedInstance] stop];
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
   // [[BeaconManager sharedInstance] restart];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}
@end
