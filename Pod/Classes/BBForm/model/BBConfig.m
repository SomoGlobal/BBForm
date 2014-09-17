//
//  BBConfig.m
//  Backbone
//
//  Created by Ashley Thwaites on 09/02/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBConfig.h"
#import "BBPropertyListCache.h"

@interface BBConfig ()

@property (nonatomic, strong) NSDictionary *defaultConfig;

@end

@implementation BBConfig

+ (BBConfig *)sharedConfig {
    static BBConfig *_sharedConfig = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
                  ^{
                      _sharedConfig = [[[self class] alloc] init];
                      
                      NSString *filePath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
                      NSData *data = [NSData dataWithContentsOfFile:filePath];
                      if (data)
                      {
                          NSError * error = nil;
                          id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                          if (json)
                          {
                              if ([json isKindOfClass:[NSDictionary class]])
                              {
                                  _sharedConfig.defaultConfig = json;
                              }
                          }
                      }                      
                  });
    
    return _sharedConfig;
}

- (id)valueForKey:(NSString*)key fromSection:(NSString*)section
{
    // build the selector string using section?
    // calling a selector means we can return conditional values
	SEL sel = NSSelectorFromString(key);
	if ([self respondsToSelector:sel])
    {
        // supress the memory warning, we assume all methods from config MUST return a +0 object
        // ie dont return anything thats copied
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
		id value;
        if (section)
        {
            value = [self performSelector:sel withObject:section];
        } else {
            value = [self performSelector:sel];
        }
#pragma clang diagnostic pop
        
		if (value)
        {
			return value;
		}
	}
    
    // we didnt get it by calling the method, lets try the embedded json config
    // this config is a duplicate of whats on the server, but just embedded
    if (section)
    {
        NSDictionary *sectionDict = [self.defaultConfig objectForKey:section];
        if (sectionDict)
        {
            id value = [sectionDict objectForKey:key];
            if (value)
                return value;
        }
    }
    else
    {
        id value = [self.defaultConfig objectForKey:key];
        if (value)
            return value;
    }
    
    // still didnt get it, lets try pulling from settings plist
    // these settings are only ever embedded in the app and cant be changed once we ship
    BBPropertyListCache *propertyListCache = [BBPropertyListCache instance];
    BBPropertyList *settings = [propertyListCache getPropertyListForIdentifier:@"Settings"];
    
    if (section)
    {
        NSDictionary *sectionDict = [settings objectForKey:section];
        if (sectionDict)
        {
            return [sectionDict objectForKey:key];
        }
    }
    return [settings objectForKey:key];
}

- (float)floatForKey:(id)key fromSection:(NSString*)section withDefault:(float)defaultValue
{
    id value = [self valueForKey:key fromSection:section];
    if (!value || [value isEqual:[NSNull null]]) return defaultValue;
    return [value floatValue];
}


- (NSInteger)integerForKey:(id)key fromSection:(NSString*)section withDefault:(NSInteger)defaultValue
{
    id value = [self valueForKey:key fromSection:section];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value integerValue];
}

- (NSUInteger)unsignedIntegerForKey:(id)key fromSection:(NSString*)section withDefault:(NSUInteger)defaultValue
{
    id value = [self valueForKey:key fromSection:section];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value unsignedIntegerValue];
}

- (BOOL)boolForKey:(id)key fromSection:(NSString*)section withDefault:(BOOL)defaultValue
{
    id value = [self valueForKey:key fromSection:section];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value boolValue];
}

- (id)objectForKey:(id)key fromSection:(NSString*)section withDefault:(id)defaultValue
{
    id value = [self valueForKey:key fromSection:section];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return value;
}


@end
