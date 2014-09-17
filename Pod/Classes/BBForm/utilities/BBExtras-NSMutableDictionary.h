//
//  BBExtras-NSMutableDictionary.h
//  BackBone
//
//  Created by Ashley Thwaites on 15/04/2013.
//  Copyright (c) 2013 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableDictionary (BBExtras)

- (void)safelySetObject:(id)anObject forKey:(id <NSCopying>)aKey;

@end