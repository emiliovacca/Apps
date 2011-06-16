//
//  BistrotKino.h
//  ilkino
//
//  Created by Emilio Vacca on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BistrotKino : UIViewController {
    IBOutlet UIScrollView *mainScrollView;
}
@property (nonatomic, retain) UIScrollView *mainScrollView;

- (void) loadBistrot;

@end
