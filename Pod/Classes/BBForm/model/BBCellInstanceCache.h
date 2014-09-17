//
//  BBCellInstanceCache.h
//  BackBone
//
//  Created by Ashley Thwaites on 23/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "NIInMemoryCache.h"

@class BBTableViewCell;

@interface BBCellInstanceCache : NIMemoryCache

+ (BBCellInstanceCache *)sharedCache;

-(BBTableViewCell*)cellWithClass:(Class)class;

@end
