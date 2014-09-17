//
//  BBTextInputFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements

#import "BBFormBase.h"

typedef enum {
    BBTextInputTypeText,
    BBTextInputTypeNumber,
    BBTextInputTypePassword,
    BBTextInputTypeEmail
} BBTextInputType;


@interface BBTextInputFormElement : BBFormElement

// Designated initializer
+ (id)textInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
+ (id)numberInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
+ (id)passwordInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
+ (id)emailInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString* labelText;
@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* placeholderText;
@property (nonatomic, copy) NSString* value;
@property (nonatomic, copy) NSString* originalValue;
@property (nonatomic, assign) BBTextInputType inputType;

@end


@interface BBTextInputFormElementCell : BBFormElementCell

- (IBAction)textFieldDidChangeValue:(id)sender;

@end




