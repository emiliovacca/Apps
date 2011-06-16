//
//  InfoKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InfoKino.h"


@implementation InfoKino
@synthesize mainScrollView;

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
    [self loadInfo];

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) loadInfo {    
    //theImage
    UIImageView *laSalaImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, -5, 300, 200)];
    laSalaImage.image = [UIImage imageNamed:@"ticket.png"];
    [mainScrollView addSubview:laSalaImage];
    [laSalaImage release];
    
    //the text
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, laSalaImage.frame.origin.y+laSalaImage.frame.size.height-20, 300, 30)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = UITextAlignmentLeft;
    
    textLabel.text = @"L’ingresso a Kino è con tessera Arci 2011.\nLa tessera Arci costa 7€, e da diritto all’ingresso gratuito in tutti i circoli Arci d’Italia. L’ ingresso in sala è di 4€.\n\nPer i tesserati “Kino K-Shot” (tessera da un anno valevole fino al 31/12, tessera da tre anni, tessera da sei anni), l’ingresso in sala è gratuito.\n\nIl Kino è chiuso il Lunedì.";
    UIFont *Futura = [UIFont fontWithName:@"Futura-Medium" size:16.0];        
    [textLabel setFont:Futura];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel sizeToFit];
    [Futura release];
    [mainScrollView addSubview:textLabel];
    mainScrollView.contentSize = CGSizeMake(320, textLabel.frame.origin.y+textLabel.frame.size.height+10);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
