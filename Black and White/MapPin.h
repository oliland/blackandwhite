//
//  MapPin.h
//  Black and White
//
//  Created by James Wheatley on 11/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface MapPin : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (MapPin *)initWithCoord:(CLLocationCoordinate2D)theCoordinate;

@end
