//
//  YouTubeView.h
//  ilkino
//
//  Created by Emilio Vacca on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YouTubeView : UIViewController <UIWebViewDelegate>{
    IBOutlet UIActivityIndicatorView *activityIndicator;    
    IBOutlet UIWebView *theWebView;
    NSString *completeURL;
}

@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIWebView *theWebView;
@property (nonatomic, retain) NSString *completeURL;

@end
