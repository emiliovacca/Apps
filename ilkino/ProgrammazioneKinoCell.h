//
//  ProgrammazioneKinoCell.h
//  ilkino
//
//  Created by Emilio Vacca on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgrammazioneKinoCell : UITableViewCell {
    IBOutlet UILabel *orarioLabel;
    IBOutlet UILabel *titoloLabel;
}

@property (nonatomic, retain) UILabel *orarioLabel;
@property (nonatomic, retain) UILabel *titoloLabel;

@end
