//
//  AppDelegate.m
//  testUIAPP
//
//  Created by qianfeng on 9/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "QFDatabase.h"
#import "Helper.h"
//#import "WiAdView.h"
@implementation AppDelegate
@synthesize window=_window;
@synthesize mDatabase,keyArray;
@synthesize movieDownArray;

- (void)dealloc
{
    [_window release];
    [mDatabase release];
    [keyArray release];
    [movieDownArray release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *array=[NSArray arrayWithContentsOfFile:[Helper databasePath:@"key.plist"]];
    
    keyArray=[[[NSMutableArray alloc] init] autorelease];
    [keyArray addObjectsFromArray:array];
    
    mDatabase=[[QFDatabase alloc] init];
    [mDatabase openDatabase];
    movieDownArray = [NSArray array];
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    MainViewController *man = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.window setRootViewController:man];
    [self.window makeKeyAndVisible];
    [man release];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
//    kSetAdUserDefaults;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
//    currentUsersLocaleczda;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [keyArray writeToFile:[Helper databasePath:@"key.plist"] atomically:YES];
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
