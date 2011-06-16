//
//  FotoKino.h
//  ilkino
//
//  Created by Emilio on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"
#import "AsyncImageView.h"


@interface FotoKino : UIViewController <UIScrollViewDelegate> {
    TBXML * tbxml;
    NSMutableArray *theUrls;    
    NSMutableArray *theData; //FINAL PARSED DATA
    IBOutlet UIScrollView *theScrollView;
    
    //image big
    UIView *hiddenView;
    AsyncImageView *bigasyncImageView;
    UIButton *closeButton;
    UIActivityIndicatorView *theLoader;
}

@property (nonatomic, retain) NSMutableArray *theUrls;
@property (nonatomic, retain) NSMutableArray *theData;
@property (nonatomic, retain) UIScrollView *theScrollView;

- (void) loadURL;
- (void) createGrid;

@end
