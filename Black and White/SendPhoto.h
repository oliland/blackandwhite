//
//  SendPhoto.h
//  Black and White
//
//  Created by Oli Kingshott on 10/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SendPhoto : UIViewController {
    IBOutlet UIImageView *photo;
}

- (id)initWithPhoto:(UIImage *)image;

@property (nonatomic, retain) UIImage *theImage;

@end
