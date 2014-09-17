//
//  BBTableViewCell.h
//  BackBone
//
//  Created by Ashley Thwaites on 23/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NICellFactory.h"
#import "NICellCatalog.h"

@interface BBTableViewCellObject : NISubtitleCellObject

@property (nonatomic, assign) NSInteger lastButtonTag;

@end


@interface BBTableViewCell : UITableViewCell <NICell>

@property (nonatomic, strong) BBTableViewCellObject *cellObject;

-(void)setup;

-(IBAction)customAccessoryButtonPressed:(id)sender event:(id)event;
-(UITableView *)findTableView;

@end
