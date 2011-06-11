//
//  MapViewController.m
//  Black and White
//
//  Created by James Wheatley on 11/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)presentMap:(NSString *)photoID key:(NSString *)key
{
    // Build the string to call the Flickr API
    NSString *urlString = 
    [NSString stringWithFormat:
     @"http://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=%@&photo_id=%@&format=json&nojsoncallback=1", key, photoID];
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
    
    NSDictionary *photo = [results objectForKey:@"photo"];
    NSDictionary *geoData = [photo objectForKey:@"location"];
    
    CLLocationCoordinate2D location;
    location.latitude = [[geoData objectForKey:@"latitude"] doubleValue];
    location.longitude = [[geoData objectForKey:@"longitude"] doubleValue];
    NSLog(@"%f %f", location.latitude, location.longitude);
    
    MapPin *pin = [[MapPin alloc] initWithCoord:location];
    [mapView addAnnotation:pin];
    [mapView setCenterCoordinate:location animated:YES];
}

- (IBAction)finished:(id)sender
{
    [self.delegate mapViewControllerDidFinish:self];
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
    [super viewDidLoad];
    jsonparser = [[SBJsonParser alloc] init];
    mapView.mapType = MKMapTypeSatellite;
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
