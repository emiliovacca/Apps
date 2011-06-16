//
//  BistrotKino.m
//  ilkino
//
//  Created by Emilio Vacca on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BistrotKino.h"


@implementation BistrotKino
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
}

- (void) loadBistrot {    
    UIImageView *titoloImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 40)];
    titoloImage.image = [UIImage imageNamed:@"barkinotitle.png"];
    [mainScrollView addSubview:titoloImage];
    [titoloImage release];

    //the text
    UILabel *textLabel0 = [[UILabel alloc] initWithFrame:CGRectMake(10, titoloImage.frame.origin.y+titoloImage.frame.size.height+20, 300, 30)];
    textLabel0.textColor = [UIColor whiteColor];
    textLabel0.backgroundColor = [UIColor clearColor];
    textLabel0.textAlignment = UITextAlignmentLeft;
    textLabel0.text = @"Chi oggi decide di aprire un cinema, lo fa per assecondare una passionaccia: perché sente di poter transigere su molte cose nella vita, ma non sui film che vedrà. C’è una bella tradizione in Italia di sale cinematografiche di qualità, che combattono contro i multiplex, eppure, se vai a vedere, tutta quell’attenzione alla qualità dei film spesso non si traduce in cultura dell’accoglienza: sicché gli spuntini, le bevande, i dolciumi d’accompagnamento alla visione fanno schifo.";
    UIFont *Futura16 = [UIFont fontWithName:@"Futura-Medium" size:16.0];        
    [textLabel0 setFont:Futura16];
    textLabel0.numberOfLines = 0;
    textLabel0.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel0 sizeToFit];
    [mainScrollView addSubview:textLabel0];
    
    UIImageView *ilBistrotImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, textLabel0.frame.origin.y+textLabel0.frame.size.height+10, 320, 89)];
    ilBistrotImage.image = [UIImage imageNamed:@"bistrotimage.png"];
    [mainScrollView addSubview:ilBistrotImage];
    [ilBistrotImage release];

    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ilBistrotImage.frame.origin.y+ilBistrotImage.frame.size.height+10, 300, 30)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = UITextAlignmentLeft;
    textLabel.text = @"Ma davvero per vedersi un bel film al cinema bisogna sorbirsi popcorn transgenici, bibite extradolci, gelati industriali e automobiline di liquirizia gommosa?\n\nnoi del KINO crediamo di no.\n\nOggi che i film sono piratati e scaricabili, per spingere la gente ad andare al cinema bisogna darle un buon motivo. Le major l’hanno individuato nel 3D, nell’esperienza spettacolare.";
    [textLabel setFont:Futura16];
    textLabel.numberOfLines = 0;
    textLabel.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel sizeToFit];
    [mainScrollView addSubview:textLabel];
    
    UIImageView *ilBistrotImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, textLabel.frame.origin.y+textLabel.frame.size.height+10, 320, 89)];
    ilBistrotImage2.image = [UIImage imageNamed:@"bistrotimage2.png"];
    [mainScrollView addSubview:ilBistrotImage2];
    [ilBistrotImage2 release];

    UILabel *textLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, ilBistrotImage2.frame.origin.y+ilBistrotImage2.frame.size.height+10, 300, 30)];
    textLabel1.textColor = [UIColor whiteColor];
    textLabel1.backgroundColor = [UIColor clearColor];
    textLabel1.textAlignment = UITextAlignmentLeft;

    textLabel1.text = @"Noi puntiamo su un’altra dimensione. Quella sensoriale.\n\nE siccome siamo piccoli – 36 posti a sedere – possiamo pure pensare in grande.\n\nQuelli hanno il 3D? E noi abbiamo il Gustorama!\n\nVioleremo la sacralità del rito della fruizione cinematografica con snack slow e vini d’autore abbinati al film. E forse dopo un Dolcetto d’Alba e una birra artigianale, si ammorbidirà il veleno di certi giudizi, chissà.\n\nE comunque non si berrà solo – né sempre – nel cinemino al piano di sotto, che sia chiaro: il KINO è anche un locale, al piano di sopra, e prima o dopo i film, o durante i corsi di cinema e le adunate sediziose, si servono cose buone.\n\nI vini che diamo in mescita, per esempio, sono prevalentemente biologici e biodinamici: come fra i film nel cinema ci piacciono le piccole produzioni indipendenti, così nel vino ci piace la diversità e le bottiglie che raccontano una storia autentica e originale (e con un buon rapporto qualità/prezzo!).";

    [textLabel1 setFont:Futura16];
    textLabel1.numberOfLines = 0;
    textLabel1.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel1 sizeToFit];
    
    [mainScrollView addSubview:textLabel1];

    UIImageView *ilBistrotImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, textLabel1.frame.origin.y+textLabel1.frame.size.height+10, 320, 89)];
    ilBistrotImage3.image = [UIImage imageNamed:@"bistrotimage3.png"];
    [mainScrollView addSubview:ilBistrotImage3];
    [ilBistrotImage3 release];

    
    UILabel *textLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, ilBistrotImage3.frame.origin.y+ilBistrotImage3.frame.size.height+10, 300, 30)];
    textLabel2.textColor = [UIColor whiteColor];
    textLabel2.backgroundColor = [UIColor clearColor];
    textLabel2.textAlignment = UITextAlignmentLeft;
    
    textLabel2.text = @"Vorremmo dare l’opportunità ai nostri soci di poter conoscere direttamente non solo produttori, registi e autori dei film che proiettiamo, ma anche i produttori e coltivatori dei vini in carta o dei formaggi che serviamo, alle volte abbinati al film. Succederà di trovarsi a discutere del film col regista, sorseggiando un bicchiere di vino allo stesso tavolo del vignaiolo che l’ha prodotto…\n\nAnche fra le birre privilegiamo quelle artigianali, senza integralismi (qualche birra major ci potrà scappare) ma con un orientamento chiaro.\n\nE lo stesso vale per le bibite (niente Coca Cola, spiacenti), per i succhi di frutta, e per i nostri cocktail.\n\nPer ora il KINO ospita un bar serale, ma stiamo lavorando alacremente per sistemare il nostro laboratorio per avere un’offerta gastronomica valida e portare a pieno regime il nostro cine-bistrot. Ci piace l’idea di servire formaggi e salumi artigianali, insalate biologiche di verdura stagionale, pane e focacce a lievitazione naturale, piatti freddi e minestre, acqua del sindaco (niente plastica) e torte artigianali.\n\nHai presente quando vai al cinema e poi non sai dove andare a mangiare?\n\nEcco, Il KINO ti offre la possibilità di fare l’una e l’altra cosa senza cambiare locale.\n\nPerché c’è chi pensa che con la cultura non si mangia…e  KI NO.\n\nPER INFO E PRENOTAZIONI BISTROT:\n\nbistrot@ilkino.it";

    [textLabel2 setFont:Futura16];
    textLabel2.numberOfLines = 0;
    textLabel2.lineBreakMode = UILineBreakModeWordWrap;
    [textLabel2 sizeToFit];
    [Futura16 release];
    [mainScrollView addSubview:textLabel2];

    mainScrollView.contentSize = CGSizeMake(320, textLabel2.frame.origin.y+textLabel2.frame.size.height+10);
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
    [self loadBistrot];
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
