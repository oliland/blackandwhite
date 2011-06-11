//
//  Black_and_WhiteViewController.h
//  Black and White
//
//  Created by James Wheatley on 10/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SendPhotoView.h"
#import "ReturnPhotoView.h"

@interface Black_and_WhiteViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SendPhotoViewDelegate> {
    IBOutlet UIButton *photoButton;
    UIImagePickerController *imagePicker;
    SendPhotoView *sendPhoto;
    ReturnPhotoView *returnPhoto;
    IBOutlet UILabel *errorMessage;
}

- (IBAction)displayCamera:(NSObject *)sender;

@end
