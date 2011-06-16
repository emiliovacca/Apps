//
//  RootViewController.h
//  ilkino
//
//  Created by Emilio Vacca on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
    NSArray *theMenu;
    NSArray *theIcons;
}

@property (nonatomic, retain) NSArray *theMenu;
@property (nonatomic, retain) NSArray *theIcons;

@end
