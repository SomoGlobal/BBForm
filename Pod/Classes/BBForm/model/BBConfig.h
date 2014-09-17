//
//  BBConfig.h
//  Backbone
//
//  Created by Ashley Thwaites on 09/02/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBConfig : NSObject

+ (BBConfig *)sharedConfig;

- (id)valueForKey:(NSString*)key fromSection:(NSString*)section;

- (float)floatForKey:(id)key fromSection:(NSString*)section withDefault:(float)defaultValue;
- (NSInteger)integerForKey:(id)key fromSection:(NSString*)section withDefault:(NSInteger)defaultValue;
- (NSUInteger)unsignedIntegerForKey:(id)key fromSection:(NSString*)section withDefault:(NSUInteger)defaultValue;
- (BOOL)boolForKey:(id)key fromSection:(NSString*)section withDefault:(BOOL)defaultValue;
- (id)objectForKey:(id)key fromSection:(NSString*)section withDefault:(id)defaultValue;

@end
