//
//  BBExtras-NSMutableArray.h
//  AssesmentShell
//
//  Created by Ashley Thwaites on 05/04/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BBExtras-NSMutableArray.h"

@implementation NSMutableArray (BBExtras)

- (void)randomize 
{
    for(NSUInteger i = [self count]; i > 1; i--) 
    {
        NSUInteger j = arc4random()%i;
        [self exchangeObjectAtIndex:i-1 withObjectAtIndex:j];
    }
}

@end
