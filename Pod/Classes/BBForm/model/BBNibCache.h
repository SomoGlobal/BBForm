//
//  BBNibCache.h
//
//  Created by Ashley Thwaites on 07/03/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NIInMemoryCache.h"

@interface BBNibCache : NIMemoryCache

+ (BBNibCache *)sharedCache;

-(UINib*)nibWithName:(NSString*)nibName;

@end
