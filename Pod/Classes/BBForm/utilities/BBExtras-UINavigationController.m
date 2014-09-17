//
//  BBExtras-UINavigationController.m
//  iStandApp
//
//  Created by Ashley Thwaites on 07/02/2013.
//  Copyright (c) 2013 Toolbox Design LTD. All rights reserved.
//

/*
 Copied and pasted from David Hamrick's blog:
 
 Source: http://www.davidhamrick.com/2011/12/31/Changing-the-UINavigationController-animation-style.html
 */

#import "BBExtras-UINavigationController.h"

@implementation UINavigationController ( BBExtras )

- (void)pushFadeViewController:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
	[self.view.layer addAnimation:transition forKey:nil];
    
	[self pushViewController:viewController animated:NO];
}

- (void)fadePopViewController
{
	CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
	[self.view.layer addAnimation:transition forKey:nil];
	[self popViewControllerAnimated:NO];
}

@end
