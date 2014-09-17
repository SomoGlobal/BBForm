//
//  BBValidatedTableViewModel.m
//  monit
//
//  Created by Ashley Thwaites on 22/10/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBValidatedTableViewModel.h"
#import "BBValidator.h"
#import "BBFormBase.h"
#import "NITableViewModel+Private.h"

@implementation BBValidatedTableViewModel

- (BBConditionCollection *)checkConditions
{
    BBConditionCollection *conditions = nil;
    
    for (NITableViewModelSection* section in self.sections)
    {
        for (BBFormElement* element in section.rows)
        {
            if (![element isKindOfClass:[BBFormElement class]]) {
                continue;
            }
            
            if ([element.validator isKindOfClass:[BBValidator class]])
            {
                BBValidator *validator = (BBValidator*)element.validator;
                
                BBConditionCollection *entryConditions = [validator checkConditions:element];
                if (entryConditions && conditions == nil)
                {
                    conditions = [[BBConditionCollection alloc] init];
                }
                for (id<BBConditionProtocol> condition in entryConditions)
                {
                    [conditions addCondition: condition];
                }

            }
            
        }
    }
    return conditions;
}


@end
