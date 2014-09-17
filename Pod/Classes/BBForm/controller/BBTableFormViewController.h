//
//  BBTableFormViewController.h
//  BackBone
//
//  Created by Ashley Thwaites on 14/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusCore.h"
#import "NimbusModels.h"
#import "BBFormBase.h"

@class BBFormElement;

@interface BBTableFormViewController : UIViewController <BBFormElementDelegate, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableViewController *tableViewController;
@property (weak, nonatomic) IBOutlet UIView *tableContainerView;
@property (strong, nonatomic) IBOutlet UIView *inputToolbar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *prevButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@property (nonatomic, readwrite, retain) NITableViewModel* model;
@property (nonatomic, readwrite, retain) NICellFactory* cellFactory;
@property (nonatomic, readwrite, retain) UIView *currentTextField;

@property (nonatomic, assign) NSInteger largestElementId;

- (IBAction)prevButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

-(void)resetTableModel;

@end
