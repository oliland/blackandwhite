//
//  SendPhoto.h
//  Black and White
//
//  Created by Oli Kingshott on 10/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class SendPhotoView;

@protocol SendPhotoViewDelegate
- (void)sendPhotoDidFinish:(SendPhotoView*)sendPhoto withLocation:(CLLocation *)location withError:(NSString *)error;
@end

@interface SendPhotoView : UIViewController<CLLocationManagerDelegate> {
    IBOutlet UIImageView *photoView;
    UIImage *theImage;
    CLLocationManager *locationManager;
}

@property (retain) id<SendPhotoViewDelegate> delegate;
@property (nonatomic, retain) UIImageView *photoView;
@property (nonatomic, retain) UIImage *theImage;
@property (nonatomic, retain) CLLocation *bestEffortAtLocation;

@end
