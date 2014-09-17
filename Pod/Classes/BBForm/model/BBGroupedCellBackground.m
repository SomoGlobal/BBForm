//
//  BBGroupedCellBackground.m
//  BackBone
//
//  Created by Ashley Thwaites on 26/02/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBGroupedCellBackground.h"
#import "BBExtras-NIImageMemoryCache.h"
#import "NIState.h"

@implementation BBGroupedCellBackground

- (id)init {
    if ((self = [super init])) {
        // make this more flexible so we register the images ?
    }
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger numberOfRowsInSection = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
    BOOL isFirst = (0 == indexPath.row);
    BOOL isLast = (indexPath.row == numberOfRowsInSection - 1);
    NSInteger backgroundTag = ((isFirst ? BBGroupedCellBackgroundFlagIsFirst : 0)
                               | (isLast ? BBGroupedCellBackgroundFlagIsLast : 0)
                               | BBGroupedCellBackgroundFlagInitialized);
    if (cell.backgroundView.tag != backgroundTag) {

        if ((backgroundTag & BBGroupedCellBackgroundFlagIsFirst) && (backgroundTag & BBGroupedCellBackgroundFlagIsLast))
        {
            UIImage *image = (self.fullImage != nil) ? self.fullImage : [[Nimbus imageMemoryCache] stretchableImageWithName:@"white_single"];
            cell.backgroundView = [[UIImageView alloc] initWithImage:image];
        }
        else if (backgroundTag & BBGroupedCellBackgroundFlagIsFirst)
        {
            UIImage *image = (self.topImage != nil) ? self.topImage : [[Nimbus imageMemoryCache] stretchableImageWithName:@"white_top"];
            cell.backgroundView = [[UIImageView alloc] initWithImage:image];
        }
        else if (backgroundTag & BBGroupedCellBackgroundFlagIsLast)
        {
            UIImage *image = (self.botImage != nil) ? self.botImage : [[Nimbus imageMemoryCache] stretchableImageWithName:@"white_bottom"];
            cell.backgroundView = [[UIImageView alloc] initWithImage:image];
        }
        else
        {
            UIImage *image = (self.midImage != nil) ? self.midImage : [[Nimbus imageMemoryCache] stretchableImageWithName:@"white_middle"];
            cell.backgroundView = [[UIImageView alloc] initWithImage:image];
        }
        
        cell.backgroundView.tag = backgroundTag;
    }
}

@end
