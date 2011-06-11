//
//  MainViewController.h
//  Black and White
//
//  Created by Oli Kingshott on 11/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import "FlipsideViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate> {
    UIImagePickerController *imagePicker;
    IBOutlet UIImageView *photoView;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)displayCamera:(NSObject *)sender;

@property (nonatomic, retain) UIImageView *photoView;

@end
