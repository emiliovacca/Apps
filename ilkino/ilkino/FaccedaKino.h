//
//  FaccedaKino.h
//  ilkino
//
//  Created by Emilio Vacca on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
#import "AsyncImageView.h"


@interface FaccedaKino : UIViewController <UIScrollViewDelegate> {
    TBXML * tbxml;
    NSMutableArray *theUrls;    
    NSMutableArray *theData; //FINAL PARSED DATA
    
    //image big
    UIView *hiddenView;
    AsyncImageView *bigasyncImageView;
    UIButton *closeButton;
    IBOutlet UIScrollView *theScrollView;
    UIActivityIndicatorView *theLoader;    
}

@property (nonatomic, retain) NSMutableArray *theUrls;
@property (nonatomic, retain) NSMutableArray *theData;
@property (nonatomic, retain) UIScrollView *theScrollView;

- (void) loadURL;
- (void) createGrid;

@end
