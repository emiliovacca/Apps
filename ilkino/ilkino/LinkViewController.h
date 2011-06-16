//
//  LinkViewController.h
//  01Distribution
//
//  Created by emilio on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LinkViewController : UIViewController {
	NSString *link;
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
 