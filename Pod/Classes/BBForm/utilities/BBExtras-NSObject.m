//
//  BBExtras-NSObject.m
//  BackBone
//
//  Created by Ashley Thwaites on 15/04/2013.
//  Copyright (c) 2013 Toolbox Design LTD. All rights reserved.
//

#import "BBExtras-NSObject.h"
#import <objc/runtime.h>

@implementation NSObject ( BBExtras )

-(void)setValueFromDictionary:(NSDictionary*)dict withKey:(NSString*)withKey forKey:(NSString*)forKey withDefault:(id)defaultValue
{
    objc_property_t property = class_getProperty([self class], [forKey cStringUsingEncoding:NSUTF8StringEncoding]);
    if (!property)
        return;

    const char * type = property_getAttributes(property);
    NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
    
    NSArray * attributes = [typeString componentsSeparatedByString:@","];
    if (attributes.count > 2)
    {
        NSString * typeAttribute = [attributes objectAtIndex:0];
        NSString * propertyType = [typeAttribute substringFromIndex:1];
        const char * rawPropertyType = [propertyType UTF8String];
            
        if ( (strcmp(rawPropertyType, @encode(float)) == 0) ||
             (strcmp(rawPropertyType, @encode(int)) == 0) ||
             (strcmp(rawPropertyType, @encode(BOOL)) == 0))
        {
            //it's an int
            id value = [dict objectForKey:withKey];
            if (!value || [value isEqual:[NSNull null]])
            {
                [self setValue:defaultValue forKey:forKey];
            }
            else
            {
                [self setValue:value forKey:forKey];
            }
        }
        else if (strncmp(rawPropertyType,@encode(id),1) == 0)
        {
            // extract the classname string
            NSArray * comps = [propertyType componentsSeparatedByString:@"\""];
            if (comps.count >2)
            {
                id propClass = NSClassFromString(comps[1]);
                id value = [dict objectForKey:withKey];
                
                if (!value || [value isEqual:[NSNull null]])
                {
                    [self setValue:defaultValue forKey:forKey];
                    return;
                }
                
                if ([value isKindOfClass:propClass])
                {
                    [self setValue:value forKey:forKey];
                    return;
                }
                
                // attempt to remap strings to numbers
                if ([value isKindOfClass:[NSString class]] && (propClass == [NSNumber class]))
                {
                    id remapValue = [NSNumber numberWithDouble:[value doubleValue]];
                    [self setValue:remapValue forKey:forKey];
                    return;
                }
                
                // attempt to remap epoch to date
                if ([value isKindOfClass:[NSNumber class]] && (propClass == [NSDate class]))
                {
                    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
                    [self setValue:date forKey:forKey];
                    return;
                }
                
                // attempt to convert string to date
                if ([value isKindOfClass:[NSString class]] && (propClass == [NSDate class]))
                {
                    
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.'SSSZZZZZ"];
                    NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
                    [df setTimeZone:gmt];
                    
                    NSDate *date = [df dateFromString:value];
                    
                    if (date == nil)
                    {
                        // try another date format
                        [df setDateFormat:@"yyyy-MM"];
                        date = [df dateFromString:value];
                    }
                    
                    [self setValue:date forKey:forKey];
                    return;
                }
                
                [self setValue:defaultValue forKey:forKey];
            }
        }
    }
}
    
@end
