//
//  TwitterCell.m
//  01Distribution
//
//  Created by emilio on 3/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterCell.h"


@implementation TwitterCell
@synthesize tweetUser;
@synthesize tweetText;
@synthesize tweetDate;
@synthesize tweetLink;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
} 


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
	[tweetUser release];
	[tweetText release];
	[tweetDate release];
	[tweetLink release];	
}


@end
