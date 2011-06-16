//
//  PartecipaKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PartecipaKino.h"


@implementation PartecipaKino
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
    titoloImage.image = [UIImage imageNamed:@"partecipatitolo.png"];
    [mainScrollView addSubview:titoloImage];
    [titoloImage release];

    UIFont *Futura = [UIFont fontWithName:@"Futura-Medium" size:16.0];        

    //partecipare title
   /* UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, titoloImage.frame.origin.y+titoloImage.frame.size.height, 300, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = UITextAlignmentLeft;
    
    titleLabel.text = @"COME PARTECIPARE";
    [titleLabel setFont:Futura];
    titleLabel.numberOfLines = 1;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;

    [mainScrollView addSubview:titleLabel];
    [titleLabel release];

    mainScrollView.contentSize = CGSizeMake(320, titleLabel.frame.origin.y+titleLabel.frame.size.height+10);*/

    //tessera text
    UILabel *tessera = [[UILabel alloc] initWithFrame:CGRectMake(10, titoloImage.frame.origin.y+titoloImage.frame.size.height+20, 300, 700)];
    tessera.textColor = [UIColor yellowColor];
    tessera.backgroundColor = [UIColor clearColor];
    tessera.textAlignment = UITextAlignmentLeft;
    
    tessera.text = @"Tutte le tessere danno diritto a:\n- entrare gratuitamente in sala per le proiezioni\n- partecipare ai “gruppi di lavoro” con diritto di voto sulle decisioni del gruppo\n- proporre e curare rassegne e carte blanche\n- tessera ARCI 2011";

    [tessera setFont:Futura];
    tessera.numberOfLines = 0;
    tessera.lineBreakMode = UILineBreakModeWordWrap;
    [tessera sizeToFit];
    tessera.frame = CGRectMake(10, tessera.frame.origin.y, 300, tessera.frame.size.height);
    [mainScrollView addSubview:tessera];
    [tessera release];

    mainScrollView.contentSize = CGSizeMake(320, tessera.frame.origin.y+tessera.frame.size.height+10);



    UIImageView *sostenitoreImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, tessera.frame.origin.y+tessera.frame.size.height+10, 320, 370)];
    sostenitoreImage.image = [UIImage imageNamed:@"sociosostenitore.png"];
    [mainScrollView addSubview:sostenitoreImage];

    mainScrollView.contentSize = CGSizeMake(320, sostenitoreImage.frame.origin.y+sostenitoreImage.frame.size.height+10);
    [sostenitoreImage release];

    UIImageView *silverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, sostenitoreImage.frame.origin.y+sostenitoreImage.frame.size.height+20, 320, 370)];
    silverImage.image = [UIImage imageNamed:@"sociosilver.png"];
    [mainScrollView addSubview:silverImage];
    mainScrollView.contentSize = CGSizeMake(320, silverImage.frame.origin.y+silverImage.frame.size.height+10);
    [silverImage release];

    UIImageView *goldImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, silverImage.frame.origin.y+silverImage.frame.size.height+20, 320, 460)];
    goldImage.image = [UIImage imageNamed:@"sociogold.png"];
    [mainScrollView addSubview:goldImage];
    mainScrollView.contentSize = CGSizeMake(320, goldImage.frame.origin.y+goldImage.frame.size.height+10);
    [goldImage release];

    //aderire title
    UILabel *aderire = [[UILabel alloc] initWithFrame:CGRectMake(10, goldImage.frame.origin.y+goldImage.frame.size.height+20, 300, 30)];
    aderire.textColor = [UIColor whiteColor];
    aderire.backgroundColor = [UIColor clearColor];
    aderire.textAlignment = UITextAlignmentLeft;
    
    aderire.text = @"COME FACCIO AD ADERIRE?";
    
    [aderire setFont:Futura];
    aderire.numberOfLines = 1;
    aderire.lineBreakMode = UILineBreakModeWordWrap;
    
    [mainScrollView addSubview:aderire];
    [aderire release];
    
    mainScrollView.contentSize = CGSizeMake(320, aderire.frame.origin.y+aderire.frame.size.height+10);

    //aderire text
    UILabel *aderiretext = [[UILabel alloc] initWithFrame:CGRectMake(10, aderire.frame.origin.y+aderire.frame.size.height+10, 300, 700)];
    aderiretext.textColor = [UIColor whiteColor];
    aderiretext.backgroundColor = [UIColor clearColor];
    aderiretext.textAlignment = UITextAlignmentLeft;
    
    aderiretext.text = @"Facendo un bonifico a:\nAss. Cult. KSHOT\nVia Perugia, 34\nRoma\nBANCA ETICA\nIBAN: IT50G0501803200000000133499\nSpecificando nella causale: SOCIO GOLD 2011 – 2016 / SILVER 2011 – 2013 / SOSTENITORE 2011\n\nOppure pagando direttamente al Kino";
    
    [aderiretext setFont:Futura];
    aderiretext.numberOfLines = 0;
    aderiretext.lineBreakMode = UILineBreakModeWordWrap;
    [aderiretext sizeToFit];
    aderiretext.frame = CGRectMake(10, aderiretext.frame.origin.y, 300, aderiretext.frame.size.height);
    [mainScrollView addSubview:aderiretext];
    [aderiretext release];

    mainScrollView.contentSize = CGSizeMake(320, aderiretext.frame.origin.y+aderiretext.frame.size.height+10);

    //epoi title
    UILabel *epoi = [[UILabel alloc] initWithFrame:CGRectMake(10, aderiretext.frame.origin.y+aderiretext.frame.size.height+20, 300, 30)];
    epoi.textColor = [UIColor whiteColor];
    epoi.backgroundColor = [UIColor clearColor];
    epoi.textAlignment = UITextAlignmentLeft;
    
    epoi.text = @"E POI?";
    
    [epoi setFont:Futura];
    epoi.numberOfLines = 1;
    epoi.lineBreakMode = UILineBreakModeWordWrap;
    
    [mainScrollView addSubview:epoi];
    [epoi release];
    
    mainScrollView.contentSize = CGSizeMake(320, epoi.frame.origin.y+epoi.frame.size.height+10);

    //aderire text
    UILabel *epoitext = [[UILabel alloc] initWithFrame:CGRectMake(10, epoi.frame.origin.y+epoi.frame.size.height+10, 300, 700)];
    epoitext.textColor = [UIColor whiteColor];
    epoitext.backgroundColor = [UIColor clearColor];
    epoitext.textAlignment = UITextAlignmentLeft;
    
    epoitext.text = @"In caso di bonifico, effettuato il pagamento dovrai mandare una mail all’ indirizzo direttivo@ilkino.it in cui si attesta o si comunica l’avvenuto pagamento.\nRiceverai una mail in risposta con la conferma, e il numero della tessera.\nConsegnando la mail di conferma alla cassa del Kino riceverai la tessera.\nPer qualunque domanda o segnalazione, inviaci una mail a info@ilkino.it.";
    
    [epoitext setFont:Futura];
    epoitext.numberOfLines = 0;
    epoitext.lineBreakMode = UILineBreakModeWordWrap;
    [epoitext sizeToFit];
    epoitext.frame = CGRectMake(10, epoitext.frame.origin.y, 300, epoitext.frame.size.height);
    [mainScrollView addSubview:epoitext];
    [epoitext release];

    mainScrollView.contentSize = CGSizeMake(320, epoitext.frame.origin.y+epoitext.frame.size.height+10);

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
