//
//  AppDelegate.m
//  CheapestMedicine
//
//  Created by ShikshaInfotech on 21/06/14.
//  Copyright (c) 2014 ShikshaInfotech. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseUrl.h"
@implementation AppDelegate

@synthesize viewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame :[[UIScreen mainScreen] bounds]];
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:40.0/255.0 green:151.0/255.0 blue:188.0/255.0 alpha:1.0],
      NSForegroundColorAttributeName,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
      NSForegroundColorAttributeName,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
      NSForegroundColorAttributeName,
      [UIFont fontWithName:@"Helvetica" size:0.0],
      NSFontAttributeName,
      nil]];

    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        self.viewController=[[MainViewController alloc] initWithNibName:@"MainViewController_iPad" bundle:nil];
        
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (IS_IPHONE_5){
            self.viewController=[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
        }
        else
            self.viewController=[[MainViewController alloc] initWithNibName:@"MainViewController_iPhone" bundle:nil];
    }

    nav=[[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    

    self.window.rootViewController=nav;
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"currency"];
    [NSUserDefaults standardUserDefaults];
    
    
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
