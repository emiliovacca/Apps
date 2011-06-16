//
//  KinoBackstage.h
//  ilkino
//
//  Created by Emilio Vacca on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"


@interface KinoBackstage : UIViewController {
    TBXML * tbxml;
    NSMutableArray *theUrls;    
    NSMutableArray *theData; //FINAL PARSED DATA
    IBOutlet UIScrollView *mainScrollView;
    UIActivityIndicatorView *theLoader;
}

@property (nonatomic, retain) NSMutableArray *theUrls;
@property (nonatomic, retain) NSMutableArray *theData;
@property (nonatomic, retain) UIScrollView *mainScrollView;

- (void) loadURL;
- (void) createScroller;

@end
