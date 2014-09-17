//
//  BBNibCache.m
//
//  Created by Ashley Thwaites on 07/03/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBNibCache.h"

@implementation BBNibCache


+ (BBNibCache *)sharedCache {
    static BBNibCache *_instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
                  ^{
                      _instance = [[self alloc] init];
                  });
    
    return _instance;
}

-(UINib*)nibWithName:(NSString*)nibName;
{
    UINib *nib = [self objectWithName:nibName];
    if (nib == nil)
    {
        nib = [UINib nibWithNibName:nibName bundle:nil];
        if (nib)
        {
            [self storeObject:nib withName:nibName];
        }
    }
    return nib;
}

@end
