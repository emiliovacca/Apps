    //
//  SocialViewController.m
//  01Distribution
//
//  Created by emilio on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SocialViewController.h"
#import "TwitterCell.h"
#import "LinkViewController.h"
#import "FacebookController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

#include <dlfcn.h>
 


@implementation SocialViewController

@synthesize twitterTable;
@synthesize delegate;
@synthesize facebookSwitch;
@synthesize smsSwitch;
@synthesize facebook;
@synthesize urlData;

//XML Twitter Parser
NSXMLParser * rssParser;
NSMutableArray * stories;
NSMutableDictionary * item;
NSMutableDictionary * user;
NSString * currentElement;
NSMutableString * currentTitle;
NSMutableString * currentUser;
NSMutableString * currentDate;
NSMutableString * currentAvatar;
NSMutableString * currentLink;
NSMutableString * currentDescription;
LinkViewController *linkViewController;
MFMessageComposeViewController *picker;

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void) viewWillAppear:(BOOL)animated {
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;	
}

- (void) viewDidAppear:(BOOL)animated {
	stories = [[NSMutableArray alloc] init];
	NSURL *xmlURL = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/user_timeline/@ilkino.xml"];
	
	rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	rssParser.delegate = self;
	[rssParser parse];	
	[twitterTable reloadData];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[[self delegate] isSocial:@"YES"];
	[facebook logout:self];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


///////////////////////XML PARSER
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict{ 
	
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"status"]) {
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		user = [[NSMutableDictionary alloc] init];
		currentDescription = [[NSMutableString alloc] init];
		currentUser = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentAvatar = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if ([currentElement isEqualToString:@"title"])
		[currentTitle appendString:string];
	if ([currentElement isEqualToString:@"text"]) {
		[currentDescription appendString:string];
		//////////GET LINK IF EXISTS
		NSArray *links = [string componentsSeparatedByString: @" "];
		NSEnumerator *e = [links objectEnumerator];
		id object;
		while ((object = [e nextObject])) {
			NSString *objectString = object;
			int theLenght = [objectString length];
			if (theLenght > 6) {			
				if ([objectString rangeOfString:@"http"].location == NSNotFound) {
					[currentLink appendString:@""];
				} else {
					[currentLink appendString:objectString];
				}
			}
		}
	}
	//////////END GET LINK
	if ([currentElement isEqualToString:@"created_at"])
		[currentDate appendString:string];
	if ([currentElement isEqualToString:@"screen_name"])
		[currentUser appendString:string];	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
	namespaceURI:(NSString *)namespaceURI
	qualifiedName:(NSString *)qName{ 
	if ([elementName isEqualToString:@"status"]) {
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentDescription forKey:@"text"];
		[item setObject:currentDate forKey:@"date"];
		[item setObject:currentUser forKey:@"screen_name"];
		[item setObject:currentLink forKey:@"link"];
		[stories addObject:[item copy]];
	}	
}	
///////////////////////XML PARSER

///////////////////////SWITCH FUNCTIONS/////////////////////
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {	
	return [facebook handleOpenURL:url]; 
}

 - (IBAction) toggleEnabledForFacebook: (id) sender {  
     if (facebookSwitch.on) {
		 facebook = [[Facebook alloc] initWithAppId:@"132197693524410"];
		 //[facebook authorize:nil delegate:self];
		 NSString *apiKey;
		 apiKey = @"8c55ca34302909f252b58d542c6f8526";
		 NSString *messageDialog = @"Sto usando l'applicazione per iPhone de Il Kino. Scaricala anche tu da Apple Store. Il KiNO è un cinema, ma è un cinema diverso da tutti gli altri...";
		 NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys: apiKey, @"api_key", messageDialog, @"message", nil];		 

		[facebook dialog:@"feed" andParams:params andDelegate:self];
	 } else {
		[facebook logout:self];
	 }

 }  
   
- (IBAction) toggleEnabledForSms: (id) sender {  
	if ( dlsym(RTLD_DEFAULT, "MFMailComposeErrorDomain") != NULL ) {
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
		picker.messageComposeDelegate = self;
		picker.body = @"Sto usando l'applicazione per iPhone de Il Kino. Scaricala anche tu da Apple Store. Il KiNO è un cinema, ma è un cinema diverso da tutti gli altri...";
		
		[self presentModalViewController:picker animated:YES];
		[picker release];
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Il Kino" message:@"SMS non supportato" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
			[picker dismissModalViewControllerAnimated:YES];
			[picker.view removeFromSuperview];
			break;
		case MessageComposeResultFailed:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Il Kino" message:@"Errore sconosciuto" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			break;
		}
		case MessageComposeResultSent:
			
			break;
		default:
			break;
	}
	
	[self dismissModalViewControllerAnimated:YES];
}
///////////////////////END SWITCH FUNCTIONS/////////////////////


///////////////////////TABLE VIEW FUNCTIONS
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.   
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//il numero di righe deve corrispondere al numero di elementi della lista
	if ([stories count]==0) {
		return 0;		
	} else {
		return [stories count];
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *twitterCellIdentifier = @"TwitterCell";
	TwitterCell *twitterCell = (TwitterCell *)[tableView dequeueReusableCellWithIdentifier:twitterCellIdentifier];
	
	if (twitterCell==nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TwitterCell" owner:self options:nil];
		
		for (id oneObject in nib)
			if ([oneObject isKindOfClass:[TwitterCell class]])
				twitterCell = (TwitterCell *)oneObject;
		
	}
	
	
	NSDictionary *currentElement = [stories objectAtIndex:[indexPath row]];
	
	//********************************************************************	
	twitterCell.tweetUser.text = [currentElement objectForKey:@"screen_name"];

	NSString *string = [currentElement objectForKey:@"date"];
	NSArray *strings = [string componentsSeparatedByString: @" "];
	
	twitterCell.tweetDate.text = [NSString stringWithFormat: @"%@ %@ %@", [strings objectAtIndex:2], [strings objectAtIndex:1], [strings objectAtIndex:5]];

	NSMutableString *theText = [NSMutableString string];		
	theText = (NSMutableString *)[[currentElement objectForKey:@"text"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //cleans newLine

	
	twitterCell.tweetText.text = theText;
	twitterCell.tweetText.frame = CGRectMake(10, 20, 270, 800);
	[twitterCell.tweetText sizeToFit];
	
	twitterCell.tweetLink.text = [currentElement objectForKey:@"link"];
	twitterCell.tweetLink.frame = CGRectMake(10, twitterCell.tweetText.frame.origin.y+twitterCell.tweetText.frame.size.height+4, 400, 21);
	[twitterCell.tweetLink sizeToFit];
	
	return twitterCell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *elementForHeight = [stories objectAtIndex:[indexPath row]];
	
	NSString *theText = [elementForHeight objectForKey:@"text"];
	CGSize constraintSize = CGSizeMake(270, 800);
	CGSize theSize = [theText sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	CGFloat theHeight = theSize.height + 30;
	
//	self.twitterTable = @"Ddd";
	//CGFloat twSize = twitterTable..tweetText.frame.origin.y+twitterTable.tweetText.frame.size.height + 5.0;
//	CGFloat twSize = twhCell.tweetText.frame.origin.y+twhCell.tweetText.frame.size.height + 5.0;
//	if (twSize > 70.0f) {
//		return twSize;
//	} else {
		return theHeight;
//	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *selectedCurrentElement = [stories objectAtIndex:[indexPath row]];
	NSString *theLink = [selectedCurrentElement objectForKey:@"link"];
	int linkLen = [theLink length];
	if (linkLen>4) {
	linkViewController = [[LinkViewController alloc] initWithNibName:@"LinkViewController" bundle:[NSBundle mainBundle]]; 
	linkViewController.link =  [selectedCurrentElement objectForKey:@"link"];
	[self.navigationController pushViewController:linkViewController animated:YES];			

	}
	[selectedCurrentElement release];
}

///////////////////////END TABLE VIEW FUNCTIONS


///////DELEGATE METHOD
- (void) isSocial:(NSString *)loaded {
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[rssParser release];
	[stories release];
	[item release];
	[user release];
	[currentElement release];
	[currentTitle release];
	[currentUser release];
	[currentDate release];
	[currentAvatar release];
	[currentLink release];
	[currentDescription release];
	[linkViewController release];
	[twitterTable release];
	[facebookSwitch release];
	[smsSwitch release];
	[facebook release];
	[urlData release];
}

@end
