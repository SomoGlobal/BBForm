//
//  BBValidatedTableViewModel.h
//  monit
//
//  Created by Ashley Thwaites on 22/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "NIMutableTableViewModel.h"

@class BBConditionCollection;

@interface BBValidatedTableViewModel : NIMutableTableViewModel

- (BBConditionCollection *)checkConditions;

@end
