//
//  Black_and_WhiteAppDelegate.h
//  Black and White
//
//  Created by James Wheatley on 10/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Black_and_WhiteViewController;

@interface Black_and_WhiteAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Black_and_WhiteViewController *viewController;

@end
