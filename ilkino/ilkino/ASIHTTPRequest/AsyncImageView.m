//
//  AsyncImageView.m
//  YellowJacket
//
//  Created by Wayne Cochran on 7/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AsyncImageView.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"
#import <QuartzCore/QuartzCore.h>

//
// Key's are URL strings.
// Value's are ImageCacheObject's
//
static ImageCache *imageCache = nil;

@implementation AsyncImageView

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
    [super dealloc];
}

-(void)loadImageFromURL:(NSURL*)url {
    if (connection != nil) {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil) {
        [data release];
        data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
    
    [urlString release];
    urlString = [[url absoluteString] copy];
    UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil) {
        if ([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = 
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:imageView];
        imageView.frame = self.bounds;
		///////////DRAW BORDER
		imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
		imageView.layer.borderWidth = 1.0f;
		///////////END DRAW BORDER
		
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
        return;
	} 
	
	// andy@luibh.ie 6th March 2010 - including modified code by Robert A of http://photoaperture.com/
	// this shows a default place holder image if no cached image exists.
	else {
				
		// Use a default placeholder when no cached image is found
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage
																  imageNamed:@"blank.png"]] autorelease];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.autoresizingMask =
		UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		
		[imageView setNeedsLayout];
		[self setNeedsLayout];
	}    
	
#define SPINNY_TAG 5555   
    
    UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinny.tag = SPINNY_TAG;
    spinny.center = self.center;
    [spinny startAnimating];
    [self addSubview:spinny];
    [spinny release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


/////////////////define specific placeholder///////////////
-(void)loadImageFromURL:(NSURL*)url withImage:(NSString *)thePlaceHolder {
    if (connection != nil) {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil) {
        [data release];
        data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
    
    [urlString release];
    urlString = [[url absoluteString] copy];
    UIImage *cachedImage = [imageCache imageForKey:urlString];
    if (cachedImage != nil) {
        if ([[self subviews] count] > 0) {
            [[[self subviews] objectAtIndex:0] removeFromSuperview];
        }
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.autoresizingMask = 
		UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:imageView];
        imageView.frame = self.bounds;
		///////////DRAW BORDER
		imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
		imageView.layer.borderWidth = 1.0f;
		///////////END DRAW BORDER		
        [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
        [self setNeedsLayout];
        return;
	} 
	
	// andy@luibh.ie 6th March 2010 - including modified code by Robert A of http://photoaperture.com/
	// this shows a default place holder image if no cached image exists.
	else {
		
		// Use a default placeholder when no cached image is found
		UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage
																	  imageNamed:thePlaceHolder]] autorelease];
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		imageView.autoresizingMask =
		UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self addSubview:imageView];
		imageView.frame = self.bounds;
		[imageView setNeedsLayout];
		[self setNeedsLayout];
	}    
	
#define SPINNY_TAG 5555   
    
    UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinny.tag = SPINNY_TAG;
	spinny.frame = CGRectMake(self.frame.size.width/2 - 10, self.frame.size.height/2 - 10, 20, 20);
    [spinny startAnimating];
    [self addSubview:spinny];
    [spinny release];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url 
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

/////////////////END define specific placeholder///////////////


- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    [connection release];
    connection = nil;
    
    UIView *spinny = [self viewWithTag:SPINNY_TAG];
    [spinny removeFromSuperview];
    
    if ([[self subviews] count] > 0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    [imageCache insertImage:image withSize:[data length] forKey:urlString];
    
    UIImageView *imageView = [[[UIImageView alloc] 
                               initWithImage:image] autorelease];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self addSubview:imageView];
    imageView.frame = self.bounds;
	
	///////////DRAW BORDER
	imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
	imageView.layer.borderWidth = 1.0f;
	///////////END DRAW BORDER
	
    [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
    [self setNeedsLayout];
    [data release];
    data = nil;
}

@end
