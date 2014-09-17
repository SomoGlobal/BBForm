//
//  PropertyListCache.h
//  BackBone
//
//  Created by Ashley Thwaites on 6/3/09.
//  Copyright 2009 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBPropertyList.h"

@interface BBPropertyListCache : NSObject
{
	NSMutableDictionary *propertyLists;
}

+ (BBPropertyListCache *)instance;
- (void)empty;
- (BBPropertyList *)getPropertyListForIdentifier:(NSString *)identifier;

- (id)getPropertyListObject:(NSString *)identifier forKey:(NSString *)key forRootKey:(NSString*)rootKey;

@end
