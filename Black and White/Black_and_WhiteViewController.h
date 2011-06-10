//
//  Black_and_WhiteViewController.h
//  Black and White
//
//  Created by James Wheatley on 10/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Black_and_WhiteViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UIButton *photoButton;
    UIImagePickerController *imagePicker;
}

- (IBAction)displayCamera:(NSObject *)sender;

@end
