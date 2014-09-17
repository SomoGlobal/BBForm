//
//  BBFormBase.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
//  Based on the NIFormElements, this version has a few extra features
//  i.e. Accessory view so we can add next / prev to page through the form
//  Inherits from BBTableCell so we get nib caching, and metric caching
//  Additional form catalogue

#import "NimbusCore.h"
#import "NimbusModels.h"
#import "BBGroupedCellBackground.h"
#import "BBTableViewCell.h"


UIEdgeInsets BBCellContentPadding(void);

@class BBFormElement;
@protocol BBFormElementDelegate <UITextFieldDelegate, UITextViewDelegate>
- (void)formElementDidChangeValue:(BBFormElement *)formElement;
@end




@interface BBFormElement : NSObject <NICellObject>

// Designated initializer
+ (id)elementWithID:(NSInteger)elementID delegate:(id<BBFormElementDelegate>)delegate;

// leave the validator as id so we are not dependant on the validator headers
@property (nonatomic, retain) id validator;
@property (nonatomic, assign) id<BBFormElementDelegate> delegate;
@property (nonatomic, assign) NSInteger elementID;
@property (nonatomic, retain) UIView* accessoryView;
@property (nonatomic, assign) BBGroupedCellBackgroundFlag cellBackgroundFlag;

@end


@interface BBFormElementCell : BBTableViewCell

@property (nonatomic, readonly, strong) BBFormElement* element;
@property (nonatomic, retain) IBOutlet UIControl* inputControl;

-(void)cacheUndoValue;
-(void)restoreUndoValue;

@end

@interface NITableViewModel (BBFormElementSearch)

// Finds an element in the static table view model with the given element id.
- (id)findBBFormElementWithID:(NSInteger)elementID;

@end

