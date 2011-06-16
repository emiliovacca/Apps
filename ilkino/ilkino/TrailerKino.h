//
//  TrailerKino.h
//  ilkino
//
//  Created by Emilio Vacca on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
#import "AsyncImageView.h"


@interface TrailerKino : UITableViewController {
    TBXML * tbxml;
    NSMutableArray *theUrls;    
    NSMutableArray *theData; //FINAL PARSED DATA
    UIActivityIndicatorView *theLoader;
}
@property (nonatomic, retain) NSMutableArray *theUrls;
@property (nonatomic, retain) NSMutableArray *theData;

- (void) loadURL;

@end
