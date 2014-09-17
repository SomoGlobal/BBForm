//
//  BBExtras-NIImageMemoryCache.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "NIInMemoryCache.h"

@interface NIImageMemoryCache (BBExtras)

-(UIImage*)stretchableImageWithName:(NSString*)imageNamed;
-(UIImage*)stretchableImageWithName:(NSString*)imageNamed leftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;

@end
