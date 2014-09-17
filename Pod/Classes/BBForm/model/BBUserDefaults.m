//
//  BBUserDefaults.m
//  BackBone
//
//  Created by Ashley Thwaites on 19/04/2010.
//  Copyright 2010 Ashley Thwaites. All rights reserved.
//

#import "BBUserDefaults.h"
#import "BBPropertyListCache.h"

static NSString *kRestoreLocationKey = @"BackBoneRestoreLocation";

@implementation BBUserDefaults

+ (BBUserDefaults *)instance
{
	static BBUserDefaults *instance;
	
	@synchronized(self)
	{
		if (instance == nil)
		{
			instance = [[BBUserDefaults alloc] init];
		}
	}
	
	return instance;
}

- (id)init
{
	if (self = [super init])
	{
        BBPropertyList *settings = [[BBPropertyListCache instance] getPropertyListForIdentifier:@"Settings"];
        defaultsFromFile = [settings objectForKey:@"UserDefaults"];

		NSMutableDictionary *tempMutableCopy = [[[NSUserDefaults standardUserDefaults] objectForKey:kRestoreLocationKey] mutableCopy];
		currentState = tempMutableCopy;
		
		if (currentState == nil)
		{
			currentState = [[NSMutableDictionary alloc] initWithCapacity:[defaultsFromFile count]];
		}
		
	}
	return self;
}

- (void)save
{
	[[NSUserDefaults standardUserDefaults] setObject:currentState forKey:kRestoreLocationKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)objectForKey:(NSString *)key
{
	id object = [currentState objectForKey:key];
	
	if (object == nil)
	{
		object = [defaultsFromFile objectForKey:key];
		
		if (object == nil)
		{
			return nil;
		}
		
		[currentState setObject:object forKey:key];
	}
	
	return object;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
	[currentState setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
	[currentState removeObjectForKey:key];
}

@end

