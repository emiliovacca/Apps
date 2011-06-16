//
//  FotoKino.m
//  ilkino
//
//  Created by Emilio on 18/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FotoKino.h"
#import "AsyncImageView.h"

#define ASYNC_IMAGE_TAG 9999


@implementation FotoKino
@synthesize theUrls;
@synthesize theData;
@synthesize theScrollView;

BOOL fotoLoaded;

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
    fotoLoaded = TRUE;
    // Load and parse an xml string
    NSString *feedURLString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"USRUrlOfFotoKino"];    
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
            //NSString *theName = [TBXML valueOfAttributeNamed:@"name" forElement:image];
            //[singleData setValue:theName forKey:@"name"];
            
            [theData addObject:singleData];
            // find the next sibling element named "url"
            image = [TBXML nextSiblingNamed:@"image" searchFromElement:image];
            [singleData release];
        }
    }
    //NSLog(@"elenco url %@", theData);
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
    if (fotoLoaded == FALSE) {
        [self loadURL];
    }
    [super viewDidAppear:animated];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (fotoLoaded == FALSE) {
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
        frame = CGRectMake(xPos, theRow, 100, 100);
        asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImageView.backgroundColor = [UIColor clearColor];
        asyncImageView.tag = ASYNC_IMAGE_TAG+f;
        [self.theScrollView addSubview:asyncImageView];
        NSString *urlcomplete = [NSString stringWithFormat:@"%@-150x150.jpg", [[theData objectAtIndex:f] objectForKey:@"link"]];

        NSURL *url = [NSURL URLWithString:urlcomplete];
        [asyncImageView loadImageFromURL:url withImage:@"placeholder100x100.png"];
        UIButton *imageButton = [[UIButton alloc] initWithFrame:frame];
        [imageButton setImage:[UIImage imageNamed:@"placeholder100x100.png"] forState:UIControlStateNormal];
        [imageButton setTag:f];
        [imageButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
        [self.theScrollView addSubview:imageButton];
        [imageButton release];
        xPos = xPos + 100;
        if (xPos > 280) {
            xPos = 10;
            theRow +=100;
        }
        theScrollView.contentSize = CGSizeMake(320, theRow+10);
    }
    [theLoader stopAnimating];
    [theLoader removeFromSuperview];
    [theLoader release];
    theLoader = nil;
}


-(IBAction)showImage:(id)sender {
	UIButton *button = (UIButton *)sender;
    hiddenView = [[UIView alloc] initWithFrame:self.view.frame];
    hiddenView.backgroundColor = [UIColor darkGrayColor];
    [hiddenView setAlpha:0.5];
    [self.view addSubview:hiddenView];
    bigasyncImageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(10, self.view.frame.size.height/2 - 100, 300, 200)];
    int theIndex = button.tag;
    bigasyncImageView.userInteractionEnabled = YES;
    bigasyncImageView.multipleTouchEnabled = YES;
    NSString *theBigUrl = [NSString stringWithFormat:@"%@.jpg", [[theData objectAtIndex:theIndex] objectForKey:@"link"]];
    NSURL *bigurl = [NSURL URLWithString:theBigUrl];
    [self.view addSubview:bigasyncImageView];
    [bigasyncImageView loadImageFromURL:bigurl withImage:@"placeholder300x200.png"];    
    [bigasyncImageView release];

    closeButton = [[UIButton alloc] initWithFrame:self.view.frame];
    [closeButton setImage:[UIImage imageNamed:@"placeholder300x200.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton release];
}
-(IBAction)closeImage:(id)sender {
    [bigasyncImageView removeFromSuperview];

    [closeButton removeFromSuperview];
    
    [hiddenView removeFromSuperview];
}

@end
