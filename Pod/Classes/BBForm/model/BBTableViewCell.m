//
//  BBTableViewCell.m
//  BackBone
//
//  Created by Ashley Thwaites on 23/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//

#import "BBTableViewCell.h"
#import "BBCellInstanceCache.h"


@implementation BBTableViewCellObject

- (Class)cellClass {
    return [BBTableViewCell class];
}

@end


@implementation BBTableViewCell

// override these next 2 methods in subclass
-(void)setup
{
}

-(void)awakeFromNib
{
    [self setup];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}


- (BOOL)shouldUpdateCellWithObject:(id)object {
    if ([object isKindOfClass:[BBTableViewCellObject class]])
    {
        self.cellObject = (BBTableViewCellObject*)object;
    }
    
    return YES;
}


+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
{
    // get a cached instance of this cell type, fill it with the content and return its height
    // perhaps we only want to do that if its a dynamic cell ?
    // if its not dynamic maybe its an optimisation to simply cache the height in a dictionary like we used to ?

    BBTableViewCell *cell = [[BBCellInstanceCache sharedCache] cellWithClass:[self class]];
    [cell shouldUpdateCellWithObject:object];
    
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // contentsize is the default size calcualted by constraints in the xib
    CGSize contentSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    [cell shouldUpdateCellWithObject:object];
    
    return contentSize.height;

}


// following 2 methods allow us to easily add a custom button that proceeds up the chain as
// a accessoryButtonTap message
-(UITableView *) findTableView {
    // iterate up the view hierarchy to find the table containing this cell/view
    UIView *aView = self.superview;
    while(aView != nil) {
        if([aView isKindOfClass:[UITableView class]]) {
            return (UITableView *)aView;
        }
        aView = aView.superview;
    }
    return nil; // this view is not within a tableView
}

// pass the click on the button through as an accessory tap action
- (IBAction)customAccessoryButtonPressed:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    
    self.cellObject.lastButtonTag = ((UIView*)sender).tag;
    UITableView *tableView = [self findTableView];
    if (tableView)
    {
        CGPoint currentTouchPosition = [touch locationInView:tableView];
        NSIndexPath *indexPath = [tableView indexPathForRowAtPoint: currentTouchPosition];
        if (indexPath != nil){
            [tableView.delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
        }
    }
}

@end
