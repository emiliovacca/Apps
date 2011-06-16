//
//  WebViewer.h
//  StyleDirectory
//
//  Created by Emilio Vacca on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewer : UIViewController <UIWebViewDelegate>{
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UIWebView *theWebView;
    NSURL *completeURL;
}
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIWebView *theWebView;
@property (nonatomic, retain) NSURL *completeURL;

@end
