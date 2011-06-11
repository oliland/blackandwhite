//
//  MainViewController.h
//  Black and White
//
//  Created by Oli Kingshott on 11/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImagePickerController *imagePicker;
    IBOutlet UIImageView *photoView;
    IBOutlet UIButton *flipViewButton;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)displayCamera:(NSObject *)sender;

@property (nonatomic, retain) UIImageView *photoView;

@end
