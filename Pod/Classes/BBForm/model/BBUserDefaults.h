//
//  BBUserDefaults.h
//  BackBone
//
//  Created by Ashley Thwaites on 19/04/2010.
//  Copyright 2010 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBUserDefaults : NSObject
{
	NSMutableDictionary *currentState;
	NSDictionary *defaultsFromFile;
}

+ (BBUserDefaults *)instance;
- (void)save;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;

@end

