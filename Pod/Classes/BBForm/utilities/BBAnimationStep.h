//
//  BBAnimationStep.h
//  TicTacToeVsFriends
//
//  Created by Ash Thwaites on 13/11/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BBStepAnimationBlock)(void);
typedef void(^BBStepCompletionBlock)(BOOL finished);

@interface BBAnimationStep : NSObject

@property (nonatomic, assign)   NSTimeInterval              duration;
@property (nonatomic, assign)   NSTimeInterval              delay;
@property (nonatomic, assign)   UIViewAnimationOptions      options;
@property (nonatomic, copy)     BBStepAnimationBlock		animationBlock;
@property (nonatomic, copy)     BBStepCompletionBlock		completionBlock;
@property (nonatomic, strong)   BBAnimationStep             *nextStep;

+(BBAnimationStep*) after:(NSTimeInterval)delay
                  animate:(BBStepAnimationBlock)step;

+ (BBAnimationStep*)    for:(NSTimeInterval)duration
                    animate:(BBStepAnimationBlock)step;

+ (BBAnimationStep*) after:(NSTimeInterval)delay
                       for:(NSTimeInterval)duration
                   animate:(BBStepAnimationBlock)step;

+ (BBAnimationStep*) after:(NSTimeInterval)delay
                       for:(NSTimeInterval)duration
                   options:(UIViewAnimationOptions)theOptions
                   animate:(BBStepAnimationBlock)step;

+ (BBAnimationStep*) after:(NSTimeInterval)delay
                       for:(NSTimeInterval)duration
                   options:(UIViewAnimationOptions)theOptions
                   animate:(BBStepAnimationBlock)step
                completion:(BBStepCompletionBlock)stepCompletion;

- (void)animate;

@end
