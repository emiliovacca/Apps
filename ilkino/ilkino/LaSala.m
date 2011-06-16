//
//  LaSala.m
//  ilkino
//
//  Created by Emilio Vacca on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LaSala.h"


@implementation LaSala
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
    [self loadSala];
    // Do any additional setup after loading the view from its nib.
}

- (void) loadSala {
    
    UIImageView *titoloImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 40)];
    titoloImage.image = [UIImage imageNamed:@"lasalatitolo.png"];
    [mainScrollView addSubview:titoloImage];
    [titoloImage release];

    
    /*UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 290, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
                           
    titleLabel.text = @"Dotazione tecnica";
    UIFont *AppleGothic18 = [UIFont fontWithName:@"AppleGothic" size:18.0];        
    [titleLabel setFont:AppleGothic18];
    titleLabel.numberOfLines = 1;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    [AppleGothic18 release];
    [mainScrollView addSubview:titleLabel];
    [titleLabel release];*/
    
    //theImage
    UIImageView *laSalaImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, titoloImage.frame.origin.y+titoloImage.frame.size.height+20, 300, 200)];
    laSalaImage.image = [UIImage imageNamed:@"sala.jpg"];
    [mainScrollView addSubview:laSalaImage];
    [laSalaImage release];
    
    UIImageView *testoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, laSalaImage.frame.origin.y+laSalaImage.frame.size.height+10, 300, 380)];
    testoImage.image = [UIImage imageNamed:@"lasalatesto.png"];
    [mainScrollView addSubview:testoImage];
    [testoImage release];

    
    //the text
   /* UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, laSalaImage.frame.origin.y+laSalaImage.frame.size.height+10, 300, 30)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = UITextAlignmentLeft;
    
    textLabel.text = @"La sala cinematografica del Kino ha 36 posti. \nLa proiezione è in digitale, con videoproiettore ad alto contrasto FullHD Sim2 C4Pro.\nLa qualità del suono è garantita da un impianto audio Bose Professional 5.1 dolby/dts.\n Nella sala superiore, nello spazio bistrot, è presente un altro videoproiettore utilizzabile per conferenze e incontri.\n La sala bistrot può contenere fino a 30 persone disposte attorno ai tavoli, 50 disponendo le sedie a file (corsi, conferenze, incontri)";
    UIFont *AppleGothic14 = [UIFont fontWithName:@"AppleGothic" size:16.0];        
    [textLabel setFont:AppleGothic14];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel sizeToFit];
    [AppleGothic14 release];
    [mainScrollView addSubview:textLabel];*/
    mainScrollView.contentSize = CGSizeMake(320, testoImage.frame.origin.y+testoImage.frame.size.height+10);
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
