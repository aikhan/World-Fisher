//
//  GameFishDetailViewController.m
//  World-Fisher
//
//  Created by Asad Khan on 2/1/11.
//  Copyright 2011 Semantic Notion Inc. All rights reserved.
//

#import "GameFishDetailViewController.h"
#import "FishDetailImageController.h"
#import "GameFish.h"
#import "CoreDataDAO.h"


@implementation GameFishDetailViewController
@synthesize scrollView, commonNameLabel, scientificNameLabel, familyLabel, rangeLabel, habitatLabel, 
			adultSizeLabel, identificationLabel, howToFishLabel;
@synthesize identificationTextView, howToFishTextView;
@synthesize downloadedImage, bigFishButton, downloadQueue;
@synthesize Temp;
@synthesize first,second,third,four,myspiner;
- (void)dealloc {
    [first release];
    [second release];
    [third release];
    [four release];
    [myspiner release];
    [super dealloc];
	[scrollView release];
	[downloadedImage release];
	[bigFishButton release];
	[downloadQueue release];
	
	[commonNameLabel release];
	[scientificNameLabel release];
	[familyLabel release];
	[rangeLabel release];
	[habitatLabel release];
	[adultSizeLabel release];
	[identificationLabel release];
	[howToFishLabel release];
	[identificationTextView release];
	[howToFishTextView release];
}

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    int mID = [[[self.Temp objectAtIndex:0] modelObjectID] intValue];
	
	NSLog(@"Fish id = %d", mID);
	NSNumber *number = [NSNumber numberWithInt:mID];
	GameFish *fish;
	fish = [CoreDataDAO fishFetchFishWithID:number withError:nil];
	UIImage *image = [fish.image valueForKey:@"image"];

	if (!image) {
        
		image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fish.imageURL]]];
        [fish.image setValue:image forKey:@"image"];
		[CoreDataDAO saveData];
        
	}
	else {
		image = [fish.image valueForKey:@"image"];
	}
    
    
	[self.bigFishButton setImage:image forState:UIControlStateNormal];
    //    [self.bigFishButton setImage:image forState:UIControlStateSelected];
     [self.myspiner stopAnimating];
    self.myspiner.hidden=YES;

}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.myspiner startAnimating];
        NSLog(@"%@",self.Temp);
	self.downloadQueue = [[NSOperationQueue alloc] init];
	if (downloadedImage == nil) {
		NSLog(@"Download Image");
	}
	float yPos = 575;
	//Rest of View
	scrollView.delegate = self;
	[scrollView setScrollEnabled:YES];
	[scrollView setCanCancelContentTouches:NO];
    self.navigationItem.title = @"Detail";//self.commonNameLabel.text;
   // [UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0]
    self.first.textColor=[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];
    self.commonNameLabel.textColor=[UIColor whiteColor];
    self.scientificNameLabel.textColor=[UIColor whiteColor];
    self.familyLabel.textColor=[UIColor whiteColor];
    self.rangeLabel.textColor=[UIColor whiteColor];
    self.first.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
    self.second.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
    self.second.textColor=[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];
    self.third.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
    self.third.textColor=[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];
    self.four.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
    self.four.textColor=[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];
    
	
	scrollView.userInteractionEnabled = YES;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        //Add Habitate
        UILabel *habitate = [[UILabel alloc]initWithFrame:CGRectMake(0, 610,768, 21)];
        habitate.font = [UIFont systemFontOfSize:16];
        habitate.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0]; //[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
        habitate.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
        habitate.text = @"Habitat ";
        habitate.textAlignment = UITextAlignmentCenter;
        [scrollView addSubview:habitate];
         [habitate release];
        
        
        
        self.habitatLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos+30, 768, 80)];
        self.habitatLabel.backgroundColor = [UIColor clearColor];
        self.habitatLabel.font = [UIFont systemFontOfSize:14];
        self.habitatLabel.textColor = [UIColor whiteColor];
        self.habitatLabel.numberOfLines = 0;
        self.habitatLabel.textAlignment = UITextAlignmentCenter;
        [scrollView addSubview:self.habitatLabel];
        
        yPos = yPos + self.habitatLabel.frame.size.height + 15;
        
        
        
        //Add Adult Size label
        UILabel *adultSizeDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, 768, 21)];
        adultSizeDetailLabel.font = [UIFont systemFontOfSize:16];
        adultSizeDetailLabel.textAlignment = UITextAlignmentCenter;
        adultSizeDetailLabel.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];//[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
        adultSizeDetailLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
        adultSizeDetailLabel.text = @"Adult Size";
        [scrollView addSubview:adultSizeDetailLabel];
        yPos = yPos + adultSizeDetailLabel.frame.size.height;
        [adultSizeDetailLabel release];
        
        
        self.adultSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, 768, 80)];
        self.adultSizeLabel.backgroundColor = [UIColor clearColor];
        self.adultSizeLabel.font = [UIFont systemFontOfSize:14];
        self.adultSizeLabel.textColor = [UIColor whiteColor];
        self.adultSizeLabel.numberOfLines = 0;
        self.adultSizeLabel.textAlignment = UITextAlignmentCenter;
        yPos = yPos + self.adultSizeLabel.frame.size.height;
        [scrollView addSubview:self.adultSizeLabel];

        
        //How to Fish textview
        howToFishLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, 768, 21)];
        howToFishLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
        howToFishLabel.font = [UIFont systemFontOfSize:16];
        howToFishLabel.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];// [UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
        howToFishLabel.text = @"How to Fish ";
        howToFishLabel.textAlignment = UITextAlignmentCenter;
        yPos = yPos + howToFishLabel.frame.size.height;
        [scrollView addSubview:howToFishLabel];
        
        self.howToFishTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, yPos, 768, 210)];
        self.howToFishTextView.userInteractionEnabled = NO;
        self.howToFishTextView.backgroundColor = [UIColor clearColor];
        self.howToFishTextView.textColor = [UIColor whiteColor];
        self.howToFishTextView.font = [UIFont systemFontOfSize:14];
        yPos = yPos + self.howToFishTextView.frame.size.height;
        [scrollView addSubview:self.howToFishTextView];
        
        
        
        
        //Add Identification View
        self.identificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, 768, 21)];
        self.identificationLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
        self.identificationLabel.font = [UIFont systemFontOfSize:16];
        self.identificationLabel.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0]; //[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
        self.identificationLabel.text = @"Identification";
        self.identificationLabel.textAlignment = UITextAlignmentCenter;
        yPos = yPos + self.identificationLabel.frame.size.height;
        [scrollView addSubview:self.identificationLabel];
        
        
        
        self.identificationTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, yPos, 768, 240)];
        self.identificationTextView.userInteractionEnabled = NO;
        self.identificationTextView.backgroundColor = [UIColor clearColor];
        self.identificationTextView.textColor =[UIColor whiteColor];
        self.identificationTextView.font = [UIFont systemFontOfSize:14];
        yPos = yPos + self.identificationTextView.frame.size.height;
        [scrollView addSubview:self.identificationTextView];



    }else{
	//Add Habitate
    UILabel *habitate = [[UILabel alloc]initWithFrame:CGRectMake(20, 550, 286, 21)];
    habitate.font = [UIFont systemFontOfSize:16];
        habitate.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];//[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
	habitate.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
	habitate.text = @"Habitat ";
    habitate.textAlignment = UITextAlignmentCenter;
	[scrollView addSubview:habitate];
    [habitate release];
    
    self.habitatLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, yPos, 286, 80)];
	self.habitatLabel.backgroundColor = [UIColor clearColor];
	self.habitatLabel.font = [UIFont systemFontOfSize:14];
	self.habitatLabel.textColor =[UIColor whiteColor];
	self.habitatLabel.numberOfLines = 0;
    self.habitatLabel.textAlignment = UITextAlignmentCenter;
	[scrollView addSubview:self.habitatLabel];
    
    yPos = yPos + self.habitatLabel.frame.size.height + 10;
	
    
    //Add Adult Size label
	UILabel *adultSizeDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, yPos, 286, 21)];
	adultSizeDetailLabel.font = [UIFont systemFontOfSize:16];
    adultSizeDetailLabel.textAlignment = UITextAlignmentCenter;
        adultSizeDetailLabel.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];//[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
	adultSizeDetailLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
	adultSizeDetailLabel.text = @"Adult Size";
	[scrollView addSubview:adultSizeDetailLabel];
    yPos = yPos + adultSizeDetailLabel.frame.size.height;
	[adultSizeDetailLabel release];

    
    self.adultSizeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, yPos, 286, 80)];
	self.adultSizeLabel.backgroundColor = [UIColor clearColor];
	self.adultSizeLabel.font = [UIFont systemFontOfSize:14];
	self.adultSizeLabel.textColor = [UIColor whiteColor];
	self.adultSizeLabel.numberOfLines = 0;
    self.adultSizeLabel.textAlignment = UITextAlignmentCenter;
    yPos = yPos + self.adultSizeLabel.frame.size.height;
	[scrollView addSubview:self.adultSizeLabel];
    
    
	
	
	//How to Fish textview
	howToFishLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, yPos, 286, 21)];
	howToFishLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
	howToFishLabel.font = [UIFont systemFontOfSize:16];
        howToFishLabel.textColor = [UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0];//[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
	howToFishLabel.text = @"How to Fish ";
    howToFishLabel.textAlignment = UITextAlignmentCenter;
    yPos = yPos + howToFishLabel.frame.size.height;
	[scrollView addSubview:howToFishLabel];

	self.howToFishTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, yPos, 286, 210)];
	self.howToFishTextView.userInteractionEnabled = NO;
	self.howToFishTextView.backgroundColor = [UIColor clearColor];
	self.howToFishTextView.textColor = [UIColor whiteColor];
	self.howToFishTextView.font = [UIFont systemFontOfSize:14];
    yPos = yPos + self.howToFishTextView.frame.size.height;
	[scrollView addSubview:self.howToFishTextView];
	
    //Add Identification View
	self.identificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, yPos, 286, 21)];
	self.identificationLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar.png"]];
	self.identificationLabel.font = [UIFont systemFontOfSize:16];
    self.identificationLabel.textColor =[UIColor colorWithRed:25/255.0f green:25/255.0f blue:112/255.0f alpha:1.0]; //[UIColor colorWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1.0];
	self.identificationLabel.text = @"Identification";
    self.identificationLabel.textAlignment = UITextAlignmentCenter;
    yPos = yPos + self.identificationLabel.frame.size.height;
	[scrollView addSubview:self.identificationLabel];
	
	
	
	 self.identificationTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, yPos, 286, 240)];
	 self.identificationTextView.userInteractionEnabled = NO;
	 self.identificationTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gradient-black-grey.png"]]; 
	 self.identificationTextView.textColor = [UIColor whiteColor];
        self.identificationTextView.font = [UIFont systemFontOfSize:14];
    yPos = yPos + self.identificationTextView.frame.size.height;
	 [scrollView addSubview:self.identificationTextView];
	}
    [scrollView setContentSize:CGSizeMake(0,yPos)];
	[self.bigFishButton addTarget:self action:@selector(bigFishTapped) forControlEvents:UIControlEventTouchUpInside];
    self.commonNameLabel.text = [[self.Temp objectAtIndex:0] titleText];
    self.scientificNameLabel.text = [[self.Temp objectAtIndex:0] scientificName];
    self.familyLabel.text = [[self.Temp objectAtIndex:0] familyName];
    self.rangeLabel.text = [[self.Temp objectAtIndex:0] fishRange];
    self.habitatLabel.text = [[self.Temp objectAtIndex:0] habitat];
    self.adultSizeLabel.text = [[self.Temp objectAtIndex:0] adultSize];
     self.identificationTextView.text = [[self.Temp objectAtIndex:0] identification];
     self.howToFishTextView.text = [[self.Temp objectAtIndex:0] howToFish];
  
//    int mID = [[[self.Temp objectAtIndex:0] modelObjectID] intValue];
//	
//	NSLog(@"Fish id = %d", mID);
//	NSNumber *number = [NSNumber numberWithInt:mID];
//	GameFish *fish;
//	fish = [CoreDataDAO fishFetchFishWithID:number withError:nil];
//	UIImage *image = [fish.image valueForKey:@"image"];
//    
//	NSLog(@"image URL from core data : %@", fish.imageURL);
//	if (!image) {
//        
//		image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fish.imageURL]]];
//        [fish.image setValue:image forKey:@"image"];
//		//[CoreDataDAO fishAddImage:image ForGameFish:fish];
//		[CoreDataDAO saveData];
//        
//	}
//	else {
//		image = [fish.image valueForKey:@"image"];
//	}
//    
//    
//	[self.bigFishButton setImage:image forState:UIControlStateNormal];
//    //    [self.bigFishButton setImage:image forState:UIControlStateSelected];
//    
}

- (void)bigFishTapped{
	FishDetailImageController *fishDetailImageController = [[FishDetailImageController alloc] init];
	fishDetailImageController.image = self.bigFishButton.imageView.image;
	[self.navigationController pushViewController:fishDetailImageController animated:YES];
	[fishDetailImageController release];
	
}
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];	
}

- (IBAction) bigFishButtonTapped{
	NSLog(@"Bigfish button was tapped");
	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setFirst:nil];
    [self setSecond:nil];
    [self setThird:nil];
    [self setFour:nil];
    [self setMyspiner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
