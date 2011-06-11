//
//  FlipsideViewController.h
//  Black and White
//
//  Created by Oli Kingshott on 11/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol FlipsideViewControllerDelegate;

@interface FlipsideViewController : UIViewController<CLLocationManagerDelegate> {

}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, assign) CLLocation *currentLocation;
@property (nonatomic, assign) CLLocationManager *locationManager;

- (IBAction)done:(id)sender;
- (void)searchFlickrPhotos;

@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
