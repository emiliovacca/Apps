//
//  FaccedaKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FaccedaKino.h"
#import "AsyncImageView.h"
#import "WebViewer.h"
#define ASYNC_IMAGE_TAG 9999

@implementation FaccedaKino

@synthesize theUrls;
@synthesize theData;
@synthesize theScrollView;

BOOL facceloaded;

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
    [tbxml release];
    [theUrls release];
    [theData release];
    [bigasyncImageView release];
    [closeButton release];
    [hiddenView release];
    bigasyncImageView = nil;
    closeButton = nil;
    hiddenView = nil;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Load Photos

- (void)loadURL {
    facceloaded = TRUE;
    // Load and parse an xml string
    NSString *feedURLString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"USRUrlOfFaccedakino"];    
	tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:feedURLString]];
    // Obtain root element
	TBXMLElement * root = tbxml.rootXMLElement;                           
	// if root element is valid
    if (root) {
        TBXMLElement * image = [TBXML childElementNamed:@"image" parentElement:root];
        theData = [[NSMutableArray alloc] init];
        while (image != nil) {
            NSMutableDictionary *singleData = [[NSMutableDictionary alloc] init];
            NSString *imglink = [TBXML valueOfAttributeNamed:@"link" forElement:image];
            [singleData setValue:imglink forKey:@"link"];
            
            NSString *theName = [TBXML valueOfAttributeNamed:@"name" forElement:image];
            [singleData setValue:theName forKey:@"name"];
            
            NSString *theFacebook = [TBXML valueOfAttributeNamed:@"facebook" forElement:image];
            [singleData setValue:theFacebook forKey:@"facebook"];
            [theData addObject:singleData];
            
            // find the next sibling element named "url"
            image = [TBXML nextSiblingNamed:@"image" searchFromElement:image];
            [singleData release];
        }
    }
   // NSLog(@"elenco url %@", theData);
	// release resources
    [feedURLString release];  
    [self createGrid];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    if (facceloaded == FALSE) {
        [self loadURL];
    }
    [super viewDidAppear:animated];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (facceloaded == FALSE) {
        theLoader= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-10, self.view.frame.size.height/2 - 10, 20, 20)];
        [self.theScrollView addSubview:theLoader];
        [theLoader startAnimating];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Create image grid
- (void) createGrid {
    AsyncImageView *asyncImageView = nil;
    
    int xPos = 10;
    int theRow = 10;
    CGRect frame;
    
    for (int f=0; f<[theData count]; f++) {
        frame = CGRectMake(xPos, theRow, 50, 50);
        asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImageView.backgroundColor = [UIColor clearColor];
        asyncImageView.tag = ASYNC_IMAGE_TAG+f;
        [self.theScrollView addSubview:asyncImageView];        
        NSURL *url = [NSURL URLWithString:[[theData objectAtIndex:f] objectForKey:@"link"]];
        [asyncImageView loadImageFromURL:url withImage:@"placeholder50x50.png"];
        UIButton *imageButton = [[UIButton alloc] initWithFrame:frame];
        [imageButton setImage:[UIImage imageNamed:@"placeholder50x50.png"] forState:UIControlStateNormal];
        [imageButton setTag:f];
        [imageButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.theScrollView addSubview:imageButton];
        [imageButton release];
        xPos = xPos + 50;
        if (xPos > 300) {
            xPos = 10;
            theRow +=50;
        }
        theScrollView.contentSize = CGSizeMake(320, theRow+50);
    }
    [theLoader stopAnimating];
    [theLoader removeFromSuperview];
    [theLoader release];
    theLoader = nil;
}


-(IBAction)showImage:(id)sender {
	UIButton *button = (UIButton *)sender;
    NSDictionary *tempDictFb = [[NSDictionary alloc] initWithDictionary:[theData objectAtIndex:[button tag]]];
    NSURL *urlFb = [NSURL URLWithString:[tempDictFb objectForKey:@"facebook"]];
    
    WebViewer *webViewer = [[WebViewer alloc] initWithNibName:@"WebViewer" bundle:nil];
    webViewer.completeURL = urlFb;
    
    [self.navigationController pushViewController: webViewer animated:YES];


}

@end

