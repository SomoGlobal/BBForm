//
//  BBPadTableCell.m
//  BackBone
//
//  Created by Ashley Thwaites on 11/09/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBPadTableCell.h"

@implementation BBPadTableCellObject

- (id)initWithHeight:(NSInteger)height;
{
    if ((self = [super initWithTitle:nil])) {
        self.cellStyle = UITableViewCellStyleValue1;
        _height = height;
    }
    return self;
}

+ (id)objectWithHeight:(NSInteger)height;
{
    return [[self alloc] initWithHeight:height];
}


- (Class)cellClass {
    return [BBPadTableCell class];
}

@end

@implementation BBPadTableCell

-(void)setup
{    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}


+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
{
    if ([object isKindOfClass:[BBPadTableCellObject class]])
    {
        BBPadTableCellObject *cellObject = (BBPadTableCellObject*)object;
        return cellObject.height;
    }
    
    return [super heightForObject:object atIndexPath:indexPath tableView:tableView];
}
@end
