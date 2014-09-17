//
//  BBExtras-NSDate.h
//  BackBone
//
//  Created by Ashley Thwaites on 06/01/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BBExtras)


- (NSDate *)dateByMovingToBeginningOfDay;
- (NSDate *)dateByMovingToEndOfDay;
- (BOOL)isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
- (NSInteger)sleepsBetween:(NSDate*)endDate;

- (NSString *) humanIntervalSinceNow;


- (NSUInteger)daysAgo;
- (NSUInteger)daysAgoAgainstMidnight;
- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;
- (NSUInteger)weekday;

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;

- (NSString *)string;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSDate *)beginningOfWeek;
- (NSDate *)beginningOfDay;
- (NSDate *)endOfWeek;

+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;

// JSON serialise
- (NSData*) JSONDataRepresentation;

@end