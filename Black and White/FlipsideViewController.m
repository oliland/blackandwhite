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

@synthesize delegate=_delegate, currentLocation, locationManager, scrollView, imageView;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imageView;
}

-(void)searchFlickrPhotos:(double)margin
{
    CLLocationDegrees newLon, newLat;
    newLon = currentLocation.coordinate.longitude;
    if (newLon < 0)
        newLon = newLon + 180;
    else
        newLon = newLon - 180;
    newLat = currentLocation.coordinate.latitude * -1;
    
    minLon = newLon - (margin * 2);
    if (minLon < -180)
        minLon = -180;
    
    minLat = newLat - margin;
    if (minLat < -90)
        minLat = -90;
    
    maxLon = newLon + (margin * 2);
    if (maxLon > 180)
        maxLon = 180;
    
    maxLat = newLat + (margin * 2);
    if (maxLat > 90)
        maxLat = 90;
    
    NSLog(@"lat = %f", newLat);
    NSLog(@"lon = %f", newLon);
    
    // Build the string to call the Flickr API
    NSString *urlString = 
    [NSString stringWithFormat:
     @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&bbox=%f,%f,%f,%f&min_upload_date=2004&&per_page=10&format=json&nojsoncallback=1", FlickrAPIKey, minLon, minLat, maxLon, maxLat];
    NSLog(@"URLString is %@", urlString);
    // Create NSURL string from formatted string
    NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    photosCon = connection;
    [photosCon retain];
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
    
    if (connection == photosCon) {
        NSLog(@"INCOMING PHOTOS!");
        
        NSDictionary *data = [results objectForKey:@"photos"];
        //NSNumber *pages = [data objectForKey:@"pages"];
        NSString *totalStr = [data objectForKey:@"total"];
        int totalNum = [totalStr intValue];
        
        if ((totalNum >= 100) && (currentMargin <= 45)) {
            //int page = (arc4random() % ([pages intValue] - 1)) + 1;
            
            photoNum = (arc4random() % totalNum) + 1;
            int page = photoNum / 10;
            // Build the string to call the Flickr API
            NSString *urlString = 
            [NSString stringWithFormat:
             @"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&bbox=%f,%f,%f,%f&min_upload_date=2004&&per_page=10&page=%d&format=json&nojsoncallback=1", FlickrAPIKey, minLon, minLat, maxLon, maxLat, page];
            NSLog(@"URLString is %@", urlString);
            // Create NSURL string from formatted string
            NSURL *url = [NSURL URLWithString:urlString];
            
            // Setup and start async download
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection release];
            [request release];
        } else if (currentMargin > 45) {
            NSLog(@"Not enough photos found. There must be a problem with Flickr");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't find any photos! Are you connected to the Internet?"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"I fucked up, not the app"
                                                  otherButtonTitles:nil];
            [alert autorelease];
            [alert show];
        } else {
            currentMargin += 5;
            [self searchFlickrPhotos:currentMargin];
        }
    } else {
        NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
        int photoOnPage = photoNum % 10;
        NSDictionary *photo = [photos objectAtIndex:photoOnPage];
        
        NSString *photoURLString = 
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_b.jpg", 
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"], 
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        NSLog(@"%@", photoURLString);
        NSLog(@"%f", currentMargin);
        
        [photoID release];
        photoID = [photo objectForKey:@"id"];
        [photoID retain];
        
        UIImage *thePhoto = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        imageView.image = thePhoto;
        [imageView sizeToFit];
    }
}

- (IBAction)showMap:(id)sender
{
    MapViewController *mapController = [[MapViewController alloc] init];
    mapController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    mapController.delegate = self;
    [mapController presentMap:photoID key:FlickrAPIKey];
    [self presentModalViewController:mapController animated:YES];
    [mapController release];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if(currentLocation == nil) {
        [locationManager stopUpdatingLocation];
        currentLocation = newLocation;
        [currentLocation retain];
        currentMargin = 2.5;
        [self searchFlickrPhotos:currentMargin];
    }
}

- (void)dealloc
{
    [imageView release];
    [scrollView release];
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
    
    scrollView.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
    scrollView.maximumZoomScale = 4.0;
    scrollView.minimumZoomScale = 0.75;
    scrollView.clipsToBounds = YES;
    scrollView.delegate = self;
    [scrollView addSubview:imageView];
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

- (void)mapViewControllerDidFinish:(MapViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
