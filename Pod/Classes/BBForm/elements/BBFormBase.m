//
//  BBFormBase.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBFormBase.h"
#import "NITableViewModel+Private.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
UIEdgeInsets BBCellContentPadding(void) {
    return UIEdgeInsetsMake(10, 10, 4, 10);
}


@implementation BBFormElement

@synthesize accessoryView = _accessoryView;

+ (id)elementWithID:(NSInteger)elementID delegate:(id<BBFormElementDelegate>)delegate {
    BBFormElement* element = [[self alloc] init];
    element.elementID = elementID;
    element.delegate = delegate;
    return element;
}

- (Class)cellClass {
    // You must implement cellClass in your subclass of this object.
    NIDASSERT(NO);
    return nil;
}

@end

@implementation BBFormElementCell

@synthesize inputControl = _inputControl;
@synthesize element = _element;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];

        self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        self.textLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.textLabel.backgroundColor = [UIColor whiteColor];

        self.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        self.detailTextLabel.textColor = [UIColor colorWithRed:(80.0f/255.0f) green:(80.0f/255.0f) blue:(80.0f/255.0f) alpha:1.0f];
        self.detailTextLabel.backgroundColor = [UIColor whiteColor];

    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];    
    _element = nil;
}


- (BOOL)shouldUpdateCellWithObject:(id)object {
    if (_element != object)
    {
        _element = object;
        self.tag = _element.elementID;
    
        return YES;
    }
    
    return NO;
}


// override this method to reset the cell to the original value
-(void)cacheUndoValue
{
}

-(void)restoreUndoValue
{
}

@end

@implementation NITableViewModel (BBFormElementSearch)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)findBBFormElementWithID:(NSInteger)elementID {
    for (NITableViewModelSection* section in self.sections) {
        for (BBFormElement* element in section.rows) {
            if (![element isKindOfClass:[BBFormElement class]]) {
                continue;
            }
            if (element.elementID == elementID) {
                return element;
            }
        }
    }
    return nil;
}


@end


