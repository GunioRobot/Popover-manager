//
//  UIPopoverManager.h
//  PopoverManager
//
//  Created by Igor Fedorov on 9/5/10.
//  Copyright 2010 Flash/Flex, iPhone developer at Postindustria. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopoverTarget <NSObject>

- (CGRect)frame;
- (CGPoint)center;

@end

@interface UIView(UIPopoverTarget) <PopoverTarget>

@end

@interface UIPopoverManager : NSObject <UIPopoverControllerDelegate> {
	UIPopoverController *_popover;
	UIView *viewForPopover;
	id <PopoverTarget> targetView;
	id dismissTarget;
	CGSize ident;
	SEL dismissSelector;
	UIDeviceOrientation currentOrientation;
	UIPopoverArrowDirection arrowDirection;
}

@property (nonatomic, retain) UIPopoverController *popover;

+ (void)end;

+ (UIPopoverController*)currentPopover;

+ (void)setIndent:(float)aValue;

+ (void)setIndentX:(float)x andY:(float)y;

+ (void)setArrowDirection:(UIPopoverArrowDirection)aDirection;

+ (void)showControllerInPopover:(UIViewController*)aController inView:(UIView*)aView forTarget:(id<PopoverTarget>)aTargetView;

+ (void)showControllerInPopover:(UIViewController*)aController inView:(UIView*)aView forTarget:(id<PopoverTarget>)aTargetView dismissTarget:(id)aDismissTarget dismissSelector:(SEL)aDismissSelector;

+ (void) dismissPopover;

@end