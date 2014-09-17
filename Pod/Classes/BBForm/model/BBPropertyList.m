//
//  PropertyList.m
//  BackBone
//
//  Created by Ashley Thwaites on 19/04/2010.
//  Copyright 2010 Ashley Thwaites. All rights reserved.
//

#import "BBPropertyList.h"

@implementation BBPropertyList

@synthesize identifier;
@synthesize items;

- (id)initFromIdentifier:(NSString *)withIdentifier
{
	if (self = [super init])
	{
		self.identifier = withIdentifier;

//		if ([withIdentifier isEqualToString:@"Settings"])
//		{
//			withIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey: @"SettingsFile"];
//		}
		
		NSString *errorDesc = nil;
		NSPropertyListFormat format;
		NSString *plistPath = [[NSBundle mainBundle] pathForResource:withIdentifier ofType:@"plist"];
		NSData *pListXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
		
		items = (NSDictionary *)[NSPropertyListSerialization
								 propertyListFromData:pListXML
								 mutabilityOption:NSPropertyListMutableContainersAndLeaves
								 format:&format errorDescription:&errorDesc];
		
		if (items == nil)
		{
			NSLog(@"%@", errorDesc);
		}
	}
	
	return self;
}

- (id)initFromURL:(NSString *)withURL
{
	if (self = [super init])
	{
		self.identifier = withURL;
		
		NSURL *url = [NSURL URLWithString:withURL];
		
		if (url == nil)
			return nil;
		
		NSError *error = nil;
		NSData *pListXML = [NSData dataWithContentsOfURL:[NSURL URLWithString:withURL] options:NSMappedRead error:&error];

		if (pListXML != nil)
		{
			NSPropertyListFormat format;
			NSString *errorDesc = nil;
			
			items = [NSPropertyListSerialization propertyListFromData:pListXML
													 mutabilityOption:NSPropertyListMutableContainersAndLeaves
															   format:&format errorDescription:&errorDesc];
			
			if (items == nil)
			{
				//NSLog(@"%@", errorDesc);
			}
			else if (![items isKindOfClass:[NSDictionary class]])
			{
				items = nil;
			}
		}
		
	}
	
	return self;
}


- (id)objectForKey:(NSString *)key
{
	if (!items)
		return nil;
	
	return [items objectForKey:key];
}


- (BOOL)hasItems
{
	return (items.count > 0);
}


@end