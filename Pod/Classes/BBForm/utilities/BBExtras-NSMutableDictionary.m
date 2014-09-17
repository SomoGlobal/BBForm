//
//  BBExtras-NSMutableDictionary.m
//  BackBone
//
//  Created by Ashley Thwaites on 15/04/2013.
//  Copyright (c) 2013 Toolbox Design LTD. All rights reserved.
//


#import "BBExtras-NSMutableDictionary.h"

@implementation NSMutableDictionary (BBExtras)

- (void)safelySetObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (anObject == nil)
    {
        [self removeObjectForKey:aKey];
    }
    else
    {
        [self setObject:anObject forKey:aKey];
    }
}

@end