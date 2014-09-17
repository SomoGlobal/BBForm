//
//  BBTextInputFormElement.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBTextInputFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"


@implementation BBTextInputFormElement

@synthesize labelText = _labelText;
@synthesize placeholderText = _placeholderText;
@synthesize value = _value;
@synthesize originalValue = _originalValue;
@synthesize inputType = _inputType;


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (id)textInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBTextInputFormElement* element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.imageName = imageName;
    element.placeholderText = placeholderText;
    element.value = value;
    element.originalValue = value;
    element.inputType = BBTextInputTypeText;
    return element;
}

+ (id)numberInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBTextInputFormElement* element = [self textInputElementWithID:elementID labelText:labelText imageName:imageName placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = BBTextInputTypeNumber;
    return element;
}

+ (id)passwordInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBTextInputFormElement* element = [self textInputElementWithID:elementID labelText:labelText imageName:imageName placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = BBTextInputTypePassword;
    return element;
}

+ (id)emailInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageName:(NSString*)imageName placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate
{
    BBTextInputFormElement* element = [self textInputElementWithID:elementID labelText:labelText imageName:imageName placeholderText:placeholderText value:value delegate:delegate];
    element.inputType = BBTextInputTypeEmail;
    return element;
}


- (Class)cellClass {
    return [BBTextInputFormElementCell class];
}

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation BBTextInputFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        UITextField *textField = [[UITextField alloc] init];
        self.inputControl = textField;
        
        [textField setTag:self.element.elementID];
        [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [textField setTextAlignment:NSTextAlignmentLeft];
        [textField addTarget:self action:@selector(textFieldDidChangeValue:) forControlEvents:UIControlEventAllEditingEvents];
        [textField setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
        [textField setTextColor:[UIColor colorWithRed:(80.0f/255.0f) green:(80.0f/255.0f) blue:(80.0f/255.0f) alpha:1.0f]];
        [textField setBackgroundColor:[UIColor whiteColor]];

        [self.contentView addSubview:self.inputControl];

        // add the constraints
        NSDictionary *viewsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.textLabel,@"textLabel",self.inputControl,@"textField",nil];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[textLabel(==120)]-8-[textField]-10-|" options:(NSLayoutFormatDirectionLeftToRight | NSLayoutFormatAlignAllBaseline) metrics:nil views:viewsDictionary]];
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


- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    UITextField *textField = (UITextField *)self.inputControl;
    textField.placeholder = nil;
    textField.text = nil;
}

-(void)cacheUndoValue
{
    BBTextInputFormElement* textInputElement = (BBTextInputFormElement *)self.element;
    textInputElement.originalValue = textInputElement.value;
}

-(void)restoreUndoValue
{
    BBTextInputFormElement* textInputElement = (BBTextInputFormElement *)self.element;
    if (textInputElement.originalValue)
    {
        UITextField *textField = (UITextField *)self.inputControl;
        textInputElement.value = textInputElement.originalValue;
        textField.text = textInputElement.value;
    }
}


- (BOOL)shouldUpdateCellWithObject:(BBTextInputFormElement *)textInputElement {
    if ([super shouldUpdateCellWithObject:textInputElement]) {
        UITextField *textField = (UITextField *)self.inputControl;
        textField.placeholder = textInputElement.placeholderText;
        textField.text = textInputElement.value;
        textField.delegate = textInputElement.delegate;
        textField.secureTextEntry = (textInputElement.inputType == BBTextInputTypePassword);
        textField.inputAccessoryView = textInputElement.accessoryView;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        if (textInputElement.inputType == BBTextInputTypeNumber)
        {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        else if (textInputElement.inputType == BBTextInputTypeEmail)
        {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        else
        {
            textField.keyboardType = UIKeyboardTypeDefault;
        }

        textField.tag = self.tag;
        
        self.textLabel.text = textInputElement.labelText;

        if (textInputElement.imageName)
        {
            self.imageView.image = [UIImage imageNamed:textInputElement.imageName];
        }
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


- (IBAction)textFieldDidChangeValue:(id)sender
{
    BBTextInputFormElement* textInputElement = (BBTextInputFormElement *)self.element;
    UITextField *textField = (UITextField *)self.inputControl;
    textInputElement.value = textField.text;
}

@end
