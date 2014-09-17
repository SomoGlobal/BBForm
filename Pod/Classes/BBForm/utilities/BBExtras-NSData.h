//
//  BBExtras-NSData.h
//  BackBone
//
//  Created by Ashley Thwaites on 19/01/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (BBExtras)

- (NSString *)hexdescription;

// startOffset may be negative, indicating offset from end of data
- (NSString *)hexdescriptionFromOffset:(int)startOffset;
- (NSString *)hexdescriptionFromOffset:(int)startOffset limitingToByteCount:(unsigned int)maxBytes;


@end
