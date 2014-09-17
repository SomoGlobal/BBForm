//
//  BBTextViewInputFormElement.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements

#import "BBTextViewInputFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"
#import "BBProtocolInterceptor.h"

@interface BBTextViewInputFormElementCell ()
{
    BBProtocolInterceptor  *interceptor;
}
@end

@implementation BBTextViewInputFormElement

@synthesize labelText = _labelText;
@synthesize value = _value;

+ (id)textViewInputElementWithID:(NSInteger)elementID labelText:(NSString *)labelText placeholderText:(NSString *)placeholderText value:(NSString *)value delegate:(id<BBFormElementDelegate>)delegate;
{
    BBTextViewInputFormElement* element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.placeholderText = placeholderText;
    element.value = value;
    element.originalValue = value;
    return element;
}

- (Class)cellClass {
    return [BBTextViewInputFormElementCell class];
}

@end


@implementation BBTextViewInputFormElementCell

-(void)setup
{
    if (self.inputControl)
    {        
        interceptor = [[BBProtocolInterceptor alloc] initWithInterceptedProtocol:@protocol(UITextViewDelegate)];
        interceptor.middleMan = self;
    }
    
}

-(void)awakeFromNib
{
    [self setup];
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITextField *textField = [[UITextField alloc] init];
        self.inputControl = textField;

        [textField setTag:self.element.elementID];        
        [textField setAdjustsFontSizeToFitWidth:YES];
        [textField setMinimumFontSize:10.0f];
        [textField setTextAlignment:NSTextAlignmentRight];
        [textField setFont:[UIFont fontWithName:@"HelveticaNeue" size:15]];
        [textField setTextColor:[UIColor colorWithRed:(80.0f/255.0f) green:(80.0f/255.0f) blue:(80.0f/255.0f) alpha:1.0f]];
        [textField setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentView addSubview:self.inputControl];
        [self.textLabel removeFromSuperview];
        [self.textLabel setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.textLabel sizeToFit];
    
    UIEdgeInsets pad = BBCellContentPadding();
    pad.left += self.textLabel.frame.origin.x + self.textLabel.frame.size.width;
    
    if (self.imageView.image)
    {
        pad = BBCellContentPadding();
        pad.left += self.imageView.frame.origin.x + self.imageView.frame.size.width;
    }
    
    self.inputControl.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, pad);
}


- (void)prepareForReuse {
    [super prepareForReuse];

    // we need to implement a placeholder label..
    UITextView *textView = (UITextView *)self.inputControl;
    textView.text = nil;
}

-(void)cacheUndoValue
{
    BBTextViewInputFormElement* textInputElement = (BBTextViewInputFormElement *)self.element;
    textInputElement.originalValue = textInputElement.value;
}

-(void)restoreUndoValue
{
    BBTextViewInputFormElement* textInputElement = (BBTextViewInputFormElement *)self.element;
    if (textInputElement.originalValue)
    {
        UITextView *textView = (UITextView *)self.inputControl;
        textInputElement.value = textInputElement.originalValue;
        textView.text = textInputElement.value;
    }
}


- (BOOL)shouldUpdateCellWithObject:(BBTextViewInputFormElement *)textInputElement {
    if ([super shouldUpdateCellWithObject:textInputElement]) {
        UITextView *textView = (UITextView *)self.inputControl;
//        textField.placeholder = textInputElement.placeholderText;
        textView.text = textInputElement.value;
        textView.delegate = (id<UITextViewDelegate>)interceptor;
        textView.inputAccessoryView = textInputElement.accessoryView;
        textView.keyboardType = UIKeyboardTypeDefault;

        interceptor.receiver = textInputElement.delegate;
        
        textView.tag = self.tag;
        
        self.textLabel.text = textInputElement.labelText;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


@end

