//
//  BBExtras-NIImageMemoryCache.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBExtras-NIImageMemoryCache.h"

@implementation NIImageMemoryCache (BBExtras_NIImageMemoryCache)

-(UIImage*)stretchableImageWithName:(NSString*)imageNamed;
{
    UIImage *image = [self objectWithName:imageNamed];
    if (image == nil)
    {
        image = [UIImage imageNamed:imageNamed];
        if (image)
        {
            image = [image stretchableImageWithLeftCapWidth:(image.size.width/2.0f) topCapHeight:(image.size.height/2.0f)];
            [self storeObject:image withName:imageNamed];
        }
    }
    return image;
}


-(UIImage*)stretchableImageWithName:(NSString*)imageNamed leftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;
{
    UIImage *image = [self objectWithName:imageNamed];
    if (image == nil)
    {
        image = [UIImage imageNamed:imageNamed];
        if (image)
        {
            image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
            [self storeObject:image withName:imageNamed];
        }
    }
    return image;
}

@end
