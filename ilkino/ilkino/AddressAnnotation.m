//
//  AddressAnnotation.m
//  ilkino
//
//  Created by Emilio Vacca on 5/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressAnnotation.h"


@implementation AddressAnnotation

@synthesize coordinate;

- (NSString *)subtitle{
    return @"via Perugia 34, zona Pigneto";
}

- (NSString *)title{
    return @"il Kino";
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
  //  NSLog(@"%f,%f",c.latitude,c.longitude);
    return self;
}
@end

