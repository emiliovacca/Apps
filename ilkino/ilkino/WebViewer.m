//
//  WebViewer.m
//  StyleDirectory
//
//  Created by Emilio Vacca on 5/17/11.
//  Copyright 2011 net-a-porter. All rights reserved.
//

#import "WebViewer.h"


@implementation WebViewer
@synthesize activityIndicator;
@synthesize theWebView;
@synthesize completeURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [activityIndicator release];
    [theWebView release];
    [completeURL release];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [activityIndicator stopAnimating];
    self.view = webView;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [theWebView loadRequest:[NSURLRequest requestWithURL:completeURL]];
    theWebView.autoresizesSubviews = YES;
    theWebView.autoresizingMask=(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    theWebView.userInteractionEnabled = TRUE;
    theWebView.multipleTouchEnabled = TRUE;
    theWebView.scalesPageToFit = YES;

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    activityIndicator = nil;
    theWebView = nil;
    completeURL = nil;

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
