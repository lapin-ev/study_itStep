//
//  DVGAppDelegate.m
//  MyGram
//
//  Created by Dmitry Volevodz on 26.03.13.
//  Copyright (c) 2013 Dmitry Volevodz. All rights reserved.
//

#import "DVGAppDelegate.h"
#import "DVGNewsLoader.h"
#import "DVGViewController.h"

@implementation DVGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    DVGViewController *myVC = [[DVGViewController alloc] initWithNibName:@"DVGViewController" bundle:nil];
    self.viewController = [[UINavigationController alloc] initWithRootViewController:myVC];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //NSLog(@"url recieved: %@", url);
    NSString *code = [url absoluteString];
    code = [code stringByReplacingOccurrencesOfString:@"tinyinstafeedobserver:?code=" withString:@""];
    DVGNewsLoader *loader = [DVGNewsLoader newsLoader];
    [loader setCode:code];
    [loader getToken];
    
    UITableViewController *myTVC = [[DVGTableViewController alloc] init];
    self.viewController = [[UINavigationController alloc] initWithRootViewController:myTVC];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
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
