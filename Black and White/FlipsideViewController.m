//
//  FlipsideViewController.m
//  Black and White
//
//  Created by Oli Kingshott on 11/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

NSString *const FlickrAPIKey = @"da6619cd8f7a71642b9490cf81c6dbbd";
NSString *const FlickrToken = @"72157626931862392-cb6c5d731bcfa154";

@synthesize delegate=_delegate, currentLocation, locationManager;

-(void)searchFlickrPhotos
{
    CLLocationDegrees newLat, newLon;
    newLat = currentLocation.coordinate.latitude;
    newLon = currentLocation.coordinate.longitude;
    
    // Build the string to call the Flickr API
    NSString *urlString = 
    [NSString stringWithFormat:
     @"http://api.flickr.com/services/rest/?method=flickr.places.findByLatLon&api_key=%@&lat=%f&lon=%f&accuracy=6&format=json&nojsoncallback=1", FlickrAPIKey, newLat, newLon];
    NSLog(@"URLString is %@", urlString);
    // Create NSURL string from formatted string
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection release];
    [request release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    // Store incoming data into a string
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Json: %@", jsonString);
    
    // Create a dictionary from the JSON string
    NSDictionary *results = [jsonparser objectWithString:jsonString error:nil];
    
    if ([results objectForKey:@"places"] == nil)
    {
        NSArray *place = [[results objectForKey:@"places"] objectForKey:@"place"];
        NSString *placeID = [[place objectAtIndex:0] objectForKey:@"place_id"];
        
        // Build the string to call the Flickr API
        NSString *urlString = 
        [NSString stringWithFormat:
         @"http://api.flickr.com/services/rest/?method=flickr.photos.search&place_id=%@&min_upload_date=%@&format=json&nojsoncallback=1", FlickrAPIKey, placeID, "2006"];
        
        // Create NSURL string from formatted string
        NSURL *url = [NSURL URLWithString:urlString];
        
        // Setup and start async download
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection release];
        [request release];
    } else if ([results objectForKey:@"photos"] != nil)
    {
        
    } else
    {
        
    }
    /*
     // Build an array from the dictionary for easy access to each entry
     NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
     
     // Loop through each entry in the dictionary...
     for (NSDictionary *photo in photos)
     {
     // Get title of the image
     NSString *title = [photo objectForKey:@"title"];
     
     // Save the title to the photo titles array
     [photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
     
     // Build the URL to where the image is stored (see the Flickr API)
     // In the format http://farmX.static.flickr.com/server/id_secret.jpg
     // Notice the "_s" which requests a "small" image 75 x 75 pixels
     NSString *photoURLString = 
     [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", 
     [photo objectForKey:@"farm"], [photo objectForKey:@"server"], 
     [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
     
     NSLog(@"photoURLString: %@", photoURLString);
     
     // The performance (scrolling) of the table will be much better if we
     // build an array of the image data here, and then add this data as
     // the cell.image value (see cellForRowAtIndexPath:)
     [photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
     
     // Build and save the URL to the large image so we can zoom
     // in on the image if requested
     photoURLString = 
     [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", 
     [photo objectForKey:@"farm"], [photo objectForKey:@"server"], 
     [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
     [photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];        
     
     NSLog(@"photoURLsLareImage: %@\n\n", photoURLString); 
     }
     */
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if(currentLocation == nil) {
        [locationManager stopUpdatingLocation];
        currentLocation = newLocation;
        [self searchFlickrPhotos];
    }
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
    
    jsonparser = [[SBJsonParser alloc] init];

    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end