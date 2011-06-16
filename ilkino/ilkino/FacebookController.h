//
//  FacebookController.h
//  01Distribution
//
//  Created by emilio on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface FacebookController : UIViewController <FBSessionDelegate>{
	Facebook *facebook;
}

@property (nonatomic, retain) Facebook *facebook;

@end
