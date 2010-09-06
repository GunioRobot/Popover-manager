//
//  UIPopoverManager.m
//  PopoverManager
//
//  Created by Igor Fedorov on 9/5/10.
//  Copyright 2010 Flash/Flex, iPhone developer at Postindustria. All rights reserved.
//

#import "UIPopoverManager.h"

#define CHANGE_ORIENTATION_DURATION 0.33f

#define LOG_FUNC NSLog(@"%s [Line %d] ", __PRETTY_FUNCTION__, __LINE__);

@implementation UIView(PopoverTarget)

@end

@interface UIPopoverManager(Private)

static UIPopoverManager *sharedManager;

+ (UIPopoverManager*)sharedManager;

- (void)setDefaults;

- (CGRect)targetFrameWithIdent;

- (void)presentPopover;

- (void)dismissPopover;

- (void)orientationDidChange:(NSDictionary*)notification;

- (void)addRotationObserving;

- (void)removeRotationObserving;

- (void)showControllerInPopover:(UIViewController*)aController inView:(UIView*)aView forTarget:(id<PopoverTarget>)aTargetView dismissTarget:(id)aDismissTarget dismissSelector:(SEL)aDismissSelector;

@end

@implementation UIPopoverManager(Private)

+ (UIPopoverManager*)sharedManager {
	@synchronized(self) {
		if (sharedManager == nil) {
			sharedManager = [[self alloc] init];
		}
	}
	return sharedManager;
}

- (void)setDefaults {
	arrowDirection = UIPopoverArrowDirectionAny;
	ident = 0.0;
}

- (CGRect)targetFrameWithIdent {
	return CGRectInset(targetView.frame, -ident, -ident);
}

- (void)presentPopover {
	if (targetView == nil) {
		return;
	}
	[self.popover presentPopoverFromRect:[self targetFrameWithIdent]
								  inView:viewForPopover
				permittedArrowDirections:arrowDirection
								animated:YES];
}

- (void)dismissPopover {
	if (self.popover != nil && self.popover.popoverVisible) {
		[self.popover dismissPopoverAnimated:NO];
	}
}

- (void)orientationDidChange:(id)notification {
	LOG_FUNC
	[self dismissPopover];
	UIDeviceOrientation toOrientation = [[UIApplication sharedApplication] statusBarOrientation];
	NSTimeInterval duration = CHANGE_ORIENTATION_DURATION;
	if (UIDeviceOrientationIsPortrait(currentOrientation)) {
		if (UIDeviceOrientationIsPortrait(toOrientation)) {
			duration += CHANGE_ORIENTATION_DURATION;
		}
	} else {
		if (UIDeviceOrientationIsLandscape(toOrientation)) {
			duration += CHANGE_ORIENTATION_DURATION;
		}
	}
	currentOrientation = toOrientation;
	
	[self performSelector:@selector(presentPopover) withObject:nil afterDelay:duration];
}

- (void)addRotationObserving {
	LOG_FUNC
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(orientationDidChange:)
												 name:UIApplicationDidChangeStatusBarOrientationNotification 
											   object:nil];
}

- (void)removeRotationObserving {
	LOG_FUNC
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showControllerInPopover:(UIViewController*)aController 
						 inView:(UIView*)aView 
					  forTarget:(id<PopoverTarget>)aTargetView 
				  dismissTarget:(id)aDismissTarget 
				dismissSelector:(SEL)aDismissSelector {
	LOG_FUNC
	[self dismissPopover];
	targetView = aTargetView;
	viewForPopover = aView;
	dismissTarget = aDismissTarget;
	dismissSelector = aDismissSelector;
	UIPopoverController *newPopover = [[UIPopoverController alloc] initWithContentViewController:aController];
	self.popover = newPopover;
	[newPopover release];
	[self.popover setDelegate:self];
	[self addRotationObserving];
	[self presentPopover];
}

@end

@implementation UIPopoverManager

@synthesize popover=_popover;

+ (void)end {
	[[UIPopoverManager sharedManager] release];
}

+ (UIPopoverController*)currentPopover {
	return [[UIPopoverManager sharedManager] popover];
}

+ (void)setArrowDirection:(UIPopoverArrowDirection)aDirection {
	[UIPopoverManager sharedManager]->arrowDirection = aDirection;
}

+ (void)setIndent:(float)aValue {
	[UIPopoverManager sharedManager]->ident = aValue;
}

+ (void)showControllerInPopover:(UIViewController*)aController inView:(UIView*)aView forTarget:(id<PopoverTarget>)aTargetView {
	[UIPopoverManager showControllerInPopover:aController inView:aView forTarget:aTargetView dismissTarget:nil dismissSelector:NULL];
}

+ (void)showControllerInPopover:(UIViewController*)aController inView:(UIView*)aView forTarget:(id<PopoverTarget>)aTargetView dismissTarget:(id)aDismissTarget dismissSelector:(SEL)aDismissSelector {
	[[UIPopoverManager sharedManager] showControllerInPopover:aController inView:aView forTarget:aTargetView dismissTarget:aDismissTarget dismissSelector:aDismissSelector];
}

#pragma mark -
#pragma mark UIPopoverControllerDelegate methods

- (id)init {
	if ((self = [super init])) {
		currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
		[self setDefaults];
	}
	return self;
}

- (void)dealloc {
	[self dismissPopover];
	self.popover = nil;
	[super dealloc];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
	LOG_FUNC;
	[self removeRotationObserving];
	if ([dismissTarget respondsToSelector:dismissSelector]) {
		[dismissTarget performSelector:dismissSelector];
	}
	
	self.popover = nil;
	[self setDefaults];
}

@end
