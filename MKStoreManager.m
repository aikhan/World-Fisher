

#import "MKStoreManager.h"
#import "World_FisherAppDelegate.h"

@implementation MKStoreManager

@synthesize purchasableObjects;
@synthesize storeObserver;

// all your features should be managed one and only by StoreManager
//static NSString *featureAId = @"com.goliathlabz.mobiconz.movies.purchase25";
//static NSString *featureBId = @"com.goliathlabz.mobiconz.movies.purchase50";


static NSString *featureAId = @"com.product.product1"; //non
static NSString *featureBId = @"com.product.product2"; //non
static NSString *featureCId = @"com.product.product3"; //non
static NSString *featureDId = @"com.product.product4"; //non
static NSString *featureEId = @"com.product.product5"; //non
static NSString *featureFId = @"com.product.product6"; //con
static NSString *featureGId = @"com.product.product7"; //con
static NSString *featureHId = @"com.semanticnotion.worldfisherfree.removeads"; //non


//static NSString *featureAId = @"com.elephantlite.stageclear";
//static NSString *featureBId = @"com.elephantlite.stageclear";

BOOL featureAPurchased = false;
BOOL featureBPurchased = false;
BOOL featureCPurchased = false;
BOOL featureDPurchased = false;
BOOL featureEPurchased = false;
BOOL featureFPurchased = false;	
BOOL featureGPurchased = false;
BOOL featureHPurchased = false;

static MKStoreManager* _sharedStoreManager; // self

- (void)dealloc {
	
	[_sharedStoreManager release];
	[storeObserver release];
	[super dealloc];
}

+ (BOOL) featureAPurchased {
	
	return featureAPurchased;
}

+ (BOOL) featureBPurchased {
	
	return featureBPurchased;
}

+ (BOOL) featureCPurchased {
	
	return featureCPurchased;
}

+ (BOOL) featureDPurchased {
	
	return featureDPurchased;
}

+ (BOOL) featureEPurchased {
	
	return featureEPurchased;
}

+ (BOOL) featureFPurchased
{
    return featureFPurchased;
}

+ (BOOL) featureGPurchased
{
    return featureGPurchased;
}

+ (MKStoreManager*)sharedManager
{
	@synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            [[self alloc] init]; // assignment not done here
			_sharedStoreManager.purchasableObjects = [[NSMutableArray alloc] init];
			[_sharedStoreManager requestProductData];
			
			[MKStoreManager loadPurchases];
			_sharedStoreManager.storeObserver = [[MKStoreObserver alloc] init];
			[[SKPaymentQueue defaultQueue] addTransactionObserver:_sharedStoreManager.storeObserver];
        }
    }
    return _sharedStoreManager;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone

{
    @synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            _sharedStoreManager = [super allocWithZone:zone];
            return _sharedStoreManager;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}


- (void) requestProductData
{
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:
								 [NSSet setWithObjects: featureAId, featureBId, featureCId, featureDId, featureEId, featureFId, featureGId, featureHId, nil]]; // add any other product here
	request.delegate = self;
	[request start];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
	[purchasableObjects addObjectsFromArray:response.products];
	// populate your UI Controls here
	for(int i=0;i<[purchasableObjects count];i++)
	{
		
		SKProduct *product = [purchasableObjects objectAtIndex:i];
		NSLog(@"Feature: %@, Cost: %f, ID: %@",[product localizedTitle],
			  [[product price] doubleValue], [product productIdentifier]);
	}
	
	[request autorelease];
}

- (void) buyFeatureA
{
    featureAPurchased = NO;
	[self buyFeature:featureAId];
}

- (void) buyFeatureB
{
    featureBPurchased = NO;
	[self buyFeature:featureBId];
    
}

- (void) buyFeatureC
{
    featureCPurchased = NO;
	[self buyFeature:featureCId];
}

- (void) buyFeatureD
{
    featureDPurchased = NO;
	[self buyFeature:featureDId];
}

- (void) buyFeatureE
{
    featureEPurchased = NO;
	[self buyFeature:featureEId];
}

- (void) buyFeatureF
{
    featureFPurchased = NO;
	[self buyFeature:featureFId];
}

- (void) buyFeatureG
{
    featureGPurchased = NO;
	[self buyFeature:featureGId];
}

- (void) buyFeatureH
{
    featureHPurchased = NO;
	[self buyFeature:featureHId];
}

- (void) buyFeature:(NSString*) featureId
{
    //    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
	if ([SKPaymentQueue canMakePayments])
	{
        
		SKPayment *payment = [SKPayment paymentWithProductIdentifier:featureId];
        //        [payment.quantity ];
        NSLog(@"******* %d", [payment quantity]);
		[[SKPaymentQueue defaultQueue] addPayment:payment];
	}
	else
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MyApp" message:@"You are not authorized to purchase from AppStore"
													   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
		[alert show];
		[alert release];
        
        
	}
}

-(void) alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   }

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	NSString *messageToBeShown = [NSString stringWithFormat:@"Reason: %@, You can try: %@", [transaction.error localizedFailureReason], [transaction.error localizedRecoverySuggestion]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to complete your purchase" message:messageToBeShown
												   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	[alert release];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ForFailView" object:self];

}

-(void) provideContent: (NSString*) productIdentifier
{
    World_FisherAppDelegate* app = ( World_FisherAppDelegate *)[UIApplication sharedApplication].delegate;
    
	if([productIdentifier isEqualToString:featureAId])
    {
		featureAPurchased = YES;
        [app setEnableStageIndex:1 State:YES];
    }
    
	if([productIdentifier isEqualToString:featureBId])
    {
		featureBPurchased = YES;
        [app setEnableStageIndex:2 State:YES];
    }
	if([productIdentifier isEqualToString:featureCId])
    {
		featureBPurchased = YES;
        [app setEnableStageIndex:3 State:YES];
    }
	if([productIdentifier isEqualToString:featureDId])
    {
		featureBPurchased = YES;
        [app setEnableStageIndex:4 State:YES];
    }
	if([productIdentifier isEqualToString:featureEId])
    {
		featureBPurchased = YES;
        [app setEnableStageIndex:5 State:YES];
    }
    
    if([productIdentifier isEqualToString:featureFId])
    {
		featureFPurchased = YES;
        [app setHintCounts:4];
    }
    
    if([productIdentifier isEqualToString:featureGId])
    {
		featureGPurchased = YES;
        
        [app setHintCounts:12];
    }
    
    if([productIdentifier isEqualToString:featureHId])
    {
		featureHPurchased = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ForMainViews" object:self];
      //  [app setHintCounts:12];
    }
    
	[MKStoreManager updatePurchases];
}


+(void) loadPurchases
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	featureAPurchased = [userDefaults boolForKey:featureAId];
	featureBPurchased = [userDefaults boolForKey:featureBId];
	featureCPurchased = [userDefaults boolForKey:featureCId];
	featureDPurchased = [userDefaults boolForKey:featureDId];
	featureEPurchased = [userDefaults boolForKey:featureEId];
	featureFPurchased = [userDefaults boolForKey:featureFId];
	featureGPurchased = [userDefaults boolForKey:featureGId];
    featureHPurchased = [userDefaults boolForKey:featureHId];
    
}


+(void) updatePurchases
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
	[userDefaults setBool:featureAPurchased forKey:featureAId];
	[userDefaults setBool:featureBPurchased forKey:featureBId];
	[userDefaults setBool:featureCPurchased forKey:featureCId];
	[userDefaults setBool:featureDPurchased forKey:featureDId];
	[userDefaults setBool:featureEPurchased forKey:featureEId];
	[userDefaults setBool:featureFPurchased forKey:featureFId];
	[userDefaults setBool:featureGPurchased forKey:featureGId];
	[userDefaults setBool:featureHPurchased forKey:featureHId];
    
}

- (void) restore
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}
@end
