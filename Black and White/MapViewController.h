//
//  MapViewController.h
//  Black and White
//
//  Created by James Wheatley on 11/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SBJsonParser.h"
#import <CoreLocation/CoreLocation.h>
#import "MapPin.h"

@protocol MapViewControllerDelegate;

@interface MapViewController : UIViewController {
    IBOutlet MKMapView *mapView;
    SBJsonParser *jsonparser;
}

@property (nonatomic, assign) id <MapViewControllerDelegate> delegate;

- (void)presentMap:(NSString *)photoID key:(NSString *)key;
- (IBAction)finished:(id)sender;

@end

@protocol MapViewControllerDelegate
- (void)mapViewControllerDidFinish:(MapViewController *)controller;
@end