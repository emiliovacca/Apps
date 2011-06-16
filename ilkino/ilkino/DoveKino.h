//
//  DoveKino.h
//  ilkino
//
//  Created by Emilio Vacca on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface DoveKino : UIViewController <MKMapViewDelegate, MKReverseGeocoderDelegate, UIAlertViewDelegate,MFMailComposeViewControllerDelegate> {
    MKMapView *mapView;
    MKReverseGeocoder *geoCoder;
	MKPlacemark *mPlacemark;
}

-(IBAction) callKino:(id)sender;
-(IBAction) mailKino:(id)sender;

@end
