//
//  BBImagePickerFormElement.m
//  BackBone
//
//  Created by Ashley Thwaites on 13/09/2012.
//  Copyright (c) 2012 Ashley Thwaites. All rights reserved.
//

#import "BBImagePickerFormElement.h"
#import "NITableViewModel+Private.h"
#import "NimbusCore.h"
//#import "UIImageView+WebCache.h"

@implementation BBImagePickerFormElement

@synthesize labelText = _labelText;
@synthesize defaultImage = _defaultImage;
@synthesize imageURL = _imageURL;
@synthesize values = _values;


+ (id)imagePickerElementWithID:(NSInteger)elementID labelText:(NSString *)labelText imageURL:(NSURL *)imageURL defaultImage:(UIImage*)defaultImage delegate:(id<BBFormElementDelegate>)delegate;
{
    BBImagePickerFormElement *element = [super elementWithID:elementID delegate:delegate];
    element.labelText = labelText;
    element.imageURL = imageURL;
    element.defaultImage = defaultImage;
    
    NSMutableArray *imageOptionNames = [[NSMutableArray alloc] initWithCapacity:3];
    [imageOptionNames addObject:@"None"];
    [imageOptionNames addObject:@"Camera roll"];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imageOptionNames addObject:@"Camera"];
    }
    element.values = imageOptionNames;
    
    return element;
}

- (Class)cellClass {
    return [BBImagePickerFormElementCell class];
}

@end



@interface BBImagePickerFormElementCell() <UIActionSheetDelegate>
{
    UIImagePickerController *imagePickerController;
    UIPickerView *pickerView;
    UIViewController *_rootViewController;
}

@property (nonatomic, readwrite, retain) UIButton* hiddenButton;

- (void)pickPhoto:(UIImagePickerControllerSourceType)sourceType;

@end


@implementation BBImagePickerFormElementCell

@synthesize hiddenButton = _hiddenButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _hiddenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hiddenButton addTarget:self action:@selector(hiddenButtonPressed) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:_hiddenButton];
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.hiddenButton.frame = UIEdgeInsetsInsetRect(self.contentView.bounds, NICellContentPadding());
    self.imageView.frame = CGRectMake(10.0f, 10.0f, 80.0f, 80.0f);
    self.textLabel.frame = CGRectMake(100.0f, 0.0f, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    UITextField *textField = (UITextField *)self.inputControl;
    textField.placeholder = nil;
    textField.text = nil;
}

-(void)hiddenButtonPressed
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Goal photo"
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                      destructiveButtonTitle:nil
                                           otherButtonTitles:nil];
    
    
    as.delegate = self;
    
    BBImagePickerFormElement *imagePickerElement = (BBImagePickerFormElement *)self.element;
	for (NSString *title in imagePickerElement.values)
    {
        [as addButtonWithTitle:title];
    }
	
	// Add Cancel button
	[as addButtonWithTitle:@"Cancel"];
	as.cancelButtonIndex = as.numberOfButtons -1;
    
	// present the action sheer
    UIViewController *vc = [self rootViewController];
    if (vc.view)
    {
        [as showInView:vc.view];
    }

//    [self.textField becomeFirstResponder];
}

- (BOOL)shouldUpdateCellWithObject:(BBImagePickerFormElement *)valuePickerElement {
    
    if ([super shouldUpdateCellWithObject:valuePickerElement]) {
        
        UITextField *textField = (UITextField *)self.inputControl;
        textField.inputAccessoryView = valuePickerElement.accessoryView;
        textField.tag = self.tag;
        textField.delegate = valuePickerElement.delegate;
        if (valuePickerElement.image)
        {
            self.imageView.image = valuePickerElement.image;
            [pickerView selectRow:1  inComponent:0 animated:NO];
        }
//        else if (valuePickerElement.imageURL)
//        {
//            [self.imageView setImageWithURL:valuePickerElement.imageURL placeholderImage: valuePickerElement.defaultImage];
//            [pickerView selectRow:1  inComponent:0 animated:NO];
//        }
        else
        {
            self.imageView.image = valuePickerElement.defaultImage;
            [pickerView selectRow:0  inComponent:0 animated:NO];
        }
        
        self.textLabel.text = valuePickerElement.labelText;
        
        [self setNeedsLayout];
        return YES;
    }
    return NO;
}

- (UIViewController *)rootViewController {
    
    UIViewController *result = nil;
    
    if (_rootViewController)
    {
        result = _rootViewController;
    }
    else
	{
		// Try to find the root view controller programmically
		
		// Find the top window (that is not an alert view or other window)
		UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
		if (topWindow.windowLevel != UIWindowLevelNormal)
		{
			NSArray *windows = [[UIApplication sharedApplication] windows];
			for(topWindow in windows)
			{
				if (topWindow.windowLevel == UIWindowLevelNormal)
					break;
			}
		}
		
		UIView *rootView = [[topWindow subviews] objectAtIndex:0];
		id nextResponder = [rootView nextResponder];
		
		if ([nextResponder isKindOfClass:[UIViewController class]])
			result = nextResponder;
		else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
            result = topWindow.rootViewController;
		else
			NSAssert(NO, @"BBImagePickerFormElementCell: Could not find a root view controller.");
	}
    return result;
}

#pragma mark -
#pragma mark Actgionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if (buttonIndex != actionSheet.cancelButtonIndex)
    {
        BBImagePickerFormElement *imagePickerElement = (BBImagePickerFormElement *)self.element;
        if (buttonIndex ==0)
        {
            imagePickerElement.image = nil;
            self.imageView.image = imagePickerElement.defaultImage;
        }
        else if (buttonIndex ==1)
        {
            [self pickPhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        else
        {
            [self pickPhoto:UIImagePickerControllerSourceTypeCamera];
        }
    }
}

#pragma mark UIImagePickerControllerDelegate Methods


- (void)pickPhoto:(UIImagePickerControllerSourceType)sourceType {
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }

    [topController presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    BBImagePickerFormElement *imagePickerElement = (BBImagePickerFormElement *)self.element;
    imagePickerElement.image = [info valueForKey:UIImagePickerControllerEditedImage];
    self.imageView.image = imagePickerElement.image;

    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }

    [topController dismissViewControllerAnimated:YES completion:nil];
    imagePickerController = nil;
    [self.inputControl resignFirstResponder];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    [topController dismissViewControllerAnimated:YES completion:nil];
    imagePickerController = nil;
 }


@end

