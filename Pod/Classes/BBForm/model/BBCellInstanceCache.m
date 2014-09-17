//
//  BBCellInstanceCache.m
//  BackBone
//
//  Created by Ashley Thwaites on 23/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBCellInstanceCache.h"
#import "BBNibCache.h"
#import "BBTableViewCell.h"
#import "BBLog.h"

@implementation BBCellInstanceCache


+ (BBCellInstanceCache *)sharedCache {
    static BBCellInstanceCache *_instance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
                  ^{
                      _instance = [[self alloc] init];
                  });
    
    return _instance;
}

-(BBTableViewCell*)cellWithClass:(Class)class;
{
    // we only cache instances ot BBTableViewCell
    if (![class isSubclassOfClass:[BBTableViewCell class]])
        return nil;
    
    NSString *className = NSStringFromClass(class);
    BBTableViewCell *cell = [self objectWithName:className];
    if (cell == nil)
    {
        if([[NSBundle mainBundle] pathForResource:className ofType:@"nib"] != nil)
        {
            UINib *nib = [[BBNibCache sharedCache] nibWithName:className];
            if (nib)
            {
                NSArray *objects = [nib instantiateWithOwner:self options:nil];
                if ( (objects.count >0) && [objects[0] isKindOfClass:class])
                {
                    cell = objects[0];
                    [self storeObject:objects[0] withName:className];
                }
            }
        }
        else
        {
            // just create it..
            BBLog(@"Create cell for %@",className);
        }
    }
    return cell;
}

@end
