//
//  Black_and_WhiteViewController.m
//  Black and White
//
//  Created by James Wheatley on 10/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Black_and_WhiteViewController.h"

@implementation Black_and_WhiteViewController

@synthesize theImage;

- (void)dealloc
{
    [theImage release];
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
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [self presentModalViewController:imagePicker animated:YES];
    } else {
        NSLog(@"Camera not found");
    }
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
    if (editedImage) {
        theImage = editedImage;
    } else {
        theImage = originalImage;
    }
    [self dismissModalViewControllerAnimated:YES];
    [picker release];
}

- (void) viewDidAppear: (BOOL) animated
{
    if (theImage)
    {
        sendPhoto = [[SendPhotoView alloc] initWithNibName:@"SendPhoto" bundle:nil];
        sendPhoto.delegate = self;
        //sendPhoto.photoView.image = theImage;
        [self presentModalViewController:sendPhoto animated:NO];
    }
}

- (void)sendPhotoDidFinish:(SendPhotoView *)_sendPhoto {
    [[_sendPhoto parentViewController] dismissModalViewControllerAnimated:YES];
    [sendPhoto release];
}

@end
