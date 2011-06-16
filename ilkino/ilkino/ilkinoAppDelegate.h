//
//  ilkinoAppDelegate.h
//  ilkino
//
//  Created by Emilio Vacca on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ilkinoAppDelegate : NSObject <UIApplicationDelegate> {
    NSArray *singleMenus;
    NSArray *singleIcons;    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSArray *singleMenus;
@property (nonatomic, retain) NSArray *singleIcons;

-(void) loadData;

@end
