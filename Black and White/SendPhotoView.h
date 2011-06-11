//
//  SendPhoto.h
//  Black and White
//
//  Created by Oli Kingshott on 10/06/2011.
//  Copyright 2011 Loud Street Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SendPhotoView;

@protocol SendPhotoViewDelegate
- (void)sendPhotoDidFinish:(SendPhotoView*)sendPhoto;
@end

@interface SendPhotoView : UIViewController {
    IBOutlet UIImageView *photoView;
}

@property (retain) id<SendPhotoViewDelegate> delegate;
//@property (nonatomic, retain) UIImageView *photoView;

@end
