//
//  TwitterCell.h
//  01Distribution
//
//  Created by emilio on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TwitterCell : UITableViewCell {
	IBOutlet UILabel *tweetUser;
	IBOutlet UILabel *tweetText;
	IBOutlet UILabel *tweetDate;
	IBOutlet UILabel *tweetLink;
}
 
@property (nonatomic, retain) UILabel *tweetUser;
@property (nonatomic, retain) UILabel *tweetText;
@property (nonatomic, retain) UILabel *tweetDate;
@property (nonatomic, retain) UILabel *tweetLink;

@end
