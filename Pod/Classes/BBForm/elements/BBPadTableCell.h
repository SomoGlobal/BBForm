//
//  BBPadTableCell.h
//  BackBone
//
//  Created by Ashley Thwaites on 11/09/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBTableViewCell.h"

@interface BBPadTableCellObject : BBTableViewCellObject

@property (nonatomic, assign) float height;

- (id)initWithHeight:(NSInteger)height;
+ (id)objectWithHeight:(NSInteger)height;

@end


@interface BBPadTableCell : BBTableViewCell


@end
