//
//  BBExtras-NSObject.h
//  BackBone
//
//  Created by Ashley Thwaites on 15/04/2013.
//  Copyright (c) 2013 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BBExtras)

-(void)setValueFromDictionary:(NSDictionary*)dict withKey:(NSString*)withKey forKey:(NSString*)forKey withDefault:(id)defaultValue;

@end
