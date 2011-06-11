//
//  FlipsideViewController.h
//  Black and White
//
//  Created by Oli Kingshott on 11/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SBJsonParser.h"

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController<CLLocationManagerDelegate> {
    SBJsonParser *jsonparser;
    NSURLConnection *lastCon;
    CLLocationDegrees minLon, minLat, maxLon, maxLat;
    IBOutlet UIImageView *imageView;
    IBOutlet UIActivityIndicatorView *indicator;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, assign) CLLocation *currentLocation;
@property (nonatomic, assign) CLLocationManager *locationManager;

- (IBAction)done:(id)sender;
- (void)searchFlickrPhotos:(double)margin;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
