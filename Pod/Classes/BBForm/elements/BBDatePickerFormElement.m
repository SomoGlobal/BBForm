//
//  BBDatePickerFormElement.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBDatePickerFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"

@implementation BBDatePickerFormElement

@synthesize labelText = _labelText;
@synthesize date = _date;
@synthesize originalDate = _originalDate;
@synthesize minDate = _minDate;
@synthesize maxDate = _maxDate;
@synthesize datePickerMode = _datePickerMode;

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode delegate:(id<BBFormElementDelegate>)delegate{
    BBDatePickerFormElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.date = date;
    element.originalDate = date;
    element.datePickerMode = datePickerMode;
    return element;
}

+ (id)datePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText date:(NSDate *)date datePickerMode:(UIDatePickerMode)datePickerMode datePickerMinDate:(NSDate*)mindate datePickerMaxDate:(NSDate*)maxdate delegate:(id<UITextFieldDelegate>)delegate{
    BBDatePickerFormElement *element = [self datePickerElementWithID:elementID labelText:labelText date:date datePickerMode:datePickerMode delegate:delegate];
    element.minDate = mindate;
    element.maxDate = maxdate;
    return element;
}


- (Class)cellClass {
    return [BBDatePickerFormElementCell class];
}


@end

@interface BBDatePickerFormElementCell()
@property (nonatomic, readwrite, retain) UIButton* hiddenButton;
@end


@implementation BBDatePickerFormElementCell

@synthesize datePicker = _datePicker;
@synthesize hiddenButton = _hiddenButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker addTarget:self action:@selector(selectedDateDidChange) forControlEvents:UIControlEventValueChanged];
        
        UITextField *textField = [[UITextField alloc] init];
        self.inputControl = textField;
        
        [textField setTag:self.element.elementID];
        [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [textField setHidden:YES];
        [textField setInputView:_datePicker];
        [self.contentView addSubview:textField];

        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.valueLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.valueLabel];

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
    self.hiddenButton.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, NICellContentPadding());
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    UITextField *textField = (UITextField *)self.inputControl;
    textField.placeholder = nil;
    textField.text = nil;
}

-(void)setDateText
{
    BBDatePickerFormElement *datePickerElement = (BBDatePickerFormElement *)self.element;
    if (datePickerElement.date == nil)
    {
        self.valueLabel.text = @" ";
        return;
    }
    
    if (datePickerElement.formatter)
    {
        self.valueLabel.text = [datePickerElement.formatter stringFromDate:self.datePicker.date];
    }
    else
    {
        
        switch (self.datePicker.datePickerMode) {
            case UIDatePickerModeDate:
                self.valueLabel.text = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                                           dateStyle:NSDateFormatterShortStyle
                                                                           timeStyle:NSDateFormatterNoStyle];
                break;
                
            case UIDatePickerModeTime:
                self.valueLabel.text = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                                           dateStyle:NSDateFormatterNoStyle
                                                                           timeStyle:NSDateFormatterShortStyle];
                break;
                
            case UIDatePickerModeCountDownTimer:
                if (self.datePicker.countDownDuration == 0) {
                    self.valueLabel.text = NSLocalizedString(@"0 minutes", @"0 minutes");
                } else {
                    int hours = (int)(self.datePicker.countDownDuration / 3600);
                    int minutes = (int)((self.datePicker.countDownDuration - hours * 3600) / 60);
                    
                    self.valueLabel.text = [NSString stringWithFormat:
                                                 NSLocalizedString(@"%d hours, %d min",
                                                                   @"datepicker countdown hours and minutes"),
                                                 hours,
                                                 minutes];
                }
                break;
                
            case UIDatePickerModeDateAndTime:
            default:
                self.valueLabel.text = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                                           dateStyle:NSDateFormatterShortStyle
                                                                           timeStyle:NSDateFormatterShortStyle];
                break;
        }
    }
}

-(void)restoreUndoValue
{
    BBDatePickerFormElement *datePickerElement = (BBDatePickerFormElement *)self.element;
    datePickerElement.date = datePickerElement.originalDate;
    if (datePickerElement.date)
        self.datePicker.date = datePickerElement.date;
    [self setDateText];
}

-(void)cacheUndoValue
{
    BBDatePickerFormElement *datePickerElement = (BBDatePickerFormElement *)self.element;
    if (datePickerElement.date)
        datePickerElement.originalDate = datePickerElement.date;
}


-(void)hiddenButtonPressed
{
    [self.inputControl becomeFirstResponder];
}

- (BOOL)shouldUpdateCellWithObject:(BBDatePickerFormElement *)datePickerElement {
        
    if ([super shouldUpdateCellWithObject:datePickerElement]) {
        
        UITextField *textField = (UITextField *)self.inputControl;
        textField.inputAccessoryView = datePickerElement.accessoryView;
        textField.tag = self.tag;
        textField.delegate = datePickerElement.delegate;

        self.textLabel.text = datePickerElement.labelText;
        self.datePicker.datePickerMode = datePickerElement.datePickerMode;
        self.datePicker.minimumDate = datePickerElement.minDate;
        self.datePicker.maximumDate = datePickerElement.maxDate;
        self.datePicker.tag = self.tag;
        if (datePickerElement.date)
            self.datePicker.date = datePickerElement.date;
        [self setDateText];
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}


- (void)selectedDateDidChange {
    self.detailTextLabel.hidden = NO;
    BBDatePickerFormElement *datePickerElement = (BBDatePickerFormElement *)self.element;
    datePickerElement.date = _datePicker.date;
    [self setDateText];
}


@end
