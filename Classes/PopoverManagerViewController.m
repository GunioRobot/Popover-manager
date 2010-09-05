//
//  PopoverManagerViewController.m
//  PopoverManager
//
//  Created by Igor Fedorov on 9/5/10.
//  Copyright Flash/Flex, iPhone developer at Postindustria 2010. All rights reserved.
//

#import "PopoverManagerViewController.h"
#import "UIPopoverManager.h"

@implementation PopoverManagerViewController

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (void)textOutClear {
	textOut.text = @"";
}

- (void)textOutSetText {
	textOut.text = @"text updated";
}

- (void)showSecondPopover:(id)sender {
	[self textOutClear];
	UIButton *targetButton = (UIButton*)sender;
	UITableViewController *tableController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
	[tableController setContentSizeForViewInPopover:CGSizeMake(320, 400)];
	[UIPopoverManager showControllerInPopover:tableController
									   inView:self.view
									forTarget:targetButton
								dismissTarget:self
							  dismissSelector:@selector(textOutSetText)];
	[tableController release];
}

- (void)showPopover:(id)sender {
	[self textOutClear];
	UIButton *targetButton = (UIButton*)sender;
	UITableViewController *tableController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
	[tableController setContentSizeForViewInPopover:CGSizeMake(320, 400)];
	[UIPopoverManager setArrowDirection:UIPopoverArrowDirectionUp];
	[UIPopoverManager setIndent:30.0];
	[UIPopoverManager showControllerInPopover:tableController inView:self.view forTarget:targetButton];
	[tableController release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	textOut = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 50)];
	[self.view addSubview:textOut];
	[textOut release];
	
	UIButton *showPopoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showPopoverButton setFrame:CGRectMake(0, 0, 140, 40)];
	[showPopoverButton setTitle:@"show popover"	forState:UIControlStateNormal];
	[showPopoverButton setCenter:self.view.center];
	[showPopoverButton setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin ||
											UIViewAutoresizingFlexibleLeftMargin ||
											UIViewAutoresizingFlexibleBottomMargin ||
											UIViewAutoresizingFlexibleTopMargin)];
	[showPopoverButton addTarget:self action:@selector(showPopover:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:showPopoverButton];
	
	UIButton *showSecondPopoverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[showSecondPopoverButton setFrame:CGRectMake(0, 60, 200, 40)];
	[showSecondPopoverButton setTitle:@"show second popover"	forState:UIControlStateNormal];
	[showSecondPopoverButton setCenter: CGPointMake(self.view.center.x + showSecondPopoverButton.frame.origin.x, self.view.center.y + showSecondPopoverButton.frame.origin.y) ];
	[showSecondPopoverButton setAutoresizingMask:(UIViewAutoresizingFlexibleRightMargin ||
											UIViewAutoresizingFlexibleLeftMargin ||
											UIViewAutoresizingFlexibleBottomMargin ||
											UIViewAutoresizingFlexibleTopMargin)];
	[showSecondPopoverButton addTarget:self action:@selector(showSecondPopover:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:showSecondPopoverButton];
}
/**/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
