//
//  BBAnimationChain.h
//  TicTacToeVsFriends
//
//  Created by Ash Thwaites on 13/11/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBAnimationStep.h"

@interface BBAnimationChain : NSObject

+(BBAnimationChain*)chain;
+(BBAnimationChain*)chainWithStepArray:(NSArray*)stepArray;
+(BBAnimationChain*)chainWithSteps:(BBAnimationStep*)firstStep, ... NS_REQUIRES_NIL_TERMINATION;

-(void)animate;

@end
