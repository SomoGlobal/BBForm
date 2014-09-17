//
//  PropertyList.h
//  BackBone
//
//  Created by Ashley Thwaites on 19/04/2010.
//  Copyright 2010 Ashley Thwaites. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface BBPropertyList : NSObject
{
	NSString *identifier;
	NSDictionary *items;
}

@property (retain) NSString *identifier;
@property (readonly) NSDictionary *items;

- (id)initFromIdentifier:(NSString *)withIdentifier;
- (id)initFromURL:(NSString *)withURL;
- (id)objectForKey:(NSString *)key;
- (BOOL)hasItems;

@end
