//
//  ilkinoAppDelegate.m
//  ilkino
//
//  Created by Emilio Vacca on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ilkinoAppDelegate.h"

@implementation ilkinoAppDelegate

@synthesize singleMenus;
@synthesize singleIcons;

@synthesize window=_window;
@synthesize navigationController=_navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self loadData];
    // Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void) loadData {
    NSData *plistData;
    NSString *error;
    NSPropertyListFormat format;
    id plist;
    NSDictionary *theData;
    
    //LOAD TITLES
    NSString *localizedPath = [[NSBundle mainBundle] pathForResource:@"mainmenu" ofType:@"plist"];    
    plistData = [NSData dataWithContentsOfFile:localizedPath];    
    plist = [NSPropertyListSerialization propertyListFromData:plistData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
    if (!plist) {
       // NSLog(@"Error reading plist from file '%s', error = '%s'", [localizedPath UTF8String], [error UTF8String]);
        [error release];
    } else {
        theData = (NSDictionary *)plist; 
        singleMenus = [[NSArray alloc] initWithArray:[theData objectForKey:@"menu"]];
    }
    
    //LOAD ICONS
    NSData *plistDataIcons;
    NSString *errorIcons;
    NSPropertyListFormat formatIcons;
    id plistIcons;
    NSDictionary *theDataIcons;

    NSString *localizedPathIcons = [[NSBundle mainBundle] pathForResource:@"mainmenuicons" ofType:@"plist"];    
    plistDataIcons = [NSData dataWithContentsOfFile:localizedPathIcons];    
    plistIcons = [NSPropertyListSerialization propertyListFromData:plistDataIcons mutabilityOption:NSPropertyListImmutable format:&formatIcons errorDescription:&errorIcons];
    if (!plistIcons) {
       // NSLog(@"Error reading plist from file '%s', error = '%s'", [localizedPathIcons UTF8String], [errorIcons UTF8String]);
        [errorIcons release];
    } else {
        theDataIcons = (NSDictionary *)plistIcons; 
        singleIcons = [[NSArray alloc] initWithArray:[theDataIcons objectForKey:@"icons"]];
    }
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [super dealloc];
}

@end
