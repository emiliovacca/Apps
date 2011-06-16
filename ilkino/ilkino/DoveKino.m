//
//  DoveKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DoveKino.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "AddressAnnotation.h"

@implementation DoveKino

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
    mapView=[[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    mapView.showsUserLocation=TRUE;
    mapView.mapType=MKMapTypeStandard;
    mapView.delegate=self;
    
    /*Region and Zoom*/
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.02;
    span.longitudeDelta=0.02;
    
    CLLocationCoordinate2D location=mapView.userLocation.coordinate;
    
    location.latitude=41.889852;
    location.longitude=12.526306;
    region.span=span;
    region.center=location;
    
    /*Geocoder Stuff*/
    
    //geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:location];
    //geoCoder.delegate=self;
    //[geoCoder start];
    
    AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
    [mapView addAnnotation:addAnnotation];

    
    [mapView setRegion:region animated:TRUE];
    [mapView regionThatFits:region];
    [self.view addSubview:mapView];
    // Do any additional setup after loading the view from its nib.
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error{
	//NSLog(@"Reverse Geocoder Errored");
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark{
	//NSLog(@"Reverse Geocoder completed");
	mPlacemark=placemark;
	[mapView addAnnotation:placemark];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation{
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
    annView.pinColor = MKPinAnnotationColorGreen;
    annView.animatesDrop=TRUE;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);

    return annView;
}


///PHONE AND EMAIL BUTTON
-(IBAction) callKino:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"Kino"];
    [alert setTag:121];
	[alert setMessage:@"Vuoi contattare"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Kino Mobile"];
	[alert addButtonWithTitle:@"Kino Locale"];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *theAlert = (UIAlertView *)alertView;
    if (theAlert.tag == 121) {
        if (buttonIndex == 0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:00393664571726"]];
        } else if (buttonIndex == 1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:00390696525810"]];
        }
    }
    
    if (theAlert.tag == 122) {
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        if (buttonIndex == 0) {
            [controller setSubject:@"Richiesta informazioni"];
            [controller setMessageBody:@"Cari amici del Kino, " isHTML:NO]; 
            [controller setToRecipients:[NSArray arrayWithObjects:@"info@ilkino.it", nil]];  
        } else if (buttonIndex == 1) {
            [controller setSubject:@"Voglio prenotare il Bistrot del Kino"];
            [controller setMessageBody:@"Cari amici del Kino, vorrei prenotare per n.  persone alle ore   :" isHTML:NO]; 
            [controller setToRecipients:[NSArray arrayWithObjects:@"bistrot@ilkino.it", nil]];  
        }
        if (controller) [self presentModalViewController:controller animated:YES];
        [controller release];
    }
}


-(IBAction) mailKino:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
	[alert setTitle:@"Kino"];
    [alert setTag:122];
	[alert setMessage:@"Vuoi informazioni o vuoi prenotare il bistrot?"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"Informazioni"];
	[alert addButtonWithTitle:@"Bistrot"];
	[alert show];
	[alert release];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {  
    // switchng the result  
    switch (result) {  
        case MFMailComposeResultCancelled:  
           // NSLog(@"Mail send canceled.");  
            /* 
             Execute your code for canceled event here ... 
             */  
            break;  
        case MFMailComposeResultSaved:  
          //  NSLog(@"Mail saved.");  
            /* 
             Execute your code for email saved event here ... 
             */  
            break;  
        case MFMailComposeResultSent:  
            NSLog(@"Mail sent."); 
            UIAlertView *alertOk = [[UIAlertView alloc] init];
            [alertOk setTitle:@"Kino"];
            [alertOk setMessage:@"Messaggio inviato con successo?"];
            [alertOk setDelegate:self];
            [alertOk addButtonWithTitle:@"OK"];
            [alertOk show];
            [alertOk release];

            /* 
             Execute your code for email sent event here ... 
             */  
            break;  
        case MFMailComposeResultFailed:  
            NSLog(@"Mail send error: %@.", [error localizedDescription]);  
            UIAlertView *alertNo = [[UIAlertView alloc] init];
            [alertNo setTitle:@"Kino"];
            [alertNo setMessage:@"Errore nell'invio del messaggi?"];
            [alertNo setDelegate:self];
            [alertNo addButtonWithTitle:@"OK"];
            [alertNo show];
            [alertNo release];
            break;  
        default:  
            break;  
    }  
    // hide the modal view controller  
    [self dismissModalViewControllerAnimated:YES];  
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
