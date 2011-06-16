//
//  YouTubeView.m
//  ilkino
//
//  Created by Emilio Vacca on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YouTubeView.h"


@implementation YouTubeView
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

- (void)awakeFromNib {
	theWebView.delegate = self;
	NSString *htmlString = [NSString stringWithFormat:[NSString stringWithContentsOfFile:[[NSBundle mainBundle]
                                                                                          pathForResource:@"YouTubeTemplate" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil], completeURL, completeURL, nil];
   // NSLog(@"htmlString %@", htmlString);
	[theWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://youtube.com"]];
}

- (UIButton *)findButtonInView:(UIView *)view {
	UIButton *button = nil;
    
	if ([view isMemberOfClass:[UIButton class]]) {
		return (UIButton *)view;
	}
    
	if (view.subviews && [view.subviews count] > 0) {
		for (UIView *subview in view.subviews) {
			button = [self findButtonInView:subview];
			if (button) return button;
		}
	}
    
	return button;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [activityIndicator startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)_webView {
	//UIButton *b = [self findButtonInView:_webView];
	//[b sendActionsForControlEvents:UIControlEventTouchUpInside];
    [activityIndicator stopAnimating];
    activityIndicator.hidden = TRUE;
}


- (void)dealloc
{
    [super dealloc];
    [activityIndicator release];
    [theWebView release];
    [completeURL release];
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
    [self awakeFromNib];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
