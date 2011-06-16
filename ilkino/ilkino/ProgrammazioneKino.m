//
//  ProgrammazioneKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ProgrammazioneKino.h"
#import "ProgrammazioneKinoCell.h"

@implementation ProgrammazioneKino
@synthesize theUrls;
@synthesize theData;

BOOL programmazioneCinemaLoaded;

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

- (void)loadURL {
    programmazioneCinemaLoaded = TRUE;
    // Load and parse an xml string 
    NSString *feedURLString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"USRUrlOfProgrammazioneKino"];    
	tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:feedURLString]];
    // Obtain root element
	TBXMLElement * root = tbxml.rootXMLElement;                           
	// if root element is valid
    if (root) {
        TBXMLElement * giornata = [TBXML childElementNamed:@"giornata" parentElement:root];
        theData = [[NSMutableArray alloc] init];
        while (giornata != nil) {
            NSMutableDictionary *singleData = [[NSMutableDictionary alloc] init];
           
            NSString *theDate = [TBXML valueOfAttributeNamed:@"data" forElement:giornata];
            [singleData setValue:theDate forKey:@"data"];

            NSString *theTitle = [TBXML valueOfAttributeNamed:@"title" forElement:giornata];
            [singleData setValue:theTitle forKey:@"title"];

            
            ///get letter items
            TBXMLElement * orari = [TBXML childElementNamed:@"orari" parentElement:giornata];
            if (orari) {
                TBXMLElement * dettaglio = [TBXML childElementNamed:@"dettaglio" parentElement:orari];
                NSMutableArray *featuredData = [[NSMutableArray alloc] init];
                
                while (dettaglio != nil) {
                    NSMutableDictionary *featuredItems = [[NSMutableDictionary alloc] init];
                    NSString *detailTime = [TBXML valueOfAttributeNamed:@"ora" forElement:dettaglio];
                    [featuredItems setValue:detailTime forKey:@"ora"];                        

                    NSString *detailTitle = [TBXML valueOfAttributeNamed:@"title" forElement:dettaglio];
                    [featuredItems setValue:detailTitle forKey:@"title"];                        
                    
                    [featuredData addObject:featuredItems]; 
                    [featuredItems release];
                    dettaglio = [TBXML nextSiblingNamed:@"dettaglio" searchFromElement:dettaglio];
                }
                [singleData setValue:featuredData forKey:@"orari"];
                [featuredData release];
            } 
            [theData addObject:singleData];
            // find the next sibling element named "url"
            giornata = [TBXML nextSiblingNamed:@"giornata" searchFromElement:giornata];
            [singleData release];
        }
    }
	// release resources
    [feedURLString release]; 
    ///LOAD XIB FOR DETAILED LIST  
    
    [theLoader stopAnimating];
    [theLoader removeFromSuperview];
    [theLoader release];
    theLoader = nil;
    //NSLog(@"THEDATA %@", theData);
    [self.tableView reloadData];

    
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
    if (programmazioneCinemaLoaded == FALSE) {
        theLoader= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-10, self.view.frame.size.height/2 - 10, 20, 20)];
        [self.view addSubview:theLoader];
        [theLoader startAnimating];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (programmazioneCinemaLoaded == FALSE) {
        [self loadURL];
    }
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
    return [theData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[theData objectAtIndex:section] objectForKey:@"orari"] count];    
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	// create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
	
	// create the button object
    UIFont *Futura14 = [UIFont fontWithName:@"Futura-Medium" size:14.0];        

	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor blackColor];
	headerLabel.opaque = NO;
    headerLabel.numberOfLines = 0;
    headerLabel.lineBreakMode = UILineBreakModeWordWrap;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.highlightedTextColor = [UIColor whiteColor];
	headerLabel.frame = CGRectMake(0, 0, 320, 30);
    [headerLabel setFont:Futura14];
    [Futura14 release];
    
	// If you want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
	headerLabel.text = [[theData objectAtIndex:section] objectForKey:@"data"];
    [headerLabel sizeToFit];
    headerLabel.frame = CGRectMake(0, 0, 320, headerLabel.frame.size.height);

	[customView addSubview:headerLabel];
    
    if ([[[theData objectAtIndex:section] objectForKey:@"title"] length] > 2) {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.backgroundColor = [UIColor blackColor];
        titleLabel.opaque = NO;
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.highlightedTextColor = [UIColor whiteColor];
        titleLabel.frame = CGRectMake(0, 0, 320, 30);
    
        UIFont *Futura12 = [UIFont fontWithName:@"Futura-Medium" size:12.0];        
        [titleLabel setFont:Futura12];

        titleLabel.text = [[theData objectAtIndex:section] objectForKey:@"title"];
        [titleLabel sizeToFit];
        [titleLabel setTag:8976];
        titleLabel.frame = CGRectMake(0, headerLabel.frame.origin.y+headerLabel.frame.size.height+3, 320, headerLabel.frame.size.height);
        [customView addSubview:titleLabel];
        [titleLabel release];
        [Futura12 release];
    }
    
    [headerLabel release];

	return customView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if ([[[theData objectAtIndex:section] objectForKey:@"title"] length] > 2) {
        return 40;
    } else {
        return 20;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   	static NSString *CustomCellIdentifierProgrammazione = @"CustomCellIdentifierProgrammazione";
    
	ProgrammazioneKinoCell *programmazioneKinoCell = (ProgrammazioneKinoCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifierProgrammazione];
	
	if (programmazioneKinoCell==nil) {
		NSArray *nibPrg = [[NSBundle mainBundle] loadNibNamed:@"ProgrammazioneKinoCell" owner:self options:nil];
		for (id oneObjectPrg in nibPrg)
			if ([oneObjectPrg isKindOfClass:[ProgrammazioneKinoCell class]])
				programmazioneKinoCell = (ProgrammazioneKinoCell *)oneObjectPrg;
    
        
        UIFont *Futura14 = [UIFont fontWithName:@"Futura-Medium" size:14.0];        
        programmazioneKinoCell.orarioLabel.frame=CGRectMake(5, 5, 150, 30);
        programmazioneKinoCell.orarioLabel.text = [[[[theData objectAtIndex:[indexPath row]] objectForKey:@"orari"] objectAtIndex:[indexPath row]] objectForKey:@"ora"];
        programmazioneKinoCell.orarioLabel.backgroundColor = [UIColor clearColor];
        programmazioneKinoCell.orarioLabel.textColor = [UIColor whiteColor];
        [programmazioneKinoCell.orarioLabel setFont:Futura14];
        programmazioneKinoCell.orarioLabel.numberOfLines = 0;
        programmazioneKinoCell.orarioLabel.lineBreakMode = UILineBreakModeWordWrap;
        [programmazioneKinoCell.orarioLabel sizeToFit];
        
        programmazioneKinoCell.titoloLabel.frame=CGRectMake(10+programmazioneKinoCell.orarioLabel.frame.size.width, 5, 300-programmazioneKinoCell.orarioLabel.frame.size.width, 30);
        programmazioneKinoCell.titoloLabel.text = [[[[theData objectAtIndex:[indexPath row]] objectForKey:@"orari"] objectAtIndex:[indexPath row]] objectForKey:@"title"];
        programmazioneKinoCell.titoloLabel.backgroundColor = [UIColor clearColor];
        programmazioneKinoCell.titoloLabel.textColor = [UIColor whiteColor];
        [programmazioneKinoCell.titoloLabel setFont:Futura14];
        programmazioneKinoCell.titoloLabel.numberOfLines = 0;
        programmazioneKinoCell.titoloLabel.lineBreakMode = UILineBreakModeWordWrap;
        [programmazioneKinoCell.titoloLabel sizeToFit];        
        [Futura14 release];

    }
    return programmazioneKinoCell;
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {    
    if ([[[[[theData objectAtIndex:[indexPath row]] objectForKey:@"orari"] objectAtIndex:[indexPath row]] objectForKey:@"title"] length] > 40) {
        return 50;
    } else {
        return 30;
    }
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
