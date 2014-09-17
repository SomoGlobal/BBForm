//
//  BBExtras-NSString.m
//  BackBone
//
//  Created by Ashley Thwaites on 07/02/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import "BBExtras-NSString.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (BBExtras)


- (NSString *)stringByTrimmingSuffix:(NSString *)s {
    if([self hasSuffix:s])
		return [self substringToIndex:[self length] - [s length]];
    return self;
}

- (NSString *)stringByTrimmingPrefix:(NSString *)s {
    if([self hasPrefix:s])
		return [self substringFromIndex:[s length]];
    return self;
}

- (NSString *)stringByDecodingPercent
{
	NSMutableString *s = [NSMutableString stringWithString:[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//Also swap plus signs for spaces
	[s replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [s length])];
	return [NSString stringWithString:s];
}

- (NSString *)stringByEncodingPercent
{
	NSMutableString *s = [NSMutableString stringWithString:self];
	[s replaceOccurrencesOfString:@" " withString:@"+" options:NSLiteralSearch range:NSMakeRange(0, [self length])];
	NSString *s1 = [s stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	return s1;
}

- (NSString *) stringByAddingCustomPercent
{
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' || 
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

- (NSString *)stringByMD5Hash
{
    const char *str = [self UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

@end
