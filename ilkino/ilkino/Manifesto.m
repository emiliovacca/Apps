//
//  Manifesto.m
//  ilkino
//
//  Created by Emilio Vacca on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Manifesto.h"
#import <QuartzCore/QuartzCore.h>

@implementation Manifesto
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Manifesto";

 //   UIFont *Futura16 = [UIFont fontWithName:@"Futura-Medium" size:16.0];        

    //manifesto title
    UIImageView *titoloImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 40)];
    titoloImage.image = [UIImage imageNamed:@"manifestotitle.png"];
    [mainScrollView addSubview:titoloImage];
    [titoloImage release];

    
    //manifesto image
    UIImageView *manifestoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 1280)];
    manifestoImage.image = [UIImage imageNamed:@"manifestoKino.png"];
    [mainScrollView addSubview:manifestoImage];
    [manifestoImage release];
    
    mainScrollView.contentSize = CGSizeMake(320, manifestoImage.frame.origin.y+manifestoImage.frame.size.height+10);

    /*UILabel *manifesto = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 700)];
    manifesto.textColor = [UIColor whiteColor];
    manifesto.backgroundColor = [UIColor clearColor];
    manifesto.textAlignment = UITextAlignmentLeft;
    
    manifesto.text = @"Il Kino è un cinema.\nIl Kino non è un cineclub.\nAl Kino non c’è il 3D: due bastano e avanzano.\nIl Kino è irriverente, infantile, intelligente.\nAl Kino puoi vedere quello che gli altri non ti fanno vedere.\nAl Kino puoi vedere cinema, studiare cinema, fare cinema.\nAl Kino è come una festa.\nAl Kino è come un festival.\nIl Kino è un bistrot, il Kino è un’enoteca.\nIl Kino è i suoi divani.\nAl Kino puoi vedere il nuovo cinema indipendente.\nIl Kino può dare dipendenza.\nIl Kino è un’idea, un manifesto, una follia.\nIl Kino è come dei pazzi.\nIl Kino è al Pigneto.\nIl Kino a un certo punto si chiamava Blutarsky.\nAl Kino c’è la versione originale.\nAl Kino è prendi l’aperitivo, vedi il film. Poi un altro aperitivo, e un altro film.\nAl Kino ci sono le Carte Blanche.\nAl Kino ci sono i vini biodinamici.\nAl Kino c’è la notte Cult del Sabato.\nIl Kino è vicino.\nAl Kino c’è un pianoforte.\nIl Kino prima di nascere era il Grauco.\nIl Kino lo abbiamo aperto in 55, sembriamo tanti, ci sentiamo pochi.\nAl Kino si vede il cinema italiano.\nAl Kino ci sono i fannulloni e bamboccioni.\nIl Kino è precario.\nIl Kino vuole bene a Dude Lebovski e a Alex DeLarge, a Vincent Vega e a Rick Blaine, a Rocky Balboa e a Marcello Rubini.\nIl Kino è chi si, e Ki No.\nIl Kino è Kinopravda, Kinotto, Kinino. Il manifesto del Kino è il Manikino.\nIl Kino è appena nato e forse non sa ancora bene chi è.\nIl Kino vuole crescere.\nIl Kino ha bisogno di tutti.\nAl Kino tutti possono partecipare, decidere, inventare rassegne, proporre programmi.";
    
    [manifesto setFont:Futura16];
    manifesto.numberOfLines = 0;
    manifesto.lineBreakMode = UILineBreakModeWordWrap;
    [manifesto sizeToFit];
    manifesto.frame = CGRectMake(10, manifesto.frame.origin.y, 300, manifesto.frame.size.height);
    [Futura16 release];
    [mainScrollView addSubview:manifesto];
    [manifesto release];
    
    mainScrollView.contentSize = CGSizeMake(320, manifesto.frame.origin.y+manifesto.frame.size.height+10);*/

    [super viewDidLoad];
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
