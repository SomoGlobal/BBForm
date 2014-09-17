//
//  BBSwitchFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements

#import "BBFormBase.h"

@interface BBSwitchFormElement : BBFormElement

+ (id)switchElementWithID:(NSInteger)elementID labelText:(NSString *)labelText value:(BOOL)value  delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, assign) BOOL value;

@end


@interface BBSwitchFormElementCell : BBFormElementCell
@end

