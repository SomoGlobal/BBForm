//
//  BBExtras-NSString.h
//  BackBone
//
//  Created by Ashley Thwaites on 07/02/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (BBExtras)

- (NSString *)stringByTrimmingSuffix:(NSString *)s;
- (NSString *)stringByTrimmingPrefix:(NSString *)s;

- (NSString *)stringByDecodingPercent;
- (NSString *)stringByEncodingPercent;
- (NSString *)stringByAddingCustomPercent;
- (NSString *)stringByMD5Hash;

@end