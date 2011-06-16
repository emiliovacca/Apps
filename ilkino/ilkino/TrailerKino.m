//
//  TrailerKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TrailerKino.h"
#import "TrailerKinoCell.h"
#import "AsyncImageView.h"
#import "YouTubeView.h"

#define ASYNC_IMAGE_TAG 9999

@implementation TrailerKino
@synthesize theUrls;
@synthesize theData;

BOOL trailerLoaded;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadURL {
    trailerLoaded = TRUE;
    // Load and parse an xml string
    NSString *feedURLString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"USRUrlOfTrailerKino"];    
	tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:feedURLString]];
    // Obtain root element
	TBXMLElement * root = tbxml.rootXMLElement;                           
	// if root element is valid
    if (root) {
        TBXMLElement * trailer = [TBXML childElementNamed:@"trailer" parentElement:root];
        theData = [[NSMutableArray alloc] init];
        while (trailer != nil) {
            NSMutableDictionary *singleData = [[NSMutableDictionary alloc] init];
            //link to trailer
            NSString *imglink = [TBXML valueOfAttributeNamed:@"link" forElement:trailer];
            [singleData setValue:imglink forKey:@"link"];
            //title
            NSString *title = [TBXML valueOfAttributeNamed:@"title" forElement:trailer];
            [singleData setValue:title forKey:@"title"];
            //thumb image
            NSString *image = [TBXML valueOfAttributeNamed:@"image" forElement:trailer];
            [singleData setValue:image forKey:@"image"];
            //director
            NSString *director = [TBXML valueOfAttributeNamed:@"regia" forElement:trailer];
            [singleData setValue:director forKey:@"director"];
            //thumb image
            NSString *year = [TBXML valueOfAttributeNamed:@"annoenaz" forElement:trailer];
            [singleData setValue:year forKey:@"year"];
            
            [theData addObject:singleData];
            // find the next sibling element named "url"
            trailer = [TBXML nextSiblingNamed:@"trailer" searchFromElement:trailer];
            [singleData release];
        }
    }
    //NSLog(@"elenco trailers %@", theData);
	// release resources
    [feedURLString release]; 
    [theLoader stopAnimating];
    [theLoader removeFromSuperview];
    [theLoader release];
    theLoader = nil;
    [self.tableView reloadData];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainbackground.png"]];
    self.tableView.backgroundView = backgroundImage;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (trailerLoaded == FALSE) {
        theLoader= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-10, self.view.frame.size.height/2 - 10, 20, 20)];
        [self.view addSubview:theLoader];
        [theLoader startAnimating];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (trailerLoaded == FALSE) {
        [self loadURL];
    }
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [theData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	AsyncImageView *asyncImageView = nil;
	
	static NSString *CustomCellIdentifierTrailer = @"CustomCellIdentifierTrailer";
		
	TrailerKinoCell *trailercell = (TrailerKinoCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifierTrailer];
	
	if (trailercell==nil) {
		NSArray *nibTrailer = [[NSBundle mainBundle] loadNibNamed:@"TrailerKinoCell" owner:self options:nil];
		for (id oneObjectTrailer in nibTrailer)
			if ([oneObjectTrailer isKindOfClass:[TrailerKinoCell class]])
				trailercell = (TrailerKinoCell *)oneObjectTrailer;
        
        
        //TRAILER IMAGE
        CGRect frame = CGRectMake(0, 0, 100, 75);
        asyncImageView = [[[AsyncImageView alloc] initWithFrame:frame] autorelease];
        asyncImageView.backgroundColor = [UIColor clearColor];
        asyncImageView.tag = ASYNC_IMAGE_TAG;
        [trailercell.contentView addSubview:asyncImageView];
        NSURL *url = [NSURL URLWithString:[[theData objectAtIndex:[indexPath row]] objectForKey:@"image"]];
        [asyncImageView loadImageFromURL:url withImage:@"placeholder50x50.png"];
        
        //fake play button
        UIImageView *playme = [[UIImageView alloc] initWithFrame:CGRectMake(65, 40, 25, 25)];
        playme.image = [UIImage imageNamed:@"playbutton.png"];
        [playme setAlpha:0.45];
        [trailercell.contentView addSubview:playme];
        
        UIFont *Futura15 = [UIFont fontWithName:@"Futura-Medium" size:15.0];        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 4, 195, 30)];
        titleLabel.text = [[theData objectAtIndex:[indexPath row]] objectForKey:@"title"];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel setFont:Futura15];
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        [titleLabel sizeToFit];
        [trailercell.contentView addSubview:titleLabel];
        [Futura15 release];
        
        UIFont *Futura13 = [UIFont fontWithName:@"Futura-Medium" size:13.0];        
        UILabel *author = [[UILabel alloc] initWithFrame:CGRectMake(115, titleLabel.frame.origin.y+titleLabel.frame.size.height, 280, 20)];
        author.text = [[theData objectAtIndex:[indexPath row]] objectForKey:@"director"];
        author.backgroundColor = [UIColor clearColor];
        author.textColor = [UIColor whiteColor];
        [author setFont:Futura13];
        author.numberOfLines = 0;
        author.lineBreakMode = UILineBreakModeWordWrap;
        [trailercell.contentView addSubview:author];
        [Futura13 release];
        
        UIFont *Futura11 = [UIFont fontWithName:@"Futura-Medium" size:11.0];        
        UILabel *year = [[UILabel alloc] initWithFrame:CGRectMake(0, author.frame.origin.y+author.frame.size.height-2, 290, 20)];
        year.text = [[theData objectAtIndex:[indexPath row]] objectForKey:@"year"];
        year.backgroundColor = [UIColor clearColor];
        year.textColor = [UIColor lightGrayColor];
        [year setFont:Futura11];
        year.numberOfLines = 0;
        year.lineBreakMode = UILineBreakModeWordWrap;
        year.textAlignment = UITextAlignmentRight;
        [trailercell.contentView addSubview:year];
        [Futura11 release];
    }

    trailercell.selectionStyle = UITableViewCellSelectionStyleGray;    
    return trailercell;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
    /*	NewsCell *neHCell = (NewsCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
     CGFloat ncellHeight = neHCell.sottotitolo.frame.origin.y + neHCell.sottotitolo.frame.size.height+5;
     return ncellHeight;*/
	return 90.0f;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 //   NSString *videoUrl = [NSString stringWithFormat:@"http://www.youtube.com/watch?v=%@", [[theData objectAtIndex:[indexPath row]] objectForKey:@"link"]];

    NSString *videoUrl = [[theData objectAtIndex:[indexPath row]] objectForKey:@"link"];

    YouTubeView *youTubeView = [[YouTubeView alloc] initWithNibName:@"YouTubeView" bundle:nil];
    youTubeView.completeURL = videoUrl;
    
    [self.navigationController pushViewController: youTubeView animated:YES];

    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
