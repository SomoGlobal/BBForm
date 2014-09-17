//
//  BBLog.h
//  BackBone
//
//  Created by Ashley Thwaites on 24/02/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "DDLog.h"

extern int bbLogLevel;

#define BB_LOG_CONTEXT 80

#define BBLogError(frmt, ...)   LOG_OBJC_MAYBE(LOG_ASYNC_ERROR,   bbLogLevel, LOG_FLAG_ERROR,   BB_LOG_CONTEXT, frmt, ##__VA_ARGS__)
#define BBLogWarn(frmt, ...)    LOG_OBJC_MAYBE(LOG_ASYNC_WARN,    bbLogLevel, LOG_FLAG_WARN,    BB_LOG_CONTEXT, frmt, ##__VA_ARGS__)
#define BBLogInfo(frmt, ...)    LOG_OBJC_MAYBE(LOG_ASYNC_INFO,    bbLogLevel, LOG_FLAG_INFO,    BB_LOG_CONTEXT, frmt, ##__VA_ARGS__)
#define BBLogVerbose(frmt, ...) LOG_OBJC_MAYBE(LOG_ASYNC_VERBOSE, bbLogLevel, LOG_FLAG_VERBOSE, BB_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define BBLog(frmt, ...)    LOG_OBJC_MAYBE(LOG_ASYNC_INFO,    bbLogLevel, LOG_FLAG_INFO,    BB_LOG_CONTEXT, frmt, ##__VA_ARGS__)

