//
//  BBMultiSelectListFormElement.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBMultiSelectListFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"


@interface BBMultiSelectListCell : UITableViewCell <NICell>
@end

@implementation BBMultiSelectListObject

@synthesize labelText;
@synthesize shortlabelText;

+ (id)listObjectWithName:(NSString *)labelText shortLabel:(NSString *)shortLabel
{
    BBMultiSelectListObject *object = [[BBMultiSelectListObject alloc] init];
    object.labelText = labelText;
    object.shortlabelText = shortLabel;
    return object;
}

- (Class)cellClass
{
    return [BBMultiSelectListCell class];
}

@end



@implementation BBMultiSelectListCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
        self.textLabel.textColor = [UIColor colorWithRed:(51.0f/255.0f) green:(51.0f/255.0f) blue:(51.0f/255.0f) alpha:1.0f];
        self.textLabel.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.accessoryType = (selected) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
}

- (BOOL)shouldUpdateCellWithObject:(id)object {
    BBMultiSelectListObject* listObject = object;
    self.textLabel.text = listObject.labelText;
    return YES;
}

@end



/////////////////////////////////////////////////////////////////////////

@interface BBMultiSelectListFormElement()  

@property (nonatomic, strong)  BBGroupedCellBackground *cellBackground;
@property (nonatomic, strong)  UITableView *inputTableView;

@end

@implementation BBMultiSelectListFormElement

@synthesize labelText = _labelText;
@synthesize model = _model;
@synthesize originalIndexPaths;

+ (id)multiSelectListElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
{
    BBMultiSelectListFormElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
        
    element.model = [[NITableViewModel alloc] initWithListArray:values delegate:nil];
    element.model.delegate = (id)[NICellFactory class];
    element.cellBackground = [[BBGroupedCellBackground alloc] init];
    
    CGRect tableRect = [[UIScreen mainScreen] bounds];
    tableRect.size.height = tableRect.size.height/2.0f;
    element.inputTableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStyleGrouped];
    element.inputTableView.dataSource = element.model;
    element.inputTableView.allowsMultipleSelection = YES;
    return element;
}

+ (id)multiSelectListElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values allSelectedName:(NSString*)allSelectedName noneSelectedName:(NSString*)noneSelectedName delegate:(id<UITextFieldDelegate>)delegate;
{
    BBMultiSelectListFormElement *element = [self multiSelectListElementWithID:elementID labelText:labelText values:values delegate:delegate];
    element.allSelectedName = allSelectedName;
    element.noneSelectedName = noneSelectedName;
    return element;
}

- (Class)cellClass {
    return [BBMultiSelectListFormElementCell class];
}

- (NSArray *)indexPathsForSelectedRows
{
    return [self.inputTableView indexPathsForSelectedRows];
}

- (void)selectRowsAtIndexPaths:(NSArray *)indexPaths
{
    NSArray *selected = [self.inputTableView indexPathsForSelectedRows];
    for (NSIndexPath *path in selected)
    {
        [self.inputTableView deselectRowAtIndexPath:path animated:NO];
    }

    for (NSIndexPath *path in indexPaths)
    {
        [self.inputTableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}


@end




/////////////////////////////////////////////////////////////////////////

@interface BBMultiSelectListFormElementCell() <UITableViewDelegate>
{
    UIButton* hiddenButton;
}
@end

@implementation BBMultiSelectListFormElementCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
//        [textField setInputView:_pickerView];
        [self.contentView addSubview:self.inputControl];
        
        hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [hiddenButton addTarget:self action:@selector(hiddenButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:hiddenButton];
        
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
    
//    self.textField.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, NICellContentPadding());
    hiddenButton.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, NICellContentPadding());
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    UITextField *textField = (UITextField *)self.inputControl;
    textField.placeholder = nil;
    textField.text = nil;
}

-(void)updateValueLabel
{
    // build a string by adding all the shortLabels of the enabled items
    BBMultiSelectListFormElement *listFormElement = (BBMultiSelectListFormElement*)self.element;
    
    int numItems = [listFormElement.inputTableView numberOfRowsInSection:0];
    NSArray *selected = [listFormElement.inputTableView indexPathsForSelectedRows];
    
    if ([selected count] == 0)
    {
        self.valueLabel.text = listFormElement.noneSelectedName;
    }
    else if (numItems == [selected count])
    {
        self.valueLabel.text = listFormElement.allSelectedName;
    }
    else
    {
        NSMutableString *combinedLabels = [[NSMutableString alloc] init];
        for (NSIndexPath *path in selected)
        {
            BBMultiSelectListObject *listObject = [listFormElement.model objectAtIndexPath:path];
            [combinedLabels appendString:listObject.shortlabelText];
            [combinedLabels appendString:@" "];
        }
        self.valueLabel.text = [combinedLabels stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
}

-(void)restoreUndoValue
{
    BBMultiSelectListFormElement *listFormElement = (BBMultiSelectListFormElement*)self.element;
    [listFormElement selectRowsAtIndexPaths:listFormElement.originalIndexPaths];
    [self updateValueLabel];
}

-(void)cacheUndoValue
{
    BBMultiSelectListFormElement *listFormElement = (BBMultiSelectListFormElement*)self.element;
    listFormElement.originalIndexPaths = [listFormElement.inputTableView indexPathsForSelectedRows];
}


-(void)hiddenButtonPressed
{
    [self.inputControl becomeFirstResponder];
}

- (BOOL)shouldUpdateCellWithObject:(BBMultiSelectListFormElement *)multiSelectElement {
    
    if ([super shouldUpdateCellWithObject:multiSelectElement]) {
        
        UITextField *textField = (UITextField *)self.inputControl;
        textField.inputAccessoryView = multiSelectElement.accessoryView;
        textField.tag = self.tag;
        textField.delegate = multiSelectElement.delegate;
        [textField setInputView:multiSelectElement.inputTableView];
        
        multiSelectElement.inputTableView.delegate = self;

        self.textLabel.text = multiSelectElement.labelText;
        self.valueLabel.text = @"Bizare";
        
        [self updateValueLabel];
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)_tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    BBMultiSelectListFormElement *listFormElement = (BBMultiSelectListFormElement*)self.element;
    [listFormElement.cellBackground tableView:_tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    [self updateValueLabel];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)path {
    [self updateValueLabel];
}

@end


