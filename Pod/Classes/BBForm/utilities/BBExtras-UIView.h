//
//  BBExtras-UIView.h
//  BackBone
//
//  Created by Ashley Thwaites on 04/01/2011.
//  Copyright 2011 Toolbox Design LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView (BBExtras)

- (NSString *)moredescription;
- (NSArray*)viewsWithTag:(NSInteger)tag;
- (NSArray*)viewsWithClass:(Class)class;


@end
