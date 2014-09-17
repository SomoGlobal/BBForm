//
//  BBListPickerFormElement.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBListPickerFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"

@implementation BBListPickerFormElement

@synthesize labelText = _labelText;
@synthesize index = _index;
@synthesize originalIndex = _originalIndex;
@synthesize values = _values;


+ (id)listPickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
{
    BBListPickerFormElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.values = values;
    return element;
}

+ (id)listPickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values index:(NSInteger)index delegate:(id<BBFormElementDelegate>)delegate;
{
    BBListPickerFormElement *element = [self listPickerElementWithID:elementID labelText:labelText values:values delegate:delegate];
    element.index = index;
    element.originalIndex = index;
    return element;
}

- (Class)cellClass {
    return [BBListPickerFormElementCell class];
}



@end

@interface BBListPickerFormElementCell()
@property (nonatomic, readwrite, retain) UIButton* hiddenButton;
@end


@implementation BBListPickerFormElementCell

@synthesize pickerView = _pickerView;
@synthesize hiddenButton = _hiddenButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.inputControl = [[UITextField alloc] init];
        [self.inputControl setTag:self.element.elementID];

        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.valueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.valueLabel];
        
        UITextField *textField = (UITextField *)self.inputControl;
        [textField setAdjustsFontSizeToFitWidth:YES];
        [textField setMinimumFontSize:10.0f];
        [textField setHidden:YES];
        [textField setInputView:_pickerView];
        [self.contentView addSubview:self.inputControl];
        
        _hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenButton addTarget:self action:@selector(hiddenButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:_hiddenButton];
        
        // add the constraints
        NSDictionary *viewsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.textLabel,@"textLabel",self.valueLabel,@"valueLabel",nil];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[textLabel(==120)]-8-[valueLabel]-10-|" options:(NSLayoutFormatDirectionLeftToRight | NSLayoutFormatAlignAllBaseline) metrics:nil views:viewsDictionary]];
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
    
    self.inputControl.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, NICellContentPadding());
    self.hiddenButton.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, NICellContentPadding());
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    UITextField *textField = (UITextField *)self.inputControl;
    textField.placeholder = nil;
    textField.text = nil;
}

-(void)restoreUndoValue
{
    BBListPickerFormElement* listPickerElement = (BBListPickerFormElement *)self.element;
    listPickerElement.index = listPickerElement.originalIndex;
    self.valueLabel.text = [listPickerElement.values objectAtIndex:listPickerElement.index];
}

-(void)cacheUndoValue
{
    BBListPickerFormElement* listInputElement = (BBListPickerFormElement *)self.element;
    listInputElement.originalIndex = listInputElement.index;
}


-(void)hiddenButtonPressed
{
    [self.inputControl becomeFirstResponder];
}

- (BOOL)shouldUpdateCellWithObject:(BBListPickerFormElement *)valuePickerElement {
    
    if ([super shouldUpdateCellWithObject:valuePickerElement]) {
        UITextField *textField = (UITextField *)self.inputControl;
        textField.inputAccessoryView = valuePickerElement.accessoryView;
        textField.tag = self.tag;
        textField.delegate = valuePickerElement.delegate;
        
        self.textLabel.text = valuePickerElement.labelText;
        self.valueLabel.text = [valuePickerElement.values objectAtIndex:valuePickerElement.index];
        [self.pickerView selectRow:valuePickerElement.index  inComponent:0 animated:NO];
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


#pragma mark -
#pragma mark Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    BBListPickerFormElement *listPickerElement = (BBListPickerFormElement *)self.element;
    self.valueLabel.text = [listPickerElement.values objectAtIndex:row];
    listPickerElement.index = row;
    
    // call the bbdelegate to tell it weve changed
    if ([listPickerElement.delegate respondsToSelector:@selector(formElementDidChangeValue:)])
    {
        [(id<BBFormElementDelegate>)listPickerElement.delegate formElementDidChangeValue:listPickerElement];
    }

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    BBListPickerFormElement *listPickerElement = (BBListPickerFormElement *)self.element;
    return [listPickerElement.values count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    BBListPickerFormElement *listPickerElement = (BBListPickerFormElement *)self.element;
    return [listPickerElement.values objectAtIndex:row];
}


@end
