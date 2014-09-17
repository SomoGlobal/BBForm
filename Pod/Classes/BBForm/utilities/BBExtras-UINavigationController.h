//
//  BBExtras-UINavigationController.h
//  iStandApp
//
//  Created by Ashley Thwaites on 07/02/2013.
//  Copyright (c) 2013 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UINavigationController (BBExtras)

- (void)pushFadeViewController:(UIViewController *)viewController;
- (void)fadePopViewController;

@end
