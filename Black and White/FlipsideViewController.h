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
#import "MapViewController.h"

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController<CLLocationManagerDelegate, UIScrollViewDelegate, MapViewControllerDelegate> {
    SBJsonParser *jsonparser;
    NSURLConnection *photosCon;
    CLLocationDegrees minLon, minLat, maxLon, maxLat;
    NSString *photoID;
    IBOutlet UIImageView *imageView;
    IBOutlet UIScrollView *scrollView;
    double currentMargin;
    int photoNum;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, assign) CLLocation *currentLocation;
@property (nonatomic, assign) CLLocationManager *locationManager;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;

- (IBAction)done:(id)sender;
- (IBAction)showMap:(id)sender;
- (void)searchFlickrPhotos:(double)margin;
//- (IBAction)clicked:(id)sender;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
