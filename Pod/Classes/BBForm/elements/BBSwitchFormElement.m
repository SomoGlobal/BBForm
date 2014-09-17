//
//  BBSwitchFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBSwitchFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"

@implementation BBSwitchFormElement

@synthesize labelText = _labelText;
@synthesize value = _value;

+ (id)switchElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value  delegate:(id<BBFormElementDelegate>)delegate;
{
    BBSwitchFormElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.value = value;
    return element;
}

- (Class)cellClass {
    return [BBSwitchFormElementCell class];
}

@end



@implementation BBSwitchFormElementCell


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        UISwitch *switchControl = [[UISwitch alloc] init];
        self.inputControl = switchControl;

        [switchControl addTarget:self action:@selector(switchDidChangeValue) forControlEvents:UIControlEventValueChanged];
        [switchControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:switchControl];
        
        // add the constraints
        NSDictionary *viewsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.textLabel,@"textLabel",self.inputControl,@"switch",nil];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[textLabel]-[switch]-10-|" options:(NSLayoutFormatDirectionLeftToRight | NSLayoutFormatAlignAllCenterY) metrics:nil views:viewsDictionary]];
        NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.contentView
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.textLabel
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1
                                                               constant:0];
        [self.contentView addConstraint:c1];
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.textLabel.text = nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldUpdateCellWithObject:(BBSwitchFormElement *)switchElement {
    if ([super shouldUpdateCellWithObject:switchElement]) {
        UISwitch *switchControl = (UISwitch*)self.inputControl;
        switchControl.on = switchElement.value;
        self.textLabel.text = switchElement.labelText;
        
        switchControl.tag = self.tag;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)switchDidChangeValue {
    BBSwitchFormElement* switchElement = (BBSwitchFormElement *)self.element;
    UISwitch *switchControl = (UISwitch*)self.inputControl;
    switchElement.value = switchControl.on;

    // call the bbdelegate to tell it weve changed
    if ([switchElement.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)switchElement.delegate formElementDidChangeValue:switchElement];
    }

}

@end


