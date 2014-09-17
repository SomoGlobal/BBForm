//
//  BBTextViewInputFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements


#import "BBFormBase.h"


@interface BBTextViewInputFormElement : BBFormElement

+ (id)textViewInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;

@end


@interface BBTextViewInputFormElementCell : BBFormElementCell
@property (nonatomic, retain) UISwitch* switchControl;
@end

