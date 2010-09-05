//
//  PopoverManagerAppDelegate.h
//  PopoverManager
//
//  Created by Igor Fedorov on 9/5/10.
//  Copyright Flash/Flex, iPhone developer at Postindustria 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopoverManagerViewController;

@interface PopoverManagerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PopoverManagerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PopoverManagerViewController *viewController;

@end

