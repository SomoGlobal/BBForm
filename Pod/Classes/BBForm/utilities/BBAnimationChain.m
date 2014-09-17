//
//  BBAnimationChain.m
//  TicTacToeVsFriends
//
//  Created by Ash Thwaites on 13/11/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBAnimationChain.h"

#import "BBLog.h"
@interface BBAnimationChain ()

@property (nonatomic, strong) NSArray *steps;

@end



@implementation BBAnimationChain

+(BBAnimationChain*)chain
{
	return [[BBAnimationChain alloc] init];
}



+(BBAnimationChain*)chainWithSteps:(BBAnimationStep*)firstStep, ... // nil-terminated
{
	BBAnimationChain* chain = [BBAnimationChain chain];
    NSMutableArray* tempSteps = [[NSMutableArray alloc] initWithCapacity:10];
    
	va_list args;
	va_start(args, firstStep);
	BBAnimationStep* link = firstStep;
	while (link)
	{
        [tempSteps addObject:link];
		link = va_arg(args, BBAnimationStep*);
	}
	va_end(args);
    chain.steps = [NSArray arrayWithArray:tempSteps];

	return chain;
}

+(BBAnimationChain*)chainWithStepArray:(NSArray*)stepArray
{
    BBAnimationChain* chain = [BBAnimationChain chain];

    chain.steps = stepArray;
    
    
    
    return chain;
}

-(void)animate
{
    // chain the events
    BBAnimationStep *prevStep = nil;
    for (BBAnimationStep *step in self.steps)
    {
        if (prevStep)
            prevStep.nextStep = step;
        prevStep = step;
    }
    
    prevStep = [self.steps objectAtIndex:0];
    [prevStep animate];
}

-(void)dealloc
{
    BBLog(@"dealloc animcation chain");
}
@end
