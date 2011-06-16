//
//  RootViewController.m
//  ilkino
//
//  Created by Emilio Vacca on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "ilkinoAppDelegate.h"
#import "Manifesto.h"
#import "ChieKino.h"
#import "KinoBackstage.h"
#import "FaccedaKino.h"
#import "FotoKino.h"
#import "FotoCinemaKino.h"
#import "LaSala.h"
#import "PartecipaKino.h"
#import "InfoKino.h"
#import "TrailerKino.h"
#import "ProgrammazioneKino.h"
#import "BistrotKino.h"
#import "DoveKino.h"
#import "SocialViewController.h"

@implementation RootViewController
@synthesize theMenu;
@synthesize theIcons;

Manifesto *manifesto;
ChieKino *chieKino;
KinoBackstage *backstage;
FaccedaKino *faccedaKino;
FotoKino *fotoKino;
FotoCinemaKino *fotoCinemaKino;
LaSala *laSala;
PartecipaKino *partecipaKino;
InfoKino *infoKino;
TrailerKino *trailerKino;
ProgrammazioneKino *programmazioneKino;
BistrotKino *bistrotKino;
DoveKino *doveKino;
SocialViewController *socialViewController;

- (void)viewDidLoad
{
    ilkinoAppDelegate *delegate = (ilkinoAppDelegate *)[[UIApplication sharedApplication] delegate];  
    theMenu = delegate.singleMenus;
    theIcons = delegate.singleIcons;
    self.tableView.backgroundColor = [UIColor clearColor];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainbackground.png"]];
    self.tableView.backgroundView = backgroundImage;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Indietro";	
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
    
    UINavigationBar *bar = [self.navigationController navigationBar];  
    [bar setTintColor:[UIColor blackColor]];
	UIImageView *myTopView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainTitle.png"]];
	[bar addSubview:myTopView];
	[myTopView release];

}

- (void)viewDidAppear:(BOOL)animated
{
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

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [theMenu count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    NSString *singleMenu = [theMenu objectAtIndex:[indexPath row]];
    UIFont *Futura24 = [UIFont fontWithName:@"Futura-Medium" size:20.0];        
    [cell.textLabel setFont:Futura24];
    cell.textLabel.text = singleMenu;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    cell.imageView.image = [UIImage imageNamed:[theIcons objectAtIndex:[indexPath row]]];
                            
    // Configure the cell.
    return cell;
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
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];	
    


    switch ([indexPath row]) {
        case 0:
            if (manifesto == nil) {
               manifesto = [[Manifesto alloc] initWithNibName:@"Manifesto" bundle:nil];
            }
            [self.navigationController pushViewController:manifesto animated:YES];
           // [manifesto release];
            break;
        case 1:
            if (chieKino == nil) {
                chieKino = [[ChieKino alloc] initWithNibName:@"ChieKino" bundle:nil];
            }
            [self.navigationController pushViewController:chieKino animated:YES];
            break;            
        case 2:
            if (backstage == nil) {
                backstage = [[KinoBackstage alloc] initWithNibName:@"KinoBackstage" bundle:nil];
            }
            [self.navigationController pushViewController:backstage animated:YES];
            break;
        case 3:
            if (faccedaKino == nil) {
                faccedaKino = [[FaccedaKino alloc] initWithNibName:@"FaccedaKino" bundle:nil];
            }
            [self.navigationController pushViewController:faccedaKino animated:YES];
            break;
        case 4:
            if (fotoKino == nil) {
                fotoKino = [[FotoKino alloc] initWithNibName:@"FotoKino" bundle:nil];
            }
            [self.navigationController pushViewController:fotoKino animated:YES];
            break; 
        case 5:
            if (fotoCinemaKino == nil) {
                fotoCinemaKino = [[FotoCinemaKino alloc] initWithNibName:@"FotoCinemaKino" bundle:nil];
            }
            [self.navigationController pushViewController:fotoCinemaKino animated:YES];
            break;  
        case 6:
            if (laSala == nil) {
                laSala = [[LaSala alloc] initWithNibName:@"LaSala" bundle:nil];
            }
            [self.navigationController pushViewController:laSala animated:YES];
            break;             
        case 7:
            if (partecipaKino == nil) {
                partecipaKino = [[PartecipaKino alloc] initWithNibName:@"PartecipaKino" bundle:nil];
            }
            [self.navigationController pushViewController:partecipaKino animated:YES];
            break;  
        case 8:
            if (infoKino == nil) {
                infoKino = [[InfoKino alloc] initWithNibName:@"InfoKino" bundle:nil];
            }
            [self.navigationController pushViewController:infoKino animated:YES];
            break;  
        case 9:
            if (trailerKino == nil) {
                trailerKino = [[TrailerKino alloc] initWithNibName:@"TrailerKino" bundle:nil];
            }
            [self.navigationController pushViewController:trailerKino animated:YES];
            break;   
        case 10:
            if (programmazioneKino == nil) {
                programmazioneKino = [[ProgrammazioneKino alloc] initWithNibName:@"ProgrammazioneKino" bundle:nil];
            }
            [self.navigationController pushViewController:programmazioneKino animated:YES];
            break;                         
        case 11:
            if (bistrotKino == nil) {
                bistrotKino = [[BistrotKino alloc] initWithNibName:@"BistrotKino" bundle:nil];
            }
            [self.navigationController pushViewController:bistrotKino animated:YES];
            break;                         
        case 12:
            if (doveKino == nil) {
                doveKino = [[DoveKino alloc] initWithNibName:@"DoveKino" bundle:nil];
            }
            [self.navigationController pushViewController:doveKino animated:YES];
            break;             
        case 13:
            if (socialViewController == nil) {
                socialViewController = [[SocialViewController alloc] initWithNibName:@"SocialViewController" bundle:nil];
            }
            [self.navigationController pushViewController:socialViewController animated:YES];
            break;             
        default:
            break;
    }
    /*
     *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
    [theMenu release];
    [manifesto release];
    [chieKino release];
    [backstage release];
    [faccedaKino release];
    [fotoKino release];
    [fotoCinemaKino release];
    [laSala release];
    [partecipaKino release];
    [infoKino release];
    [trailerKino release];
    [programmazioneKino release];
    [bistrotKino release];
    [doveKino release];
    [socialViewController release];
}

@end
