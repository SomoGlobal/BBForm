//
//  BBExtras-NSDictionary.h
//  BackBone
//
//  Created by Ashley Thwaites on 15/04/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BBExtras)

- (NSString*)localizedStringForKey:(id)aKey;

- (float)floatForKey:(id)key withDefault:(float)defaultValue;
- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key withDefault:(double)defaultValue;
- (double)doubleForKey:(id)key;
- (NSInteger)integerForKey:(id)key withDefault:(NSInteger)defaultValue;
- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key withDefault:(NSUInteger)defaultValue;
- (NSUInteger)unsignedIntegerForKey:(id)key;
- (NSNumber *)numberForKey:(id)key withDefaultInteger:(NSInteger)defaultValue;
- (NSNumber *)numberForKey:(id)key withDefaultDouble:(double)defaultValue;
- (BOOL)boolForKey:(id)key withDefault:(BOOL)defaultValue;
- (BOOL)boolForKey:(id)key;
- (NSNumber *)boolValueForKey:(id)key withDefault:(BOOL)defaultValue;
- (NSNumber *)boolValueForKey:(id)key;
- (id)objectForKey:(id)key withDefault:(id)defaultValue;
- (NSDate*)dateEpochFromKey:(id)key withDefault:(NSDate*)defaultValue;

- (NSArray*)arrayForKey:(id)key;
- (NSDictionary*)dictionaryForKey:(id)key;
- (NSString*)stringForKey:(id)key;

// keypath alternatives
- (NSNumber *)numberForKeyPath:(id)key withDefaultInteger:(NSInteger)defaultValue;
- (NSString *)stringForKeyPath:(id)key withDefault:(NSString*)defaultValue;

@end