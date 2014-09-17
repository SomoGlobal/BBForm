//
//  BBMultiSelectListFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements

#import "BBFormBase.h"

@interface BBMultiSelectListObject : NSObject <NICellObject> 

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, copy) NSString *shortlabelText;

+ (id)listObjectWithName:(NSString *)labelText shortLabel:(NSString *)shortLabel;

@end


@interface BBMultiSelectListFormElement : BBFormElement

+ (id)multiSelectListElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values delegate:(id<BBFormElementDelegate>)delegate;
+ (id)multiSelectListElementWithID:(NSInteger)elementID labelText:(NSString *)labelText values:(NSArray*)values allSelectedName:(NSString*)allSelectedName noneSelectedName:(NSString*)noneSelectedName delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, retain)  NITableViewModel *model;
@property (nonatomic, copy) NSString *allSelectedName;
@property (nonatomic, copy) NSString *noneSelectedName;
@property (nonatomic, retain) NSArray *originalIndexPaths;

- (NSArray *)indexPathsForSelectedRows;
- (void)selectRowsAtIndexPaths:(NSArray *)indexPaths;

@end


@interface BBMultiSelectListFormElementCell : BBFormElementCell
@property (nonatomic, readwrite, retain) UILabel* valueLabel;
@end

