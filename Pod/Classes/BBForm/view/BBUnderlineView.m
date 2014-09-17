//
//  BBUnderlineView.m
//  BackBone
//
//  Created by Ashley Thwaites on 20/08/2013.
//  Copyright (c) 2013 Ashley Thwaites. All rights reserved.
//


// this is a hacky way of getting single pixel lines on ios7.
// its useful because it can be added in interface builder.
// its badly done cos it uses a subview, when it should be just drawn directly in drawrect..

#import "BBUnderlineView.h"

@interface BBUnderlineView ()
{
    UIView *underlineView;
}

@end

@implementation BBUnderlineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(id) init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


-(void) commonInit
{
    // quick hack for a single pixel line.. if it works we should do it in draw rect
    underlineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.25f, self.frame.size.width, 0.5f)];
    underlineView.backgroundColor = self.backgroundColor;
    [super setBackgroundColor:[UIColor clearColor]];
    [self addSubview:underlineView];
}

-(void)layoutSubviews
{
    underlineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - (1.0 - 0.25), self.frame.size.width, 0.5f)];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (underlineView != nil)
    {
        [super setBackgroundColor:[UIColor clearColor]];
        underlineView.backgroundColor = backgroundColor;
    }
    else
    {
        [super setBackgroundColor:backgroundColor];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
