//
//  MapListViewController.m
//  World-Fisher
//
//  Created by Qaisar on 4/10/2557 BE.
//
//

#import "MapListViewController.h"
#import "ASIHTTPRequest.h"
#import "RichListCell.h"
#import "Fish.h"
#import "NetworkReachability.h"
#import "DetailViewController.h"
#import "MBProgressHUD.h"
#import "CellView.h"
@interface MapListViewController ()

@end

@implementation MapListViewController
@synthesize myTableView;
@synthesize url,downloadQueue;
@synthesize fishArray,responseString;
@synthesize detailViewController;
@synthesize lati,longi,fisName;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [myTableView registerNib:[UINib nibWithNibName:@"CellView" bundle:nil] forCellReuseIdentifier:@"customCell"];
    
    
    static int count = 1;
	NSString *urlString = [NSString stringWithFormat:@"http://www.semanticdevlab.com/world_hunter/admin/mycatch-json.php?count=%d", count];
	NSLog(@"%@", urlString);
	self.url = [[NSURL alloc] initWithString:urlString];
	downloadQueue = [[NSOperationQueue alloc] init];
[self loadAnnotationData];
   
    
}
-(void)viewWillAppear:(BOOL)animated{


    [self.myTableView deselectRowAtIndexPath:[myTableView indexPathForSelectedRow] animated:YES];


}
- (void)loadAnnotationData
{
	// Check if the remote server is available
	NetworkReachability *reachManager = [NetworkReachability sharedReachability];
	[reachManager setHostName:@"www.google.com"];
	NetworkStatus remoteHostStatus = [reachManager remoteHostStatus];
	if (remoteHostStatus == NotReachable)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
														message:@"Network is not reachable! \nRetry?"
													   delegate:self
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil, nil];
		[alert show];
		[alert release];
		return;
	}
	else if (remoteHostStatus == ReachableViaWiFiNetwork)
	{
		[self.downloadQueue setMaxConcurrentOperationCount:4];
	}
	else if (remoteHostStatus == ReachableViaCarrierDataNetwork)
	{
		[self.downloadQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
	}
    NSLog(@"inside load Annotation data");
	[self fetchURLData];
}

- (void)fetchURLData{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:self.url];
	[request setDelegate:self];
	NSOperationQueue *queue = self.downloadQueue;
	[queue addOperation:request];
	[request release];
	[pool drain];

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	NSLog(@"This is the error %@", [error description]);
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Unable to Fetch data fom server. \n Please try again in a while" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

	NSLog(@"inside pinish");
	if (responseString)
		[responseString release];
	responseString = [[NSString alloc] initWithString:[request responseString]];
    	NSLog(@"response is %@",responseString);
	NSArray *array = [[responseString JSONValue] replaceNullWithNilInDictionary];
  	fishArray = [[NSMutableArray alloc] initWithArray:array];
//
//    for (int i=0; i<array.count; i++) {
//    	  NSMutableDictionary *dic = [array objectAtIndex:i];
//		Fish *fish = [[Fish alloc] init];
//	   fish.name = [dic objectForKey:@"catch_name"];
//
////		fish.lat = [[dic objectForKey:@"latitude"] doubleValue];
////		fish.lng = [[dic objectForKey:@"longitude"] doubleValue];
////		NSLog(@" Fish Name : %@ latitude -> %f",fish.name, fish.lat);
////		NSLog(@" longitude -> %f ", fish.lng);
//		[fishArray addObject:fish];
//		
////		ParkPlaceMark *placemarks = [[ParkPlaceMark alloc] initWithLat:fish.lat lon:fish.lng];
////		placemarks.title = fish.name;
////		[mapAnnotations addObject:placemarks];
////		
//		[fish release];
////		//TODO:check this code
////		[placemarks release];
////	}
////    [self.mapView addAnnotations:mapAnnotations];
//}
    
    [myTableView reloadData];
}




//.........Table Delegate Methods..................//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [fishArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	static NSString *CellIdentifier = @"customCell";
	CellView *cell = (CellView *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		cell =  [[[CellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
	}
     NSMutableDictionary *dic=[self.fishArray objectAtIndex:indexPath.row];
    
// NSLog(@"%@",d);
    
    
    //if(fish.name)
    cell.name.text=[dic objectForKey:@"catch_name"];
      //  cell.textLabel.text=[dic objectForKey:@"catch_name"];
    self.fisName=[dic objectForKey:@"catch_name"];
    self.lati=[[dic objectForKey:@"latitude"] doubleValue];
    self.longi=[[dic objectForKey:@"longitude"] doubleValue];
  //  cell.backgroundColor=[UIColor grayColor];
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ParkPlaceMark *placemarks = [[ParkPlaceMark alloc] initWithLat:self.lati lon:self.longi];
//    placemarks.title = fisName;
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController-ipad" bundle:nil];
    else
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    NSMutableDictionary *dic=[self.fishArray objectAtIndex:indexPath.row];
    
    // NSLog(@"%@",d);
    
    
    //if(fish.name)
//   cell.name.text=[dic objectForKey:@"catch_name"];
    //  cell.textLabel.text=[dic objectForKey:@"catch_name"];
//    self.fisName=[dic objectForKey:@"catch_name"];
    self.detailViewController.Latitude=[[dic objectForKey:@"latitude"] doubleValue];
    self.detailViewController.Longitude=[[dic objectForKey:@"longitude"] doubleValue];

    [self.navigationController pushViewController:self.detailViewController animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [myTableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMyTableView:nil];
    [super viewDidUnload];
}
@end
