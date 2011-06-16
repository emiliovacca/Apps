//
//  ChieKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChieKino.h"


@implementation ChieKino
@synthesize mainScrollView;

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
    [mainScrollView release];
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
    
    UIImageView *titoloImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 40)];
    titoloImage.image = [UIImage imageNamed:@"cosekinotitle.png"];
    [mainScrollView addSubview:titoloImage];
    [titoloImage release];

    
    //the main text
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titoloImage.frame.origin.y+titoloImage.frame.size.height+10, 300, 700)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = UITextAlignmentLeft;
    textLabel.text = @"Il KINO è un cinema, ma è un cinema diverso da tutti gli altri. Al Kino non si vedranno i film offerti in genere dalle sale romane; ma film fuori dal circuito, inediti, perle rare sfuggite alla grande distribuzione, e poi vecchi film di culto, film indipendenti, anteprime, documentari, cinema italiano di alta qualità.";
    UIFont *Futura = [UIFont fontWithName:@"Futura" size:16.0];        
    [textLabel setFont:Futura];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel sizeToFit];
    //  textLabel.frame = CGRectMake(10, 10, 300, textLabel.frame.size.height);
    [mainScrollView addSubview:textLabel];
    [textLabel release];

    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(35, textLabel.frame.origin.y+textLabel.frame.size.height+25, 250, 700)];
    textLabel2.textColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    textLabel2.backgroundColor = [UIColor clearColor];
    textLabel2.textAlignment = UITextAlignmentLeft;
    textLabel2.text = @"Perché il KINO nasce per dimostrare che si può ancora giocare con il cinema, divertirsi, incontrarsi, raccontare il presente.";
    UIFont *FuturaMediumItalic = [UIFont fontWithName:@"Futura-MediumItalic" size:16.0];        
    [textLabel2 setFont:FuturaMediumItalic];
    textLabel2.numberOfLines = 0;
    textLabel2.lineBreakMode = UILineBreakModeWordWrap;
    textLabel2.textAlignment = UITextAlignmentCenter;
    [textLabel2 sizeToFit];
    [mainScrollView addSubview:textLabel2];
    [textLabel2 release];
    
    UILabel *textLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, textLabel2.frame.origin.y+textLabel2.frame.size.height+25, 300, 700)];
    textLabel3.textColor = [UIColor whiteColor];
    textLabel3.backgroundColor = [UIColor clearColor];
    textLabel3.textAlignment = UITextAlignmentLeft;
    textLabel3.text = @"Il Kino nasce per mettere il nostro piccolo argine (un mattone per costruire una diga…) contro una serie di luoghi comuni e offensivi di questi anni. Nasce come risposta a chi dice che la cultura non serve a niente, nasce contro chi parla di bamboccioni e di parassiti, nasce per rispondere a tagli, precariati e polemiche.\nMa nasce soprattutto per divertirsi, per giocare, per sentirsi, ancora, non proprio adulti e un po’ irresponsabili.";
    [textLabel3 setFont:Futura];
    textLabel3.numberOfLines = 0;
    textLabel3.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel3 sizeToFit];
    //  textLabel.frame = CGRectMake(10, 10, 300, textLabel.frame.size.height);
    [mainScrollView addSubview:textLabel3];
    [textLabel3 release];

    UILabel *textLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(35, textLabel3.frame.origin.y+textLabel3.frame.size.height+25, 250, 700)];
    textLabel4.textColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:215.0f/255.0f alpha:1.0f];;
    textLabel4.backgroundColor = [UIColor clearColor];
    textLabel4.textAlignment = UITextAlignmentLeft;
    textLabel4.text = @"Un bel giorno, in sessanta, al grido di “come dei pazzi”, ci siamo detti: “Il paese sta crollando? E allora noi prendiamo cazzuola, calce e cemento e ne ricostruiamo almeno un piccolo pezzo”";
    [textLabel4 setFont:FuturaMediumItalic];
    textLabel4.numberOfLines = 0;
    textLabel4.lineBreakMode = UILineBreakModeWordWrap;
    textLabel4.textAlignment = UITextAlignmentCenter;
    [textLabel4 sizeToFit];
    [mainScrollView addSubview:textLabel4];
    [textLabel4 release];

    UILabel *textLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(10, textLabel4.frame.origin.y+textLabel4.frame.size.height+25, 300, 700)];
    textLabel5.textColor = [UIColor whiteColor];
    textLabel5.backgroundColor = [UIColor clearColor];
    textLabel5.textAlignment = UITextAlignmentLeft;
    textLabel5.text = @"Il pezzo che abbiamo scelto è un vecchio cineclub in zona Pigneto, un vecchio cineclub che si chiamava Grauco e che ha chiuso i battenti. Lo abbiamo riportato alla vita.\nMa a noi piace fare le cose in grande, e allora il KINO è anche un bistrot specializzato in alimenti biologici, slow food, vini biodinamici.\nE’ un luogo di incontro e scambio, una tana dove rifugiarsi a leggere i giornali bevendo una tazza di thè in un pomeriggio invernale, è un locale dove prendere un aperitivo aspettando di entrare in sala, e poi per mangiare dopo il film.\nE’ anche uno spazio per corsi e seminari, incontri con gli autori, proiezioni private.\nTutto questo è il KINO: una sala cinematografica da 40 posti ad alta dotazione tecnologica e uno spazio enoteca ampio e accogliente.";
    [textLabel5 setFont:Futura];
    textLabel5.numberOfLines = 0;
    textLabel5.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel5 sizeToFit];
    //  textLabel.frame = CGRectMake(10, 10, 300, textLabel.frame.size.height);
    [mainScrollView addSubview:textLabel5];
    [textLabel5 release];

    mainScrollView.contentSize = CGSizeMake(320, textLabel5.frame.origin.y+textLabel5.frame.size.height+10);
    // Do any additional setup after loading the view from its nib.
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
