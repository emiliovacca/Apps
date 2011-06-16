//
//  KinoBackstage.m
//  ilkino
//
//  Created by Emilio Vacca on 5/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KinoBackstage.h"
#import "AsyncImageView.h"

#define ASYNC_IMAGE_TAG 9999

@implementation KinoBackstage
@synthesize theUrls;
@synthesize theData;
@synthesize mainScrollView;

BOOL backstageLoaded;

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
    [theUrls release];
    [theData release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadURL {
    backstageLoaded = TRUE;
    // Load and parse an xml string
    NSString *feedURLString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"USRUrlOfBackstage"];    
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
           // NSLog(@"image: %@", imglink);
            
            [singleData setValue:imglink forKey:@"link"];
            
            NSString *txtval = [TBXML valueOfAttributeNamed:@"txt" forElement:image];
            [singleData setValue:txtval forKey:@"txtval"];
            [theData addObject:singleData];
            // find the next sibling element named "url"
            image = [TBXML nextSiblingNamed:@"image" searchFromElement:image];
            [singleData release];
        }
    }
    //NSLog(@"elenco url %@", theData);
	// release resources
	//[tbxml release];
    //[feedURLString release];   
    
    [self createScroller];
}

- (void) createScroller {
  //  UIView *backstagePhoto = [[UIView alloc] initWithFrame:CGRectMake(130, mainScrollView.frame.size.height/2 - 150, 60, 60)];
    float theSize = 150;
    float theWidth = 130;
    for (int bs=0; bs<[theData count]; bs++) {
        AsyncImageView *asyncImageView = nil;
        CGRect frame = CGRectMake(0+(theSize+10)*bs, 20, theSize, theSize);
        asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImageView.tag = bs;

        NSDictionary *tempDict = [[NSDictionary alloc] initWithDictionary:[theData objectAtIndex:bs]];
        NSURL *url = [NSURL URLWithString:[tempDict objectForKey:@"link"]];
        [asyncImageView loadImageFromURL:url];
        [mainScrollView addSubview:asyncImageView];
        CGRect labelFrame = CGRectMake(10+(theSize+10)*bs, 180, theWidth, 700);
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:labelFrame];
        infoLabel.textColor = [UIColor whiteColor];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.textAlignment = UITextAlignmentCenter;

        infoLabel.text = [tempDict objectForKey:@"txtval"];
        UIFont *Century12 = [UIFont fontWithName:@"AppleGothic" size:12.0];        
        [infoLabel setFont:Century12];
        infoLabel.numberOfLines = 0;
        infoLabel.lineBreakMode = UILineBreakModeWordWrap;
        [infoLabel sizeToFit];
        infoLabel.frame = CGRectMake(infoLabel.frame.origin.x, infoLabel.frame.origin.y, theWidth, infoLabel.frame.size.height);
        [Century12 release];
        [mainScrollView addSubview:infoLabel];

        mainScrollView.pagingEnabled = true;
        mainScrollView.contentSize = CGSizeMake(theSize+(theSize+10)*bs, 350);
        mainScrollView.contentOffset = CGPointMake(0, 0);
    }

    [theLoader stopAnimating];
    [theLoader removeFromSuperview];
    [theLoader release];
    theLoader = nil;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    backstageLoaded = FALSE;
/*
 AsyncImageView *asyncImageView = nil;
 
 CGRect frame 
 frame.origin.x = 0;
 frame.origin.y = 0;
 frame.size.width = 100;
 frame.size.height = 100;
 asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
 asyncImageView.tag = ASYNC_IMAGE_TAG;
 [backStageCell.contentView addSubview:asyncImageView];
    
    NSDictionary *tempDict = [[NSDictionary alloc] initWithDictionary:[theData objectAtIndex:[indexPath row]]];
    NSURL *url = [NSURL URLWithString:[tempDict objectForKey:@"link"]];
    [asyncImageView loadImageFromURL:url];
    
    backStageCell.frame = CGRectMake(150, 5, 200, 800);
    backStageCell.theText.text = [tempDict objectForKey:@"txtval"];
    backStageCell.theText.textAlignment= UITextAlignmentLeft;
*/
    // Do any additional setup after loading the view from its nib.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (backstageLoaded == FALSE) {
        theLoader= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-10, self.view.frame.size.height/2 - 10, 20, 20)];
        [mainScrollView addSubview:theLoader];
        [theLoader startAnimating];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (backstageLoaded == FALSE) {
        [self loadURL];
    }
    [super viewDidAppear:animated];
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
