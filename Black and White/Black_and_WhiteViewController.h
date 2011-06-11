//
//  Black_and_WhiteViewController.h
//  Black and White
//
//  Created by James Wheatley on 10/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendPhotoView.h"

@interface Black_and_WhiteViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, SendPhotoViewDelegate> {
    IBOutlet UIButton *photoButton;
    UIImagePickerController *imagePicker;
    SendPhotoView *sendPhoto;
}

@property (nonatomic, retain) UIImage *theImage;

- (IBAction)displayCamera:(NSObject *)sender;

@end
