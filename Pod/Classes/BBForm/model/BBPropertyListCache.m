//
//  PropertyListCache.m
//  BackBone
//
//  Created by Ashley Thwaites on 6/3/09.
//  Copyright 2009 Ashley Thwaites. All rights reserved.
//

#import "BBPropertyListCache.h"

@implementation BBPropertyListCache

+ (BBPropertyListCache *)instance
{
	static BBPropertyListCache *instance;
	
	@synchronized(self)
	{
		if (instance == nil)
		{
			instance = [[BBPropertyListCache alloc] init];
		}
	}
	
	return instance;
}

- (id)init
{
	if (self = [super init])
	{	
		propertyLists = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)empty
{
	[propertyLists removeAllObjects];
}

- (BBPropertyList *)getPropertyListForIdentifier:(NSString *)identifier
{

	BBPropertyList *listObj = [propertyLists objectForKey:identifier];
	
	if (listObj == nil)
	{
		listObj = [[BBPropertyList alloc] initFromIdentifier:identifier];
		[propertyLists setObject:listObj forKey:identifier];
	}
	
	return listObj;
}

- (id)getPropertyListObject:(NSString *)identifier forKey:(NSString *)key forRootKey:(NSString*)rootKey
{
	BBPropertyList *listObj = [self getPropertyListForIdentifier:identifier];
	if (listObj)
	{
		if (rootKey != nil)
		{
			NSDictionary *d = [listObj objectForKey:rootKey];
			return [d objectForKey:key];
		}
		else
		{
			return [listObj objectForKey:key];
		}
	}
	return nil;
}

@end
