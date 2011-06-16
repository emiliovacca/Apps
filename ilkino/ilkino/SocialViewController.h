//
//  SocialViewController.h
//  01Distribution
//
//  Created by emilio on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import <MessageUI/MessageUI.h>
 



@protocol socialDelegate
- (void) isSocial:(NSString *)loaded;
@end

@interface SocialViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate, socialDelegate, FBSessionDelegate, FBDialogDelegate, MFMessageComposeViewControllerDelegate>{
	IBOutlet UITableView *twitterTable;
	id <NSObject, socialDelegate > delegate;
	IBOutlet UISwitch *facebookSwitch;
	IBOutlet UISwitch *smsSwitch;	
	//FACEBOOK
	Facebook *facebook;
	NSString *urlData;
}

@property (nonatomic, retain) UITableView *twitterTable;
@property (retain) id <NSObject, socialDelegate > delegate;
@property (nonatomic, retain) UISwitch *facebookSwitch;
@property (nonatomic, retain) UISwitch *smsSwitch;

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSString *urlData;

- (IBAction) toggleEnabledForFacebook: (id) sender;  
- (IBAction) toggleEnabledForSms: (id) sender;  

@end
