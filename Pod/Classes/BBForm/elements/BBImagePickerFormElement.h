//
//  BBImagePickerFormElement.h
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//
// extemsions of Nimbus table form elements

#import "BBFormBase.h"

@interface BBImagePickerFormElement : BBFormElement

+ (id)imagePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageURL:(NSURL *)imageURL defaultImage:(UIImage*)defaultImage delegate:(id<BBFormElementDelegate>)delegate;

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) UIImage* defaultImage;
@property (nonatomic, retain) NSURL* imageURL;
@property (nonatomic, retain) NSArray *values;

@end


@interface BBImagePickerFormElementCell : BBFormElementCell <UINavigationControllerDelegate, UIImagePickerControllerDelegate >
@end

