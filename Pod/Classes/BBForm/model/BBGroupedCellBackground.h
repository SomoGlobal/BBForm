//
//  BBGroupedCellBackground.h
//  BackBone
//
//  Created by Ashley Thwaites on 26/02/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BBGroupedCellBackgroundFlagIsLast       = (1 << 0),
    BBGroupedCellBackgroundFlagIsFirst      = (1 << 1),
    BBGroupedCellBackgroundFlagInitialized  = (1 << 2),
} BBGroupedCellBackgroundFlag;

@interface BBGroupedCellBackground : NSObject

@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, strong) UIImage *midImage;
@property (nonatomic, strong) UIImage *botImage;
@property (nonatomic, strong) UIImage *fullImage;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end
