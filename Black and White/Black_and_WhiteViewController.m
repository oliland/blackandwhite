//
//  Black_and_WhiteViewController.m
//  Black and White
//
//  Created by James Wheatley on 10/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Black_and_WhiteViewController.h"

@implementation Black_and_WhiteViewController

- (void)dealloc
{
    [sendPhoto release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)displayCamera:(NSObject *)sender
{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage, *editedImage;
    originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
    sendPhoto = [[SendPhotoView alloc] initWithNibName:@"SendPhoto" bundle:nil];
    sendPhoto.delegate = self;
    if (editedImage) {
        sendPhoto.theImage = editedImage;
    } else {
        sendPhoto.theImage = originalImage;
    }
    [self dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void) viewDidAppear: (BOOL) animated
{
    if (sendPhoto.theImage)
    {
        [self presentModalViewController:sendPhoto animated:NO];
    }
    if (returnPhoto.currentLocation) {
        [self presentModalViewController:returnPhoto animated:NO];
    }
}

- (void)sendPhotoDidFinish:(SendPhotoView *)_sendPhoto withLocation:(CLLocation *)location withError:(NSString *)error {
    [[_sendPhoto parentViewController] dismissModalViewControllerAnimated:YES];
    [sendPhoto release];
    if (location) {
        returnPhoto = [[ReturnPhotoView alloc] initWithNibName:@"ReturnPhoto" bundle:nil];
        returnPhoto.currentLocation = location;
        //returnPhoto.delegate = self;
        [self dismissModalViewControllerAnimated:YES];
    }
    errorMessage.text = error;
}

@end
