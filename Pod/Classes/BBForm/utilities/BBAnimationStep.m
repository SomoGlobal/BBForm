//
//  BBAnimationStep.m
//  TicTacToeVsFriends
//
//  Created by Ash Thwaites on 13/11/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBAnimationStep.h"

@implementation BBAnimationStep

@synthesize duration;
@synthesize delay;
@synthesize options;
@synthesize animationBlock;
@synthesize completionBlock;
@synthesize nextStep;



+ (BBAnimationStep*) after:(NSTimeInterval)delay animate:(BBStepAnimationBlock)step
{
	return [self after:delay for:0.0 options:0 animate:step completion:nil];
}

+ (BBAnimationStep*) for:(NSTimeInterval)duration animate:(BBStepAnimationBlock)step
{
    return [self after:0.0 for:duration options:0 animate:step completion:nil];
}

+ (BBAnimationStep*) after:(NSTimeInterval)delay for:(NSTimeInterval)duration animate:(BBStepAnimationBlock)step
{
	return [self after:delay for:duration options:0 animate:step completion:nil];
}

+ (BBAnimationStep*) after:(NSTimeInterval)delay for:(NSTimeInterval)duration options:(UIViewAnimationOptions)theOptions animate:(BBStepAnimationBlock)step;
{
	return [self after:delay for:duration options:theOptions animate:step completion:nil];    
}


+ (BBAnimationStep*) after:(NSTimeInterval)theDelay
                       for:(NSTimeInterval)theDuration
                   options:(UIViewAnimationOptions)theOptions
                   animate:(BBStepAnimationBlock)step
                completion:(BBStepCompletionBlock)stepCompletion
{
	
	BBAnimationStep* instance = [[self alloc] init];
	if (instance) {
		instance.delay = theDelay;
		instance.duration = theDuration;
		instance.options = theOptions;
		instance.animationBlock = [step copy];
        instance.completionBlock = [stepCompletion copy];
	}
	return instance;
}

-(void)dealloc
{
//    NSLog(@"finished");
}


- (void)animate
{
    if (self.animationBlock)
    {
        [UIView animateWithDuration:self.duration
                              delay:self.delay
                            options:self.options
                         animations:self.animationBlock
                         completion:^(BOOL finished)
                            {
                                if (self.completionBlock)
                                    self.completionBlock(finished);
                                if (self.nextStep)
                                    [self.nextStep animate];
                            }];
    }
    else
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (self.delay + self.duration) * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            if (self.completionBlock)
                self.completionBlock(YES);
            if (self.nextStep)
                [self.nextStep animate];
        });
    }
}
@end
