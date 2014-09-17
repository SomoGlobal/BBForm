//
//  BBListPickerFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements

#import "BBFormBase.h"

@interface BBListPickerFormElement : BBFormElement

+ (id)listPickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
+ (id)listPickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger originalIndex;
@property (nonatomic, retain) NSArray *values;

@end


@interface BBListPickerFormElementCell : BBFormElementCell <UIPickerViewDataSource, UIPickerViewDelegate >
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, readwrite, retain) UILabel* valueLabel;
@end


