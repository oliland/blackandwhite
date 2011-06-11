//
//  MapPin.m
//  Black and White
//
//  Created by James Wheatley on 11/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapPin.h"


@implementation MapPin

@synthesize coordinate;

- (MapPin *)initWithCoord:(CLLocationCoordinate2D)theCoordinate
{
    [super init];
    coordinate = theCoordinate;
    return self;
}

@end
