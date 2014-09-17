//
//  BBTableFormViewController.m
//  BackBone
//
//  Created by Ashley Thwaites on 14/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBTableFormViewController.h"
#import "BBFormCellCatalog.h"

@interface BBTableFormViewController ()

@end

@implementation BBTableFormViewController

@synthesize tableViewController = _tableViewController;
@synthesize tableContainerView = _tableContainerView;
@synthesize inputToolbar = _inputToolbar;
@synthesize prevButton = _prevButton;
@synthesize nextButton = _nextButton;
@synthesize doneButton = _doneButton;
@synthesize cancelButton = _cancelButton;
@synthesize largestElementId;
@synthesize model = _model;
@synthesize currentTextField;

// override setup to build the model
-(void)setup
{
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    [self addChildViewController:self.tableViewController];
    [self.tableContainerView addSubview:self.tableViewController.view];
    self.tableViewController.view.frame  = self.tableContainerView.bounds;
    
    [self resetTableModel];
}

- (void)viewDidUnload
{
    [self setTableViewController:nil];
    [self setTableContainerView:nil];
    [self setPrevButton:nil];
    [self setNextButton:nil];
    [self setDoneButton:nil];
    [self setCancelButton:nil];
    [self setInputToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)resetTableModel
{
    // set the accessory view for every BBFormElement in the model
    largestElementId = 0;
    NSInteger numSections = [_model numberOfSectionsInTableView:nil];
    for (NSInteger section = 0; section < numSections; section++)
    {
        NSInteger numRows = [_model tableView:nil numberOfRowsInSection:section];
        for (NSInteger row = 0; row < numRows; row++)
        {
            id obj = [_model objectAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
            if ([obj isKindOfClass:[BBFormElement class]])
            {
                BBFormElement *el = (BBFormElement*)obj;
                el.accessoryView = self.inputToolbar;
                if (el.elementID > largestElementId)
                    largestElementId = el.elementID;
                
                // preset the cell background type
                BOOL isFirst = (row == 0);
                BOOL isLast = (row == numRows - 1);
                
                el.cellBackgroundFlag = (isFirst ? BBGroupedCellBackgroundFlagIsFirst : 0)
                                         | (isLast ? BBGroupedCellBackgroundFlagIsLast : 0);
            }
        }
    }

    self.tableViewController.tableView.dataSource = _model;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableViewController.view.frame  = self.tableContainerView.bounds;
}

- (IBAction)prevButtonPressed:(id)sender {
    UIView *view = self.currentTextField.superview;
    while (view != nil)
    {
        if ([view isKindOfClass:[BBFormElementCell class]])
        {
            NSIndexPath *path = [self.tableViewController.tableView indexPathForCell:(UITableViewCell*)view];
            if (path)
            {
                NSIndexPath *newPath = nil;
                if (path.row > 0)
                {
                    newPath = [NSIndexPath indexPathForRow:path.row-1 inSection:path.section];
                }
                else if (path.section >0)
                {
                    NSInteger numRows = [_model tableView:nil numberOfRowsInSection:path.section-1];
                    newPath = [NSIndexPath indexPathForRow:numRows-1 inSection:path.section-1];
                }
                
                UITableViewCell *nextCell = [self.tableViewController.tableView cellForRowAtIndexPath:newPath];
                if (nextCell)
                {
                    if ([nextCell isKindOfClass:[BBTextInputFormElementCell class]])
                    {
                        BBTextInputFormElementCell *bbcell = (BBTextInputFormElementCell*)nextCell;
                        [bbcell.inputControl becomeFirstResponder];
                        [self.tableViewController.tableView scrollToRowAtIndexPath:newPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    }
                }
                
            }
            break;
        }
        view = view.superview;
    }
}

- (IBAction)nextButtonPressed:(id)sender {
    
    UIView *view = self.currentTextField.superview;
    while (view != nil)
    {
        if ([view isKindOfClass:[BBFormElementCell class]])
        {
            NSIndexPath *path = [self.tableViewController.tableView indexPathForCell:(UITableViewCell*)view];
            if (path)
            {
                NSInteger numRows = [_model tableView:nil numberOfRowsInSection:path.section];
                NSIndexPath *newPath = nil;
                if (path.row < (numRows-1))
                    newPath = [NSIndexPath indexPathForRow:path.row+1 inSection:path.section];
                else
                    newPath = [NSIndexPath indexPathForRow:0 inSection:path.section+1];
                
                UITableViewCell *nextCell = [self.tableViewController.tableView cellForRowAtIndexPath:newPath];
                if (nextCell)
                {
                    if ([nextCell isKindOfClass:[BBFormElementCell class]])
                    {
                        BBFormElementCell *bbcell = (BBFormElementCell*)nextCell;
                        [bbcell.inputControl becomeFirstResponder];
                        [self.tableViewController.tableView scrollToRowAtIndexPath:newPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    }
                }
                
            }
            break;
        }
        view = view.superview;
    }
    
}

- (IBAction)doneButtonPressed:(id)sender {
    [self.currentTextField resignFirstResponder];
}

- (IBAction)cancelButtonPressed:(id)sender {
    UIView *view = self.currentTextField.superview;
    while (view != nil)
    {
        if ([view isKindOfClass:[BBFormElementCell class]])
        {
            BBFormElementCell *cell = (BBFormElementCell*)view;
            [cell restoreUndoValue];
            break;
        }
        view = view.superview;
    }

    
    [self.currentTextField resignFirstResponder];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.prevButton.enabled = (textField.tag != 0);
    self.nextButton.enabled = (textField.tag != self.largestElementId);
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentTextField   = textField;
    UIView *view = self.currentTextField.superview;
    while (view != nil)
    {
        if ([view isKindOfClass:[BBFormElementCell class]])
        {
            BBFormElementCell *cell = (BBFormElementCell*)view;
            [cell cacheUndoValue];
            break;
        }
        view = view.superview;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    BBFormElement *element = [self.model findBBFormElementWithID:textField.tag];
    [self formElementDidChangeValue:element];
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.prevButton.enabled = (textView.tag != 0);
    self.nextButton.enabled = (textView.tag != self.largestElementId);
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.currentTextField   = textView;
    UIView *view = self.currentTextField.superview;
    while (view != nil)
    {
        if ([view isKindOfClass:[BBFormElementCell class]])
        {
            BBFormElementCell *cell = (BBFormElementCell*)view;
            [cell cacheUndoValue];
            break;
        }
        view = view.superview;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextField *)textView
{
    return YES;
}

- (void)textViewDidEndEditing:(UITextField*)textView
{
    // lets find the element that triggered the value change and call
    BBFormElement *element = [self.model findBBFormElementWithID:textView.tag];
    [self formElementDidChangeValue:element];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.cellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.model];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)formElementDidChangeValue:(BBFormElement *)formElement;
{
    
}

@end
