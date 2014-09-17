//
//  BBExtras-NSDictionary.m
//  BackBone
//
//  Created by Ashley Thwaites on 15/04/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import "BBExtras-NSDictionary.h"

@implementation NSDictionary (BBExtras)

- (NSString*)localizedStringForKey:(id)aKey
{
	id obj = [self objectForKey:aKey];
	
	if ([obj isKindOfClass:[NSString class]])
	{
		return NSLocalizedString((NSString*)obj,(NSString*)obj);
	}
	return nil;
}

- (float)floatForKey:(id)key withDefault:(float)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value floatValue];
}

- (float)floatForKey:(id)key {
	return [self floatForKey:key withDefault:0];
}


- (double)doubleForKey:(id)key withDefault:(double)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value doubleValue];
}

- (double)doubleForKey:(id)key {
	return [self doubleForKey:key withDefault:0];
}

- (NSInteger)integerForKey:(id)key withDefault:(NSInteger)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value integerValue];
}

- (NSInteger)integerForKey:(id)key {
	return [self integerForKey:key withDefault:0];
}

- (NSUInteger)unsignedIntegerForKey:(id)key withDefault:(NSUInteger)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value unsignedIntegerValue];
}

- (NSUInteger)unsignedIntegerForKey:(id)key {
	return [self unsignedIntegerForKey:key withDefault:0];
}

- (NSNumber *)numberForKey:(id)key withDefaultInteger:(NSInteger)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithInteger:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
	return value;
}

- (NSNumber *)numberForKey:(id)key withDefaultDouble:(double)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithDouble:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
	return value;
}

- (BOOL)boolForKey:(id)key withDefault:(BOOL)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value boolValue];
}

- (BOOL)boolForKey:(id)key {
	return [self boolForKey:key withDefault:NO];
}

- (NSNumber *)boolValueForKey:(id)key withDefault:(BOOL)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithBool:defaultValue];
	return [NSNumber numberWithBool:[value boolValue]];
}

- (NSNumber *)boolValueForKey:(id)key {
	return [self boolValueForKey:key withDefault:NO];
}

- (id)objectForKey:(id)key withDefault:(id)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return value;
}

- (NSDate*)dateEpochFromKey:(id)key withDefault:(NSDate*)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
    
    // value could be a number or a string, but we need an epoch
    if ([value isKindOfClass:[NSNumber class]])
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
        return date;
    }
    return defaultValue;
}

- (NSArray*)arrayForKey:(id)key{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return nil;

    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    return nil;
}

- (NSDictionary*)dictionaryForKey:(id)key{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return nil;
    
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    return nil;
}

- (NSString*)stringForKey:(id)key{
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return nil;
    
    if ([value isKindOfClass:[NSString class]])
    {
        return value;
    }
    return nil;
}

// keypath alternatives
- (NSNumber *)numberForKeyPath:(id)key withDefaultInteger:(NSInteger)defaultValue {
	id value = [self valueForKeyPath:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithInteger:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
	return value;
}

- (NSString *)stringForKeyPath:(id)key withDefault:(NSString*)defaultValue;
{
    id value = [self valueForKeyPath:key];
    if (!value || [value isEqual:[NSNull null]]) return defaultValue;
    NSAssert([value isKindOfClass:[NSString class]], @"Value must be a NSString");
    return value;
}

@end
