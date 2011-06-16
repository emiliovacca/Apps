    //
//  LinkViewController.m
//  01Distribution
//
//  Created by emilio on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LinkViewController.h"


@implementation LinkViewController
@synthesize link;
@synthesize webView;
@synthesize activityIndicator;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/ 
- (void) viewWillAppear:(BOOL)animated {
	webView.backgroundColor = [UIColor blackColor];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)viewDidLoad {
/*  NSString* embedHTML = @"\
     <html><head>\
  <style type=\"text/css\">\
  body {\
  background-color: #000000;\
  color: white;\
  }\
  </style>\
  </head><body style=\"margin:0\">\
     <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
  width=\"%0.0f\" height=\"%0.0f\"></embed>\
     </body></html>";
  NSString* html = [NSString stringWithFormat:embedHTML, link, self.webView.frame.size.width, self.webView.frame.size.height];  
	
  [webView loadHTMLString:html baseURL:nil];  	*/
	//webView.frame = CGRectMake(0, 0, 320, 367);
	NSURL *url = [NSURL URLWithString:link];	
	
	webView.backgroundColor = [UIColor blackColor];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[webView loadRequest:request];
	url = nil;
    [super viewDidLoad];	
}

-(void) webViewDidStartLoad:(UIWebView *)webView {
	[self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
	[self.activityIndicator stopAnimating];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	link = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[link release];
	[webView release];
	[activityIndicator release];
}


@end
