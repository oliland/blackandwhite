//
//  Black_and_WhiteViewController.h
//  Black and White
//
//  Created by Oli Kingshott on 10/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SBJsonIncludes.h"

@interface ReturnPhoto : UIViewController {
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    CLLocation      *currentLoc;
}

-(void)searchFlickrPhotos:(NSString *)text;
- (void)getPlace:(CLLocation *)location;

@end
